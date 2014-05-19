#!/usr/bin/perl

package IBLWP;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use Data::Dumper;
use Carp;
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
sub get_objref;     #
sub get_objtype;    #
sub response;       # Returns HTTP::Response Object
sub is_success;     # Returns HTTP::Response->is_success()
sub is_error;       # Returns HTTP::Response->is_error()
sub _reset_search_fields;
sub _add_search_fields;
sub _reset_return_fields;
sub _add_return_fields;
sub _add_return_fields_plus;

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
    my ($self) = @_;

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
          . ( join( ',', ( sort( keys( %{$self->{$_IBLWP_RETURN_FIELDS}} ) ) ) ) )
          ;
    }
    elsif ( defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        $self->{$_IBLWP_URL} .=
          '&'
          . URL_PARM_NAME($IB_RETURN_FIELDS_PLUS)
          . '='
          . ( join( ',', ( sort( keys( %{$self->{$_IBLWP_RETURN_FIELDS_PLUS}} ) ) ) ) )
          ;
    }

    if ( defined $self->{$_IBLWP_SEARCH_FIELDS} ) {
        foreach my $s ( sort( keys( %{$self->{$_IBLWP_SEARCH_FIELDS}} ) ) ) {
            $self->{$_IBLWP_URL} .=
              '&'
              . URL_FIELD_NAME($s)
              . '='
              . $self->{$_IBLWP_SEARCH_FIELDS}->{$s}
              ;
        }
    }

print $self->{$_IBLWP_URL} . "\n";

    $self->{$_HTTP_REQUEST_OBJ} = HTTP::Request->new( GET => $self->{$_IBLWP_URL} );
    $self->{$_HTTP_RESPONSE_OBJ} = $self->{$_UA}->request( $self->{_HTTP_REQUEST_OBJ} );

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

    if ( ref($parm) eq 'IBRecord' ) {
        $self->_set_objref( $parm->get_ref() );
        $self->_add_return_fields($parm_ref) if ( defined $parm_ref );
        if ( defined $parm2_ref ) { confess; }

    }
    elsif ( URL_MODULE_EXISTS($parm) ) {
        $self->_set_objtype($parm);
        $self->_add_search_fields($parm_ref)       if ( defined $parm_ref );
        $self->_add_return_fields_plus($parm2_ref) if ( defined $parm2_ref );
    }
    elsif ( URL_REF_MODULE_EXISTS($parm) ) {
        $self->_set_objtype( URL_REF_MODULE_NAME($parm) );
        $self->_add_search_fields($parm_ref)       if ( defined $parm_ref );
        $self->_add_return_fields_plus($parm2_ref) if ( defined $parm2_ref );
    }
    else {
        confess "BAD PARAMETER:" . Dumper $parm;
    }

    $self->_get_url;

    $self;
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

# ----------------------------
sub URL {
    my ($self) = @_;
    $self->{$_IBLWP_URL};
}

# ---------------------------
# response()
# ---------------------------
sub response {
    my ($self) = @_;
    if ( defined $self->{$_HTTP_RESPONSE_OBJ} ) {
        return $self->{$_HTTP_RESPONSE_OBJ};
    }
    return undef;
}

# ---------------------------
#
# ---------------------------
sub _set_objref {
    my ( $self, $r ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$_IBLWP_OBJREF}  = $r;
    $self->{$_IBLWP_OBJTYPE} = undef;
}

# ---------------------------
#
# ---------------------------
sub _set_objtype {
    my ( $self, $t ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

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

    PRINT_MYNAMELINE if $DEBUG;

    my ( $self, $f ) = @_;
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
