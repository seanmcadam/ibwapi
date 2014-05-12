#!/usr/bin/perl

package IBWAPI;
use FindBin;
use lib "$FindBin::Bin";
use IBFields;
use IBCred;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use JSON;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------
sub _get;
sub _post;
sub _put;
sub _delete;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_DEFAULT_MAX_RESULTS => 5000;

Readonly our $_HTTPS    => 'https://';
Readonly our $_JSON     => 'json';
Readonly our $_URI      => '/wapi/v1.2/';
Readonly our $_REF      => '_ref';
Readonly our $_OPTIONS  => 'options';
Readonly our $_EXTATTRS => 'extattrs';

Readonly our $_IB_BASE_FIELDS        => '_IB_BASE_FIELDS';
Readonly our $_IB_CRED               => '_IB_CRED';
Readonly our $_IB_PARM_NAMES         => '_IB_PARM_NAMES';
Readonly our $_IB_PARM_REF_TYPES     => '_IB_PARM_REF_TYPES';
Readonly our $_IB_MAX_RESULTS        => '_IB_MAX_RESULTS';
Readonly our $_IB_OBJECT_NAME        => '_IB_OBJECT_NAME';
Readonly our $_IB_READONLY_FIELDS    => '_IB_READONLY_FIELDS';
Readonly our $_IB_RETURN_FIELDS      => '_IB_RETURN_FIELDS';
Readonly our $_IB_RETURN_FIELDS_PLUS => '_IB_RETURN_FIELDS_PLUS';
Readonly our $_IB_SEARCHABLE_FIELDS  => '_IB_SEARCHABLE_FIELDS';
Readonly our $_IB_URL                => '_IB_URL';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

Readonly::Hash our %_PARM_NAMES => (
    $IB_CRED               => $_IB_CRED,
    $IB_MAX_RESULTS        => $_IB_MAX_RESULTS,
    $IB_RETURN_FIELDS      => $_IB_RETURN_FIELDS,
    $IB_RETURN_FIELDS_PLUS => $_IB_RETURN_FIELDS_PLUS,
);

Readonly::Hash our %_PARM_REF_TYPES => (
    $IB_CRED               => 'IBCred',
    $IB_MAX_RESULTS        => '',
    $IB_RETURN_FIELDS      => 'ARRAY',
    $IB_RETURN_FIELDS_PLUS => 'ARRAY',
);

