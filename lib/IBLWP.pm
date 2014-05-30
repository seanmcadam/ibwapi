#!/usr/bin/perl

package IBLWP;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use IBRecord;
use Data::Dumper;
use Carp;
use JSON;
use LWP;
use LWP::UserAgent;
use HTTP::Request;
use Readonly;
use strict;

use base qw( Exporter );

# ---------------------------
# get ( [REF]|[IBRecord]|[ObjType + param], search/fields, return fields )
#	Adds or Updates IBRecord(s)
#
#	Create or Populates existing IBRecords with returned data
#	Returns an array of REFs
#
# post ( [ObjType + param] )
#	Adds IBRecord
#	(Future) Create new record
#	Returns REF
#
# put ( [REF]|[IBRecord] )
#	flushes IBRecord
#	(Future) Pushes updated fields back to the server
#	Returns REF
#
# delete ( [REF]|[IBRecord] )
#	deletes IBRecord
#	Deleted the record from the server
#	Returns 1/0
#
# get_ref ( REF, [FIELDS] )
#	Sends request to server for the ref object
#
# ---------------------------

# ---------------------------
# PROTOTYPES
# ---------------------------
sub get;
sub is_success;    # Returns HTTP::Response->is_success()
sub is_error;      # Returns HTTP::Response->is_error()

sub _parent;       # Returns parent object
sub _response;     # Returns HTTP::Response Object
sub _add_search_fields;
sub _add_return_fields;
sub _add_return_fields_plus;
sub _reset_search_fields;
sub _reset_return_fields;
sub _get_reset;
sub _get_url;
sub _set_objref;
sub _set_objtype;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_HTTPS                    => 'https://';
Readonly our $_JSON                     => 'json';
Readonly our $_URI                      => '/wapi/v1.2/';
Readonly our $_LAST_REQUEST             => '_LAST_REQUEST';
Readonly our $_JSON_OBJ                 => '_JSON_OBJ';
Readonly our $_HTTP_REQUEST_OBJ         => '_HTTP_REQUEST_OBJ';
Readonly our $_HTTP_RESPONSE_OBJ        => '_HTTP_RESPONSE_OBJ';
Readonly our $_UA                       => '_UA';
Readonly our $_UA_AGENT                 => 'IBWAPI/$IB_VERSION ';
Readonly our $_DEFAULT_USERNAME         => 'admin';
Readonly our $_DEFAULT_PASSWORD         => 'password';
Readonly our $_DEFAULT_HOSTNAME         => 'localhost';
Readonly our $_DEFAULT_RETURN_TYPE      => $_JSON;
Readonly our $_DEFAULT_MAX_RESULTS      => 5000;
Readonly our $_IBLWP_PARENT_OBJ         => '_IBLWP_PARENT_OBJ';
Readonly our $_IBLWP_BASE_URL           => '_IBLWP_BASE_URL';
Readonly our $_IBLWP_URL                => '_IBLWP_URL';
Readonly our $_IBLWP_USERNAME           => '_IBLWP_USERNAME';
Readonly our $_IBLWP_PASSWORD           => '_IBLWP_PASSWORD';
Readonly our $_IBLWP_HOSTNAME           => '_IBLWP_HOSTNAME';
Readonly our $_IBLWP_OBJREF             => '_IBLWP_OBJREF';
Readonly our $_IBLWP_OBJTYPE            => '_IBLWP_OBJTYPE';
Readonly our $_IBLWP_MAX_RESULTS        => '_IBLWP_MAX_RESULTS';
Readonly our $_IBLWP_RETURN_TYPE        => '_IBLWP_RETURN_TYPE';
Readonly our $_IBLWP_SEARCH_FIELDS      => '_IBLWP_SEARCH_FIELDS';
Readonly our $_IBLWP_RETURN_FIELDS      => '_IBLWP_RETURN_FIELDS';
Readonly our $_IBLWP_RETURN_FIELDS_PLUS => '_IBLWP_RETURN_FIELDS_PLUS';

Readonly our $IBLWP_GET_RECORD          => 'IBLWP_GET_RECORD';
Readonly our $IBLWP_GET_OBJTYPE         => 'IBLWP_GET_OBJTYPE';
Readonly our $IBLWP_GET_SEARCH_REF      => 'IBLWP_GET_SEARCH_REF';
Readonly our $IBLWP_GET_RETURN_REF      => 'IBLWP_GET_RETURN_REF';
Readonly our $IBLWP_GET_RETURN_PLUS_REF => 'IBLWP_GET_RETURN_PLUS_REF';

