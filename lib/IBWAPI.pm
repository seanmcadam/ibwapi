#!/usr/bin/perl

package IBWAPI;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use IBLWP;
use IBRecord;

use base qw( Exporter );

use Carp;
use JSON;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# GET:    ( field = val, ...)
#	returns Array Ref to IBRecords
# POST:   ( field = val, ... )
#	returns Ref to IBRecord
# PUT:    ( REF, field = val, ... )
#	updates existing record, flushes the record, and
#	returns Ref to IBRecord
# DELETE: ( REF )
#	Returns T/F
#
# ---------------------------

# ---------------------------
# PROTOTYPES
# ---------------------------
sub GET;
sub POST;
sub PUT;
sub DELETE;
sub _get;
sub _post;
sub _put;
sub _get_ref;
sub _update_ref;
sub _flush_ref;
sub _delete_ref;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_DEFAULT_MAX_RESULTS => 5000;

Readonly our $_LWP_OBJ  => '_LWP_OBJ';
Readonly our $_OPTIONS  => 'options';
Readonly our $_EXTATTRS => 'extattrs';

Readonly our $_IB_RECORDS            => '_IB_RECORDS';
Readonly our $_IB_BASE_FIELDS        => '_IB_BASE_FIELDS';
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
    $IB_MAX_RESULTS        => $_IB_MAX_RESULTS,
    $IB_RETURN_FIELDS      => $_IB_RETURN_FIELDS,
    $IB_RETURN_FIELDS_PLUS => $_IB_RETURN_FIELDS_PLUS,
);

Readonly::Hash our %_PARM_REF_TYPES => (
    $IB_MAX_RESULTS        => '',
    $IB_RETURN_FIELDS      => 'ARRAY',
    $IB_RETURN_FIELDS_PLUS => 'ARRAY',
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $module_name, $parm_ref ) = @_;
    my %h;
    my %r;
    my $self = \%h;

    PRINT_MYNAMELINE if $DEBUG;

    if ( !defined $module_name ) { confess; }
    $h{$_IB_OBJECT_NAME} = $module_name;
    $h{$_IB_RECORDS}     = \%r;

    if ( !defined $parm_ref->{$IB_BASE_FIELDS} )       { confess; }
    if ( !defined $parm_ref->{$IB_RETURN_FIELDS} )     { confess; }
    if ( !defined $parm_ref->{$IB_READONLY_FIELDS} )   { confess; }
    if ( !defined $parm_ref->{$IB_SEARCHABLE_FIELDS} ) { confess; }

    $h{$_IB_BASE_FIELDS}       = $parm_ref->{$IB_BASE_FIELDS};
    $h{$_IB_MAX_RESULTS}       = ( defined $parm_ref->{$IB_MAX_RESULTS} ) ? $parm_ref->{$IB_MAX_RESULTS} : $_DEFAULT_MAX_RESULTS;
    $h{$_IB_READONLY_FIELDS}   = $parm_ref->{$IB_READONLY_FIELDS};
    $h{$_IB_SEARCHABLE_FIELDS} = $parm_ref->{$IB_SEARCHABLE_FIELDS};

    $h{$_IB_RETURN_FIELDS}      = $parm_ref->{$IB_RETURN_FIELDS};
    $h{$_IB_RETURN_FIELDS_PLUS} = $parm_ref->{$IB_RETURN_FIELDS_PLUS};

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