# ---------------------------
# new()
# ---------------------------
sub new() {
    my ( $class, $obj, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    if ( !defined $obj ) { confess; }
    $h{$_IB_OBJECT_NAME} = $obj;

    #
    # Define WEB Credentials
    #
    if ( !defined $parm_ref->{$IB_CRED} ) { confess; }
    $h{$_IB_CRED} = $parm_ref->{$IB_CRED};
    if ( ref( $h{$_IB_CRED} ) ne 'IBCred' ) { confess; }
    $h{$_IB_URL} = $h{$_IB_CRED}->URL();

    $h{$_IB_BASE_FIELDS}        = $parm_ref->{$IB_BASE_FIELDS};
    $h{$_IB_MAX_RESULTS}        = ( defined $parm_ref->{$IB_MAX_RESULTS} ) ? $parm_ref->{$IB_MAX_RESULTS} : $_DEFAULT_MAX_RESULTS;
    $h{$_IB_READONLY_FIELDS}    = $parm_ref->{$IB_READONLY_FIELDS};
    $h{$_IB_RETURN_FIELDS}      = $parm_ref->{$IB_RETURN_FIELDS};
    $h{$_IB_RETURN_FIELDS_PLUS} = $parm_ref->{$IB_RETURN_FIELDS_PLUS};
    $h{$_IB_SEARCHABLE_FIELDS}  = $parm_ref->{$IB_SEARCHABLE_FIELDS};

    #    if ( defined $parm_ref ) {
    #        if ( 'HASH' ne ref($parm_ref) ) { confess Dumper $parm_ref; }
    #        foreach my $p ( sort( keys(%$parm_ref) ) ) {
    #            if ( !defined $_PARM_NAMES{$p} ) { next; }
    #            if ( $_PARM_REF_TYPES{$p} ne ref( $parm_ref->{$p} ) ) { confess Dumper $parm_ref; }
    #            $h{ $_PARM_NAMES{$p} } = $parm_ref->{$p};
    #        }
    #    }

    bless $self, $class;

    $self;
}

# ---------------------------------------------------------------------------------
# Returns: 200 (search OK), 400 (results > max_results), 404 (object not found)
# ---------------------------------------------------------------------------------
sub _get {
    my ( $self, $parm_ref ) = @_;
    my $get_url    = '';
    my $search_url = '';

    if ( defined $parm_ref ) {

        # Verify parameters (Searchable fields)
        $self->_verify_search_parameters($parm_ref);

        # Generate URL
        $search_url = $self->_get_search_parameters($parm_ref);
    }

    # Retrieve URL
    # Check for error

    $get_url = $self->{$_IB_URL}
      . $self->{$_IB_OBJECT_NAME}
      . '?'
      . URL_PARM_NAME($IB_RETURN_TYPE)
      . '='
      . $_JSON
      . '&'
      . URL_PARM_NAME($IB_MAX_RESULTS)
      . '='
      . $self->{$_IB_MAX_RESULTS}
      . '&'
      . $search_url;

    #    print Dumper $self;
    print $search_url . "\n";
    print $get_url . "\n";
    exit;

}

# ---------------------------------------------------------------------------------
sub _getref {
    my ( $self, $ref_obj ) = @_;
    my $obj_type = IBFields::URL_MODULE_NAME( ( split( '::', ref($self) ) )[-1] );

    my $url = $self->{$_IB_URL};
}

# ---------------------------------------------------------------------------------
# Returns: 201 (object created)
# ---------------------------------------------------------------------------------
sub _post {
    my ($self) = @_;
}

# ---------------------------------------------------------------------------------
# Returns: 200 (object updated)
# ---------------------------------------------------------------------------------
sub _put {
    my ($self) = @_;
}

# ---------------------------------------------------------------------------------
# Returns: 200 (object deleted)
# ---------------------------------------------------------------------------------
sub _delete {
    my ($self) = @_;
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
sub _get_search_parameters {
    my ( $self, $parm_ref ) = @_;
    my $ret = '';

    foreach my $p ( sort( keys(%$parm_ref) ) ) {
        print "SEARCHING PARM $p\n";
        if ( URL_FIELD_EXISTS($p) ) {
            confess "FIELD '$p' NOT SEARCHABLE FOR " . $self->{$_IB_OBJECT_NAME} . "\n" if ( !$self->_is_field_searchable($p) );
            confess "FIELD VALUE FOR '$p' NOT AN ARRAY\n" if ( ref( $parm_ref->{$p} ) ne 'ARRAY' );
            confess "UNDEFINED SEARCH FOR '$p'\n"         if ( !defined $parm_ref->{$p}->[0] );
            confess "UNDEFINED VALUE FOR '$p'\n"          if ( !defined $parm_ref->{$p}->[1] );
            confess "BAD SEARCH TYPE FOR '$p'\n"          if ( !URL_SEARCH_EXISTS( $parm_ref->{$p}->[0] ) );

            $ret .= '&' if ( $ret ne '' );
            $ret .= URL_FIELD_NAME($p) . URL_SEARCH_NAME( $parm_ref->{$p}->[0] ) . '"' . $parm_ref->{$p}->[1] . '"';

        }
        else {
            warn "SEARCH PARM $p NOT FOUND\n";
        }
    }
    $ret;
}

# ----------------------------------------------------------------------
# Fails if a defined field is not on the search field
# Ignores non-fields  (extensible attributes, and other parameters)
# ----------------------------------------------------------------------
sub _verify_search_parameters {
    my ( $self, $parm_ref ) = @_;

    foreach my $p ( sort( keys(%$parm_ref) ) ) {
        if ( URL_FIELD_EXISTS($p) ) {
            confess "'$p' NOT SEARCHABLE FOR " . $self->{$_IB_OBJECT_NAME} . "\n" if ( !$self->_is_field_searchable($p) );
            confess "VALUE FOR '$p' NOT AN ARRAY\n" if ( ref( $parm_ref->{$p} ) ne 'ARRAY' );

            # Verify Type HERE

        }
    }
}

# ----------------------------------------------------------------------
# Returns T/F
# ----------------------------------------------------------------------
sub _is_field_searchable {
    my ( $self, $field ) = @_;
    confess if ( !defined $self->{$_IB_SEARCHABLE_FIELDS} );

    return ( ( defined $self->{$_IB_SEARCHABLE_FIELDS}->{$field} ) ? 1 : 0 );

}

1;