Readonly::Hash our %_NEW_PARM_NAMES => (
    $IB_USERNAME           => $_IBLWP_USERNAME,
    $IB_PASSWORD           => $_IBLWP_PASSWORD,
    $IB_HOSTNAME           => $_IBLWP_HOSTNAME,
    $IB_MAX_RESULTS        => $_IBLWP_MAX_RESULTS,
    $IB_RETURN_TYPE        => $_IBLWP_RETURN_TYPE,
    $IB_RETURN_FIELDS      => $_IBLWP_RETURN_FIELDS,
    $IB_RETURN_FIELDS_PLUS => $_IBLWP_RETURN_FIELDS_PLUS,
);

Readonly::Hash our %_PARM_NAMES => (
    $IB_MAX_RESULTS        => $_IBLWP_MAX_RESULTS,
    $IB_RETURN_TYPE        => $_IBLWP_RETURN_TYPE,
    $IB_RETURN_FIELDS      => $_IBLWP_RETURN_FIELDS,
    $IB_RETURN_FIELDS_PLUS => $_IBLWP_RETURN_FIELDS_PLUS,
);

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $IBLWP_GET_RECORD
  $IBLWP_GET_OBJTYPE
  $IBLWP_GET_SEARCH_REF
  $IBLWP_GET_RETURN_REF
  $IBLWP_GET_RETURN_PLUS_REF
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parent_obj, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    LOG_ENTER_SUB;

    #
    # Whose my parent?
    #
    defined($parent_obj) || LOG_FATAL;
    defined($parm_ref)   || LOG_FATAL;
    ( ref($parent_obj) ne '' && ( ref($parent_obj) =~ /^IBWAPI::/ ) ) || LOG_FATAL " " . ref($parent_obj);
    ref($parm_ref) eq 'HASH' || LOG_FATAL;

    $h{$_IBLWP_PARENT_OBJ} = $parent_obj;

    defined( $h{$_JSON_OBJ} = JSON->new() )           || LOG_FATAL;
    defined( $h{$_UA}       = LWP::UserAgent->new() ) || LOG_FATAL;
    $h{$_UA}->agent($_UA_AGENT);
    $h{$_HTTP_RESPONSE_OBJ} = undef;
    $h{$_HTTP_REQUEST_OBJ}  = undef;

    $h{$_IBLWP_USERNAME}           = $_DEFAULT_USERNAME;
    $h{$_IBLWP_PASSWORD}           = $_DEFAULT_PASSWORD;
    $h{$_IBLWP_HOSTNAME}           = $_DEFAULT_HOSTNAME;
    $h{$_IBLWP_MAX_RESULTS}        = $_DEFAULT_MAX_RESULTS;
    $h{$_IBLWP_RETURN_TYPE}        = $_DEFAULT_RETURN_TYPE;
    $h{$_IBLWP_OBJREF}             = undef;
    $h{$_IBLWP_OBJTYPE}            = undef;
    $h{$_IBLWP_SEARCH_FIELDS}      = undef;
    $h{$_IBLWP_RETURN_FIELDS}      = undef;
    $h{$_IBLWP_RETURN_FIELDS_PLUS} = undef;

    $h{$_LAST_REQUEST} = '';

    if ( defined $parm_ref ) {
        foreach my $p ( sort( keys(%$parm_ref) ) ) {
            if ( !defined $_NEW_PARM_NAMES{$p} ) { next; }
            $h{ $_NEW_PARM_NAMES{$p} } = $parm_ref->{$p};
        }
    }

    $h{$_IBLWP_BASE_URL} = $_HTTPS
      . $h{$_IBLWP_USERNAME} . ':'
      . $h{$_IBLWP_PASSWORD} . '@'
      . $h{$_IBLWP_HOSTNAME}
      . $_URI;

    bless $self, $class;

    LOG_EXIT_SUB;

    $self;
}

