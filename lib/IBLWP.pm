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
# PROTOTYPES
# ---------------------------
sub get_objref;     #
sub get_objtype;    #
sub response;       # Returns HTTP::Response Object
sub is_success;     # Returns HTTP::Response->is_success()
sub is_error;       # Returns HTTP::Response->is_error()
sub add_return_field;
sub add_return_field_plus;

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
Readonly our $_IBLWP_URL                => '_IBLWP_URL';
Readonly our $_IBLWP_USERNAME           => '_IBLWP_USERNAME';
Readonly our $_IBLWP_PASSWORD           => '_IBLWP_PASSWORD';
Readonly our $_IBLWP_HOSTNAME           => '_IBLWP_HOSTNAME';
Readonly our $_IBLWP_MAX_RESULTS        => '_IBLWP_MAX_RESULTS';
Readonly our $_IBLWP_RETURN_TYPE        => '_IBLWP_RETURN_TYPE';
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

    $h{$_IBLWP_URL} = $_HTTPS
      . $h{$_IBLWP_USERNAME} . ':'
      . $h{$_IBLWP_PASSWORD} . '@'
      . $h{$_IBLWP_HOSTNAME}
      . $_URI;

    bless $self, $class;
    $self;
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
    my ( $self, $parm, $parm_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    confess if ( !defined $parm );

    if ( ref($parm) eq 'IBRecord' ) {

        # Get _ref
    }
    elsif ( URL_MODULE_EXISTS($parm) ) {

        # Get OBJType + parm_ref
    }
    elsif ( URL_MODULE_EXISTS( ( split( /\//, $parm ) )[0] ) ) {

        # RAW _ref value
    }
    else {
        confess "BAD PARAMETER:" . Dumper $parm;
    }

    my $url = '';

    $self->{$_HTTP_REQUEST_OBJ} = HTTP::Request->new( GET => $url );
    $self->{$_HTTP_RESPONSE_OBJ} = $self->{$_UA}->request( $self->{_HTTP_REQUEST_OBJ} );

    $self;
}

# ---------------------------
# is_success()
# ---------------------------
sub _get_ref {
}

# ---------------------------
# is_success()
# ---------------------------
sub is_success {
    my ($self) = @_;

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
sub add_return_field {
    my ( $self, $field ) = @_;
    if ( defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        $self->{$_IBLWP_RETURN_FIELDS_PLUS} = undef;
    }
    if ( !defined $self->{$_IBLWP_RETURN_FIELDS} ) {
        my %h;
        $self->{$_IBLWP_RETURN_FIELDS} = \%h;
    }

    $self->{$_IBLWP_RETURN_FIELDS}->{$field}++;

    $self;
}

# ---------------------------
#
# ---------------------------
sub add_return_field_plus {
    my ( $self, $field ) = @_;
    if ( defined $self->{$_IBLWP_RETURN_FIELDS} ) {
        $self->{$_IBLWP_RETURN_FIELDS} = undef;
    }
    if ( !defined $self->{$_IBLWP_RETURN_FIELDS_PLUS} ) {
        my %h;
        $self->{$_IBLWP_RETURN_FIELDS_PLUS} = \%h;
    }

    $self->{$_IBLWP_RETURN_FIELDS_PLUS}->{$field}++;

    $self;

}

1;