# ---------------------------
# create_lwp()
# Called from the child object
# ---------------------------
sub create_lwp {
    my ( $self, $parm_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    if ( defined( $self->{$_LWP_OBJ} ) ) { confess Dumper $self; }
    $self->{$_LWP_OBJ} = IBLWP->new( $self, $parm_ref );
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub GET {
    my ( $self, $field_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    #
    # Verify parameters (Searchable fields)
    #
    $self->_verify_search_parameters($field_ref);

    if ( ref( $self->_lwp ) ne 'IBLWP' ) { confess 'Ref:' . ref( $self->_lwp ); }

    $self->_lwp->get( $self->_obj_name, $field_ref );

}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub POST {
    my ( $self, $parm_ref ) = @_;
    PRINT_MYNAMELINE if $DEBUG;
    confess;
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub PUT {
    my ( $self, $parm_ref ) = @_;
    PRINT_MYNAMELINE if $DEBUG;
    confess;
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub DELETE {
    my ( $self, $parm_ref ) = @_;
    PRINT_MYNAMELINE if $DEBUG;
    confess;
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _get {
    my ( $self, $parm_ref ) = @_;
    my $get_url    = '';
    my $search_url = '';

    PRINT_MYNAMELINE if $DEBUG;

    if ( defined $parm_ref ) {

        #
        # Verify parameters (Searchable fields)
        #
        $self->_verify_search_parameters($parm_ref);

        #
        # Generate URL
        #
        $search_url = $self->_get_search_parameters($parm_ref);
    }

    #
    # Retrieve URL
    #

    #$get_url = $self->{$_IB_URL}
    #  . $self->{$_IB_OBJECT_NAME}
    #  . '?'
    #  . URL_PARM_NAME($IB_RETURN_TYPE)
    #  . '='
    #  . $_JSON
    #  . '&'
    #  . URL_PARM_NAME($IB_MAX_RESULTS)
    #  . '='
    #  . $self->{$_IB_MAX_RESULTS}
    #  . $search_url
    #  ;

    #
    # Check for error
    #
    if ( $self->_lwp->get($get_url)->is_error() ) {
        print $get_url . "\n";
        confess $self->_lwp->get_error . "\n";
    }

    my $json = decode_json( $self->_lwp->response()->content() );

    foreach my $record (@$json) {
        $self->{_RECORDS}->{ $record->{'_ref'} } = IBRecord->new($record);
    }

}

# ---------------------------------------------------------------------------------
sub _get_ref {
    my ( $self, $ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess "BAD REF: " . $ref; }

    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
    	PRINT_MYNAMELINE(" EXIT - FOUND REF") if $DEBUG;
        return $self->{$_IB_RECORDS}->{$ref};
    }

    PRINT_MYNAMELINE(" EXIT - undef") if $DEBUG;

    return undef;

}

# ---------------------------------------------------------------------------------
sub _update_ref {
    my ( $self, $ref, $field_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess @_; }

    $self->get_ibr_ref($ref)->update_field

}

# ---------------------------------------------------------------------------------
# Call the IB_RECORD flush function for the given _ref
# ---------------------------------------------------------------------------------
sub _flush_ref {
    my ( $self, $ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;
}

# ---------------------------------------------------------------------------------
# Call the IB_RECORD delete function for the given _ref
# ---------------------------------------------------------------------------------
sub _delete_ref {
    my ( $self, $ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;
}

# ---------------------------------------------------------------------------------
# Add an IBRecord to the _IB_RECORD HASH
# ---------------------------------------------------------------------------------
sub _add_obj {
    my ( $self, $obj ) = @_;
    my $ret = 0;

    PRINT_MYNAMELINE if $DEBUG;

    if ( !defined $obj || ref($obj) ne $PERL_MODULE_IBRECORD) { confess MYNAMELINE . "Missing OBJECT\n"; }
    my $ref = $obj->get_ref();
    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess MYNAMELINE . "BAD REF - " . $obj->get_ref . ' ' . Dumper $obj; }

    my $name = ( split( /\//, $ref ) )[0];
    my $obj_name = URL_NAME_MODULE( $name );

    if ( $obj_name ne $self->_obj_name ) { confess MYNAMELINE . "BAD REF value: '$obj_name' != '" . $self->_obj_name . "\n"; }

    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
        warn "Adding the same object: '$ref'\n";
    }
    else {
        $self->{$_IB_RECORDS}->{$ref} = $obj;
	$ret = 1;
    }

    PRINT_MYNAMELINE("EXIT") if $DEBUG;
    $ret;

}

# ---------------------------------------------------------------------------------
# Returns: 201 (object created)
# ---------------------------------------------------------------------------------
sub _post {
    my ($self) = @_;
    PRINT_MYNAMELINE if $DEBUG;
}

# ---------------------------------------------------------------------------------
# Returns: 200 (object updated)
# ---------------------------------------------------------------------------------
sub _put {
    my ($self) = @_;
    PRINT_MYNAMELINE if $DEBUG;
}

# ---------------------------------------------------------------------------------
# Returns: 200 (object deleted)
# ---------------------------------------------------------------------------------
sub _delete {
    my ($self) = @_;
    PRINT_MYNAMELINE if $DEBUG;
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _obj_name {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    defined $self->{$_IB_OBJECT_NAME} || confess @_;

    PRINT_MYNAMELINE( "EXIT " . $self->{$_IB_OBJECT_NAME} ) if $DEBUG;

    $self->{$_IB_OBJECT_NAME};
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _lwp {
    my ($self) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    defined $self->{$_LWP_OBJ} || confess Dumper @_;

    return $self->{$_LWP_OBJ};
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
sub _get_search_parameters {
    my ( $self, $parm_ref ) = @_;
    my $ret = '';

    PRINT_MYNAMELINE if $DEBUG;

    foreach my $p ( sort( keys(%$parm_ref) ) ) {

        # print "SEARCHING PARM $p\n";
        if ( URL_FIELD_EXISTS($p) ) {
            confess "FIELD '$p' NOT SEARCHABLE FOR " . $self->{$_IB_OBJECT_NAME} . "\n" if ( !$self->_is_field_searchable($p) );
            confess "FIELD VALUE FOR '$p' NOT AN ARRAY\n" if ( ref( $parm_ref->{$p} ) ne 'ARRAY' );
            confess "UNDEFINED SEARCH FOR '$p'\n"         if ( !defined $parm_ref->{$p}->[0] );
            confess "UNDEFINED VALUE FOR '$p'\n"          if ( !defined $parm_ref->{$p}->[1] );
            confess "BAD SEARCH TYPE FOR '$p'\n"          if ( !URL_SEARCH_EXISTS( $parm_ref->{$p}->[0] ) );

            $ret .= '&';
            $ret .= URL_FIELD_NAME($p) . URL_SEARCH_NAME( $parm_ref->{$p}->[0] ) . $parm_ref->{$p}->[1];

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

    PRINT_MYNAMELINE if $DEBUG;

    if ( !defined $parm_ref ) { warn MYNAMELINE . " NO PARM_REF defined\n"; return; }

    foreach my $p ( sort( keys(%$parm_ref) ) ) {
        if ( URL_FIELD_EXISTS($p) ) {
            confess "'$p' NOT SEARCHABLE FOR " . $self->_obj_name . "\n" if ( !$self->_is_field_searchable($p) );
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

    PRINT_MYNAMELINE if $DEBUG;

    confess if ( !defined $self->{$_IB_SEARCHABLE_FIELDS} );

    return ( ( defined $self->{$_IB_SEARCHABLE_FIELDS}->{$field} ) ? 1 : 0 );

}

# ----------------------------------------------------------------------
# Base Field Exists
# ----------------------------------------------------------------------
sub base_field_exists {
    my ( $self, $f ) = @_;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    $self->_field_exists( $self->{$_IB_BASE_FIELDS}, $f )
}

# ----------------------------------------------------------------------
# readonly Field Exists
# ----------------------------------------------------------------------
sub readonly_field_exists {
    my ( $self, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    $self->_field_exists( $self->{$_IB_BASE_FIELDS}, $f )
}

# ----------------------------------------------------------------------
# Searchable Field Exists
# ----------------------------------------------------------------------
sub searchable_field_exists {
    my ( $self, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    $self->_field_exists( $self->{$_IB_SEARCHABLE_FIELDS}, $f )
}

# ----------------------------------------------------------------------
# Field Exists
# ----------------------------------------------------------------------
sub _field_exists {
    my ( $self, $table_ref, $f ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    defined $table_ref   || confess @_;
    defined $f           || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    defined $table_ref->{$f};

}

1;