# ---------------------------
# get( {params} ) return [_ref,_ref,...]
# And update the parent object IBRecords
#
# WAPI OBJ [+search fields] [+return fields]
# IBRecord Obj [+return fields]
# _REF
#
# ---------------------------
sub get {
    my ( $self, $parm_ref ) = @_;

    LOG_ENTER_SUB;

    defined $parm_ref || LOG_FATAL;

    $self->_get_reset();

    #
    # Get generic Object record, with optional Search Parameters
    #
    if ( defined $parm_ref->{$IBLWP_GET_OBJTYPE} ) {
        my $type;

        LOG_DEBUG4( " GOT OBJTYPE: " . $parm_ref->{$IBLWP_GET_OBJTYPE} );

        if ( URL_MODULE_EXISTS( $parm_ref->{$IBLWP_GET_OBJTYPE} ) ) {
            $self->_set_objtype( $parm_ref->{$IBLWP_GET_OBJTYPE} );
        }
        elsif ( URL_REF_MODULE_EXISTS( $parm_ref->{$IBLWP_GET_OBJTYPE} ) ) {
            $self->_set_objtype( URL_REF_MODULE_NAME( $parm_ref->{$IBLWP_GET_OBJTYPE} ) );
        }
        else {
            LOG_FATAL " GOT OBJTYPE: " . $parm_ref->{$IBLWP_GET_OBJTYPE};
        }

        $self->_set_objtype( $parm_ref->{$IBLWP_GET_OBJTYPE} );

        if ( defined $parm_ref->{$IBLWP_GET_SEARCH_REF} ) {
            $self->_add_search_fields( $parm_ref->{$IBLWP_GET_SEARCH_REF} );
        }
    }

    #
    # Get IBRecord ( OBJ, REF )
    #
    elsif ( defined $parm_ref->{$IBLWP_GET_RECORD} ) {

        LOG_DEBUG4 " GOT REF: " . ref( $parm_ref->{$IBLWP_GET_RECORD} );

        ref( $parm_ref->{$IBLWP_GET_RECORD} ) eq $PERL_MODULE_IBRECORD || LOG_FATAL( " " . ref( $parm_ref->{$IBLWP_GET_RECORD} ) );
        defined $parm_ref->{$IBLWP_GET_SEARCH_REF} && LOG_FATAL;

        $self->_set_objref( $parm_ref->{$IBLWP_GET_RECORD}->get_ref() );
    }
    else {
        LOG_FATAL " NO RECORD TYPE SPECIFIED ";
    }

    if ( defined $parm_ref->{$IBLWP_GET_RETURN_REF} ) {
        $self->_add_return_fields( $parm_ref->{$IBLWP_GET_RETURN_REF} );
    }
    if ( defined $parm_ref->{$IBLWP_GET_RETURN_PLUS_REF} ) {
        $self->_add_return_fields_plus( $parm_ref->{$IBLWP_GET_RETURN_PLUS_REF} );
    }

    my $ret = $self->_get_url;

    LOG_EXIT_SUB;

    return $ret;

}

# ---------------------------
#
# ---------------------------
sub _get_reset {
    my ($self) = @_;

    LOG_ENTER_SUB;

    $self->{$_HTTP_REQUEST_OBJ}  = undef;
    $self->{$_HTTP_RESPONSE_OBJ} = undef;
    $self->{$_IBLWP_OBJTYPE}     = undef;
    $self->{$_IBLWP_OBJREF}      = undef;
    $self->_reset_search_fields();
    $self->_reset_return_fields();

    LOG_EXIT_SUB;

}

