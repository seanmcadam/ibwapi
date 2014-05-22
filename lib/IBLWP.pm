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

# ---------------------------
# get ( [REF]|[IBRecord]|[ObjType + param], search/fields, return fields )
#	Adds or Updates IBRecord(s)
# post ( [ObjType + param] )
#	Adds IBRecord
# put ( [REF]|[IBRecord] )
#	flushes IBRecord
# delete ( [REF]|[IBRecord] )
#	deletes IBRecord
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
sub _parent;
sub _response;     # Returns HTTP::Response Object
sub _reset_search_fields;
sub _add_search_fields;
sub _reset_return_fields;
sub _add_return_fields;
sub _add_return_fields_plus;
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
);

# ---------------------------
# new()
# ---------------------------
sub new() {
    my ( $class, $parent_obj, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    PRINT_MYNAMELINE if $DEBUG;

    #
    # Whose my parent?
    #
    if ( !defined($parent_obj) ) { confess Dumper @_; }
    if ( ref($parent_obj) eq '' || ( !( ref($parent_obj) =~ /^IBWAPI::/ ) ) ) { confess Dumper @_; }
    $h{$_IBLWP_PARENT_OBJ} = $parent_obj;

    if ( !defined( $h{$_JSON_OBJ} = JSON->new() ) )           { confess; }
    if ( !defined( $h{$_UA}       = LWP::UserAgent->new() ) ) { confess; }
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
        if ( 'HASH' ne ref($parm_ref) ) { confess Dumper $parm_ref; }
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
    $self;
}

# ---------------------------
#
# ---------------------------
sub _get_reset {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$_HTTP_REQUEST_OBJ}  = undef;
    $self->{$_HTTP_RESPONSE_OBJ} = undef;
    $self->{$_IBLWP_OBJTYPE}     = undef;
    $self->{$_IBLWP_OBJREF}      = undef;
    $self->_reset_search_fields();
    $self->_reset_return_fields();
}

# ---------------------------
#
# ---------------------------
sub _get_url {
    my ($self)        = @_;
    my @ret           = ();
    my $ret_array_ref = \@ret;

    PRINT_MYNAMELINE if $DEBUG;

    if ( !( ( defined $self->{$_IBLWP_OBJTYPE} ) ^ ( defined $self->{$_IBLWP_OBJREF} ) ) ) { confess Dumper $self ; }

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
        confess Dumper $self;
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

    $self->{$_HTTP_REQUEST_OBJ} = HTTP::Request->new( GET => $self->{$_IBLWP_URL} );
    $self->{$_HTTP_RESPONSE_OBJ} = $self->{$_UA}->request( $self->{_HTTP_REQUEST_OBJ} );

    # Is the response good?
    if ( !$self->is_success() ) {
        PRINT_MYNAMELINE("NO SUCCESS - return 0") if $DEBUG;
        return 0;
    }

    PRINT_MYNAMELINE( "RETURN CODE " . $self->_response()->code() )       if $DEBUG;
    PRINT_MYNAMELINE( "RETURN MESSAGE " . $self->_response()->message() ) if $DEBUG;

    # Is it a JSON Array?
    my $json = decode_json( $self->_response()->content() );

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
        confess "BAD RESPONSE " . Dumper $json;
    }

    print Dumper $record_ref;

    foreach my $ref ( keys(%$record_ref) ) {
        push( @$ret_array_ref, $ref );
        my $ibrec;
        if ( defined( $ibrec = $self->_parent->verify_record($ref) ) ) {
            $ibrec->reload_record( $record_ref->{$ref} );
        }
        else {
            $ibrec = IBRecord->new( $self->_parent, $record_ref->{$ref} );
            $self->_parent->add_rec($ibrec);
        }
    }

    PRINT_MYNAMELINE( "EXIT:" . Dumper $ret_array_ref) if $DEBUG;

    return $ret_array_ref;

}

# ---------------------------
# get() return [_ref,_ref,...]
# And update the parent object IBRecords
#
# WAPI OBJ [+parm]
# IBRecord Obj -> _REF
# _REF
#
# ---------------------------
sub get {
    my ( $self, $parm, $parm_ref, $parm2_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    confess if ( !defined $parm );

    $self->_get_reset();

    if ( ref($parm) eq $PERL_MODULE_IBRECORD ) {
        PRINT_MYNAMELINE if $DEBUG;
        $self->_set_objref( $parm->get_ref() );
        $self->_add_return_fields($parm_ref) if ( defined $parm_ref );
        if ( defined $parm2_ref ) { confess; }
    }
    elsif ( URL_MODULE_EXISTS($parm) ) {
        PRINT_MYNAMELINE if $DEBUG;
        $self->_set_objtype($parm);
        $self->_add_search_fields($parm_ref)       if ( defined $parm_ref );
        $self->_add_return_fields_plus($parm2_ref) if ( defined $parm2_ref );
    }
    elsif ( URL_REF_MODULE_EXISTS($parm) ) {
        PRINT_MYNAMELINE if $DEBUG;
        $self->_set_objtype( URL_REF_MODULE_NAME($parm) );
        $self->_add_search_fields($parm_ref)       if ( defined $parm_ref );
        $self->_add_return_fields_plus($parm2_ref) if ( defined $parm2_ref );
    }
    else {
        confess "BAD PARAMETER:" . Dumper $parm;
    }

    return $self->_get_url;

}

# ---------------------------
# is_success()
# ---------------------------
sub is_success {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        return $self->{$_HTTP_RESPONSE_OBJ}->is_success();
    }
    0;
}

# ---------------------------
# is_error()
# ---------------------------
sub is_error {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        return $self->{$_HTTP_RESPONSE_OBJ}->is_error();
    }
    0;
}

# ---------------------------
# response()
# ---------------------------
sub _response {
    my ($self) = @_;
    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        return $self->{$_HTTP_RESPONSE_OBJ};
    }
    return undef;
}

# ---------------------------
# parent()
# ---------------------------
sub _parent {
    my ($self) = @_;
    if ( defined $self->{$_IBLWP_PARENT_OBJ} ) {
        return $self->{$_IBLWP_PARENT_OBJ};
    }
    return undef;
}

# ---------------------------
#
# ---------------------------
sub _set_objref {
    my ( $self, $r ) = @_;

    # PRINT_MYNAMELINE if $DEBUG;
    print MYNAMELINE . " objref:$r\n" if $DEBUG;

    $self->{$_IBLWP_OBJREF}  = $r;
    $self->{$_IBLWP_OBJTYPE} = undef;
}

# ---------------------------
#
# ---------------------------
sub _set_objtype {
    my ( $self, $t ) = @_;

    # PRINT_MYNAMELINE if $DEBUG;
    print MYNAMELINE . " objtype:$t\n" if $DEBUG;

    URL_MODULE_EXISTS($t);

    $self->{$_IBLWP_OBJTYPE} = $t;
    $self->{$_IBLWP_OBJREF}  = undef;
}

# ---------------------------
#
# ---------------------------
sub _reset_search_fields {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$_IBLWP_SEARCH_FIELDS} = undef;
    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_search_fields {
    my ( $self, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

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
}

# ---------------------------
#
# ---------------------------
sub _reset_return_fields {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$_IBLWP_RETURN_FIELDS}      = undef;
    $self->{$_IBLWP_RETURN_FIELDS_PLUS} = undef;
    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_return_fields {
    my ( $self, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

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

    $self;
}

# ---------------------------
#
# ---------------------------
sub _add_return_fields_plus {
    my ( $self, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

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

    $self;

}

1;