# ---------------------------
#
# ---------------------------
sub _get_url {
    my ($self)        = @_;
    my @ret           = ();
    my $ret_array_ref = \@ret;

    LOG_ENTER_SUB;

    ( ( defined $self->{$_IBLWP_OBJTYPE} ) ^ ( defined $self->{$_IBLWP_OBJREF} ) ) || LOG_FATAL;

    if ( defined $self->{$_IBLWP_OBJTYPE} ) {
        $self->{$_IBLWP_URL} =
          $self->{$_IBLWP_BASE_URL}
          . URL_MODULE_NAME( $self->{$_IBLWP_OBJTYPE} )
          . '?'
          . URL_PARM_NAME($IB_RETURN_TYPE)
          . '='
          . $_JSON
          . '&'
          . URL_PARM_NAME($IB_MAX_RESULTS)
          . '='
          . $self->{$_IBLWP_MAX_RESULTS}
          ;
    }
    elsif ( defined $self->{$_IBLWP_OBJREF} ) {
        $self->{$_IBLWP_URL} =
          $self->{$_IBLWP_BASE_URL}
          . $self->{$_IBLWP_OBJREF}
          . '?'
          . URL_PARM_NAME($IB_RETURN_TYPE)
          . '='
          . $_JSON
          . '&'
          . URL_PARM_NAME($IB_MAX_RESULTS)
          . '='
          . $self->{$_IBLWP_MAX_RESULTS}
          ;
    }
    else {
        LOG_FATAL;
    }

    if ( defined $self->{$_IBLWP_RETURN_FIELDS} ) {
        $self->{$_IBLWP_URL} .=
          '&'
          . URL_PARM_NAME($IB_RETURN_FIELDS)
          . '='
          . ( join( ',', ( map { URL_FIELD_NAME($_) } sort( keys( %{ $self->{$_IBLWP_RETURN_FIELDS} } ) ) ) ) )
          ;
    }
    elsif ( defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        $self->{$_IBLWP_URL} .=
          '&'
          . URL_PARM_NAME($IB_RETURN_FIELDS_PLUS)
          . '='
          . ( join( ',', ( map { URL_FIELD_NAME($_) } sort( keys( %{ $self->{$_IBLWP_RETURN_FIELDS_PLUS} } ) ) ) ) )
          ;
    }

    if ( defined $self->{$_IBLWP_SEARCH_FIELDS} ) {
        foreach my $s ( sort( keys( %{ $self->{$_IBLWP_SEARCH_FIELDS} } ) ) ) {
            $self->{$_IBLWP_URL} .=
              '&'
              . URL_FIELD_NAME($s)
              . URL_SEARCH_NAME( $self->{$_IBLWP_SEARCH_FIELDS}->{$s}->[0] )
              . $self->{$_IBLWP_SEARCH_FIELDS}->{$s}->[1]
              ;
        }
    }

    LOG_DEBUG4 " SEND URL: " . $self->{$_IBLWP_URL};

    $self->{$_HTTP_REQUEST_OBJ} = HTTP::Request->new( GET => $self->{$_IBLWP_URL} );
    $self->{$_HTTP_RESPONSE_OBJ} = $self->{$_UA}->request( $self->{_HTTP_REQUEST_OBJ} );

    # Is the response good?
    if ( $self->is_success() ) {

        LOG_DEBUG2( "RETURN CODE " . $self->_response()->code() );
        LOG_DEBUG2( "RETURN MESSAGE " . $self->_response()->message() );

        # Is it a JSON Array?
        my $json = decode_json( $self->_response()->content() );

        LOG_DEBUG4( "RETURN JSON " . Dumper $json );
        my $record_ref;

        # Is this an array?
        if ( ref($json) eq 'ARRAY' ) {
            $record_ref = CONVERT_JSON_ARRAY_TO_IB_FORMAT($json);
        }

        # Is this a hash (single value)?
        elsif ( ref($json) eq 'HASH' ) {
            $record_ref = CONVERT_JSON_HASH_TO_IB_FORMAT($json);
        }

        # What the hell is it?
        else {
            LOG_FATAL "BAD JSON RESPONSE " . Dumper $json;
        }

        foreach my $ref ( keys(%$record_ref) ) {
            LOG_DEBUG4( "REF " . $ref );

            push( @$ret_array_ref, $ref );

            LOG_DEBUG4 Dumper $record_ref->{$ref} ;

            my $ibrec;
            if ( defined( $ibrec = $self->_parent->verify_record($ref) ) ) {
                $ibrec->reload_record( $record_ref->{$ref} );
            }
            else {
                $ibrec = IBRecord->new( $self->_parent, $record_ref->{$ref} );
                $self->_parent->add_ib_record($ibrec);
            }
        }
    }

    LOG_EXIT_SUB;

    return $ret_array_ref;

}

# ---------------------------
# is_success()
# ---------------------------
sub is_success {
    my ($self) = @_;
    my $ret = 0;

    LOG_ENTER_SUB;

    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        $ret = $self->{$_HTTP_RESPONSE_OBJ}->is_success();
    }
    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------
# is_error()
# ---------------------------
sub is_error {
    my ($self) = @_;
    my $ret = 0;

    LOG_ENTER_SUB;

    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        $ret = $self->{$_HTTP_RESPONSE_OBJ}->is_error();
    }

    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------
# response()
# ---------------------------
sub _response {
    my ($self) = @_;
    my $ret = undef;

    LOG_ENTER_SUB;

    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        $ret = $self->{$_HTTP_RESPONSE_OBJ};
    }

    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------
# parent()
# ---------------------------
sub _parent {
    my ($self) = @_;
    my $ret = undef;

    LOG_ENTER_SUB;

    if ( defined $self->{$_IBLWP_PARENT_OBJ} ) {
        $ret = $self->{$_IBLWP_PARENT_OBJ};
    }
    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------
#
# ---------------------------
sub _set_objref {
    my ( $self, $r ) = @_;

    LOG_ENTER_SUB;

    $self->{$_IBLWP_OBJREF}  = $r;
    $self->{$_IBLWP_OBJTYPE} = undef;
    LOG_EXIT_SUB;
}

# ---------------------------
#
# ---------------------------
sub _set_objtype {
    my ( $self, $t ) = @_;

    LOG_ENTER_SUB;

    $self->{$_IBLWP_OBJTYPE} = $t;
    $self->{$_IBLWP_OBJREF}  = undef;
    LOG_EXIT_SUB;
}

# ---------------------------
#
# ---------------------------
sub _reset_search_fields {
    my ($self) = @_;

    LOG_ENTER_SUB;

    $self->{$_IBLWP_SEARCH_FIELDS} = undef;
    LOG_EXIT_SUB;
    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_search_fields {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    if ( ref($f) eq 'HASH' ) {
        foreach my $k ( keys(%$f) ) {
            $self->{$_IBLWP_SEARCH_FIELDS}->{$k} = $f->{$k};
        }
    }
    elsif ( ref($f) eq 'ARRAY' ) {
        foreach my $k (@$f) {
            $self->{$_IBLWP_SEARCH_FIELDS}->{$k} = $f->{$k};
        }
    }
    else {
        $self->{$_IBLWP_SEARCH_FIELDS}->{$f} = 1;
    }
    LOG_EXIT_SUB;
}

# ---------------------------
#
# ---------------------------
sub _reset_return_fields {
    my ($self) = @_;

    LOG_ENTER_SUB;

    $self->{$_IBLWP_RETURN_FIELDS}      = undef;
    $self->{$_IBLWP_RETURN_FIELDS_PLUS} = undef;
    LOG_EXIT_SUB;
    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_return_fields {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    if ( defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        $self->{$_IBLWP_RETURN_FIELDS_PLUS} = undef;
    }

    if ( !defined $self->{$_IBLWP_RETURN_FIELDS} ) {
        my %h;
        $self->{$_IBLWP_RETURN_FIELDS} = \%h;
    }

    if ( ref($f) eq 'HASH' ) {
        foreach my $k ( keys(%$f) ) {
            $self->{$_IBLWP_RETURN_FIELDS}->{$k}++;
        }
    }
    elsif ( ref($f) eq 'ARRAY' ) {
        foreach my $k (@$f) {
            $self->{$_IBLWP_RETURN_FIELDS}->{$k}++;
        }
    }
    else {
        $self->{$_IBLWP_RETURN_FIELDS}->{$f}++;
    }

    LOG_EXIT_SUB;
    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_return_fields_plus {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    if ( defined $self->{$_IBLWP_RETURN_FIELDS} ) {
        $self->{$_IBLWP_RETURN_FIELDS} = undef;
    }
    if ( !defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        my %h;
        $self->{$_IBLWP_RETURN_FIELDS_PLUS} = \%h;
    }

    if ( ref($f) eq 'HASH' ) {
        foreach my $k ( keys(%$f) ) {
            $self->{$_IBLWP_RETURN_FIELDS_PLUS}->{$k}++;
        }
    }
    elsif ( ref($f) eq 'ARRAY' ) {
        foreach my $k (@$f) {
            $self->{$_IBLWP_RETURN_FIELDS_PLUS}->{$k}++;
        }
    }
    else {
        $self->{$_IBLWP_RETURN_FIELDS_PLUS}->{$f}++;
    }

    LOG_EXIT_SUB;
    $self;

}

1;
