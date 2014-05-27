#!/usr/bin/perl

package IBWAPI;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use IBLWP;
use IBRecord;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# GET:    ( {field = val,} [,(return_fields )])
#	returns Array Ref to IBRecords
# POST:   ( {field = val,} )
#	Adds new record
#	returns Ref to IBRecord
# PUT:    ( REF [,{field = val,}] )
#	updates existing record
#	flushes the record
#	returns Ref to IBRecord
# DELETE: ( REF )
#	Returns T/F
#
# ---------------------------

# ---------------------------
# PROTOTYPES
# ---------------------------
#sub GET;
sub GET($\$$);
sub POST($$);
sub PUT($$\$);
sub DELETE($$);
sub get;
sub add_rec;
sub update;
sub flush;
sub delete;
sub _field_exists;
sub _base_field_exists;
sub _readonly_field_exists;
sub _searchable_field_exists;

#sub create_lwp {
#sub _obj_name {
#sub _lwp {
#sub _get_search_parameters {
#sub _verify_search_parameters {
#sub _verify_return_fields {
#sub _is_field_searchable {

#
# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_DEFAULT_MAX_RESULTS => 5000;

Readonly our $_LWP_OBJ  => '_LWP_OBJ';
Readonly our $_OPTIONS  => 'options';
Readonly our $_EXTATTRS => 'extattrs';

Readonly our $_IB_RECORDS     => '_IB_RECORDS';
Readonly our $_IB_BASE_FIELDS => '_IB_BASE_FIELDS';

# Readonly our $_IB_PARM_NAMES      => '_IB_PARM_NAMES';
Readonly our $_IB_PARM_REF_TYPES  => '_IB_PARM_REF_TYPES';
Readonly our $_IB_MAX_RESULTS     => '_IB_MAX_RESULTS';
Readonly our $_IB_OBJECT_NAME     => '_IB_OBJECT_NAME';
Readonly our $_IB_READONLY_FIELDS => '_IB_READONLY_FIELDS';

Readonly our $_IB_FIELDS => '_IB_FIELDS';

# Readonly our $_IB_RETURN_FIELDS      => '_IB_RETURN_FIELDS';
# Readonly our $_IB_RETURN_FIELDS_PLUS => '_IB_RETURN_FIELDS_PLUS';
Readonly our $_IB_SEARCHABLE_FIELDS => '_IB_SEARCHABLE_FIELDS';
Readonly our $_IB_SEARCHONLY_FIELDS => '_IB_SEARCHONLY_FIELDS';
Readonly our $_IB_URL               => '_IB_URL';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

# Readonly::Hash our %_PARM_NAMES => (
#     $IB_MAX_RESULTS        => $_IB_MAX_RESULTS,
#     $IB_RETURN_FIELDS      => $_IB_RETURN_FIELDS,
#     $IB_RETURN_FIELDS_PLUS => $_IB_RETURN_FIELDS_PLUS,
# );

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

    LOG_ENTER_SUB;

    if ( !defined $module_name ) { confess; }
    $h{$_IB_OBJECT_NAME} = $module_name;
    $h{$_IB_RECORDS}     = \%r;

    if ( !defined $parm_ref->{$IB_FIELDS} )            { confess; }
    if ( !defined $parm_ref->{$IB_BASE_FIELDS} )       { confess; }
    if ( !defined $parm_ref->{$IB_READONLY_FIELDS} )   { confess; }
    if ( !defined $parm_ref->{$IB_SEARCHABLE_FIELDS} ) { confess; }
    if ( !defined $parm_ref->{$IB_SEARCHONLY_FIELDS} ) { confess; }

    $h{$_IB_MAX_RESULTS} = ( defined $parm_ref->{$IB_MAX_RESULTS} ) ? $parm_ref->{$IB_MAX_RESULTS} : $_DEFAULT_MAX_RESULTS;

    $h{$_IB_BASE_FIELDS}       = $parm_ref->{$IB_BASE_FIELDS};
    $h{$_IB_READONLY_FIELDS}   = $parm_ref->{$IB_READONLY_FIELDS};
    $h{$_IB_SEARCHABLE_FIELDS} = $parm_ref->{$IB_SEARCHABLE_FIELDS};
    $h{$_IB_SEARCHONLY_FIELDS} = $parm_ref->{$IB_SEARCHONLY_FIELDS};

    #    $h{$_IB_RETURN_FIELDS}      = $parm_ref->{$IB_RETURN_FIELDS};
    #    $h{$_IB_RETURN_FIELDS_PLUS} = $parm_ref->{$IB_RETURN_FIELDS_PLUS};

    bless $self, $class;

    LOG_EXIT_SUB;

    $self;
}

# ---------------------------
# create_lwp()
# Called from the child object
# ---------------------------
sub create_lwp {
    my ( $self, $parm_ref ) = @_;

    LOG_ENTER_SUB;
    if ( defined( $self->{$_LWP_OBJ} ) ) { confess Dumper $self; }
    $self->{$_LWP_OBJ} = IBLWP->new( $self, $parm_ref );

    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
# Returns an Array of REFs
# ---------------------------------------------------------------------------------
sub GET($\$$) {
    my ( $self, $search_field_ref, $return_field_ref ) = @_;
    my $ret_array_ref;

    LOG_ENTER_SUB;

    if ( ref( $self->_lwp ) ne 'IBLWP' ) { confess 'Ref:' . ref( $self->_lwp ); }

    #
    # Verify parameters (Searchable fields)
    #
    $self->_verify_search_parameters($search_field_ref) if ($search_field_ref);
    $self->_verify_return_fields($return_field_ref) if ( defined $return_field_ref );

    # $ret_array_ref = $self->_lwp->get( $self->_obj_name, $search_field_ref, $return_field_ref );
    $ret_array_ref = $self->_lwp->get(
        {
            $IBLWP_GET_OBJTYPE         => $self->_obj_name,
            $IBLWP_GET_SEARCH_REF      => $search_field_ref,
            $IBLWP_GET_RETURN_PLUS_REF => $return_field_ref,
        } );

    LOG_DEBUG3( PRINT_MYNAMELINE( "EXIT:" . Dumper $ret_array_ref) );

    LOG_EXIT_SUB;
    return $ret_array_ref;

}

# ---------------------------------------------------------------------------------
# Creates a new Record
# ---------------------------------------------------------------------------------
sub POST($$) {
    my ( $self, $field_ref ) = @_;
    LOG_ENTER_SUB;

    LOG_FATAL(PRINT_MYNAMELINE);
}

# ---------------------------------------------------------------------------------
# Updated Existing Record
# ---------------------------------------------------------------------------------
sub PUT($$\$) {
    my ( $self, $ref, $parm_ref ) = @_;
    LOG_ENTER_SUB;

    LOG_FATAL(PRINT_MYNAMELINE);
}

# ---------------------------------------------------------------------------------
# Deletes an Existing Record
# ---------------------------------------------------------------------------------
sub DELETE($$) {
    my ( $self, $ref ) = @_;
    LOG_ENTER_SUB;

    LOG_FATAL(PRINT_MYNAMELINE);
}

# ---------------------------------------------------------------------------------
sub get {
    my ( $self, $ref ) = @_;
    my $ibr_rec = undef;

    LOG_ENTER_SUB;

    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess "BAD REF: " . $ref; }

    #
    # Check that IBRecord exists
    #
    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
        $ibr_rec = $self->{$_IB_RECORDS}->{$ref};
    }

    #
    # Or go Get it from IB
    #
    else {
        ($ibr_rec) = $self->_lwp->get($ref);
    }

    LOG_EXIT_SUB;

    return $ibr_rec;

}

# ---------------------------------------------------------------------------------
sub verify_record {
    my ( $self, $ref ) = @_;
    my $ibr_rec = undef;

    LOG_ENTER_SUB;

    if ( defined $ref && !URL_REF_MODULE_EXISTS($ref) ) { confess "BAD REF: " . $ref; }

    #
    # Check that IBRecord exists
    #
    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
        $ibr_rec = $self->{$_IB_RECORDS}->{$ref};
    }

    LOG_EXIT_SUB;

    return $ibr_rec;

}

# ---------------------------------------------------------------------------------
sub get_field {
    my ( $self, $ref, $field ) = @_;
    my $ibr_rec   = undef;
    my $ret_field = undef;

    LOG_ENTER_SUB;

    if ( !defined $ref   || !URL_REF_MODULE_EXISTS($ref) )         { confess "BAD REF: " . $ref; }
    if ( !defined $field || !$self->_return_field_exists($field) ) { confess "BAD FIELD: " . $field; }

    if ( defined( $ibr_rec = $self->get($ref) ) ) {
        $ret_field = $ibr_rec->get_field($field);
    }

    LOG_EXIT_SUB;

    return $ret_field;

}

# ---------------------------------------------------------------------------------
sub get_extattr {
    my ( $self, $ref, $attr ) = @_;
    my $ibr_rec   = undef;
    my $ret_field = undef;

    LOG_ENTER_SUB;

    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess "BAD REF: " . $ref; }
    if ( !defined $attr || $attr eq '' ) { confess "BAD EXTATTR"; }

    if ( defined( $ibr_rec = $self->get($ref) ) ) {
        $ret_field = $ibr_rec->get_extattr_field($attr);
    }

    LOG_EXIT_SUB;

    return $ret_field;

}

# ---------------------------------------------------------------------------------
sub set_field {
    my ( $self, $ref, $field, $value ) = @_;
    my $ibr_rec   = undef;
    my $ret_field = undef;

    LOG_ENTER_SUB;

    if ( !defined $ref   || !URL_REF_MODULE_EXISTS($ref) )         { confess "BAD REF: " . $ref; }
    if ( !defined $field || !$self->_return_field_exists($field) ) { confess "BAD FIELD: " . $field; }

    # Verify TYPE HERE

    if ( defined( $ibr_rec = $self->get($ref) ) ) {
        $ibr_rec->update_field( $field, $value );
    }

    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
sub update {
    my ( $self, $ref, $field_ref ) = @_;

    LOG_ENTER_SUB;

    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess @_; }

    $self->get($ref)->update_field;
    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
# Call the IB_RECORD flush function for the given _ref
# ---------------------------------------------------------------------------------
sub flush {
    my ( $self, $ref ) = @_;
    LOG_ENTER_SUB;

    LOG_EXIT_SUB;
}

# ---------------------------------------------------------------------------------
# Call the IB_RECORD delete function for the given _ref
# ---------------------------------------------------------------------------------
sub delete {
    my ( $self, $ref ) = @_;
    LOG_ENTER_SUB;

    LOG_EXIT_SUB;
}

# ---------------------------------------------------------------------------------
# Add an IBRecord to the _IB_RECORD HASH
# ---------------------------------------------------------------------------------
sub add_rec {
    my ( $self, $obj ) = @_;
    my $ret = 0;

    LOG_ENTER_SUB;

    if ( !defined $obj || ref($obj) ne $PERL_MODULE_IBRECORD ) { confess MYNAMELINE . "Missing OBJECT\n"; }
    my $ref = $obj->get_ref();
    if ( !defined $ref || !URL_REF_MODULE_EXISTS($ref) ) { confess MYNAMELINE . "BAD REF - " . $obj->get_ref . ' ' . Dumper $obj; }

    my $name = ( split( /\//, $ref ) )[0];
    my $obj_name = URL_NAME_MODULE($name);

    if ( $obj_name ne $self->_obj_name ) { confess MYNAMELINE . "BAD REF value: '$obj_name' != '" . $self->_obj_name . "\n"; }

    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
        warn "Adding the same object: '$ref'\n";
    }
    else {
        $self->{$_IB_RECORDS}->{$ref} = $obj;
        $ret = 1;
    }

    LOG_EXIT_SUB;
    $ret;

}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _obj_name {
    my ($self) = @_;

    LOG_ENTER_SUB;

    defined $self->{$_IB_OBJECT_NAME} || confess @_;

    LOG_EXIT_SUB;
    $self->{$_IB_OBJECT_NAME};
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _lwp {
    my ($self) = @_;

    LOG_ENTER_SUB;

    defined $self->{$_LWP_OBJ} || confess Dumper @_;

    LOG_EXIT_SUB;
    return $self->{$_LWP_OBJ};
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
sub _get_search_parameters {
    my ( $self, $parm_ref ) = @_;
    my $ret = '';

    LOG_ENTER_SUB;

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
    LOG_EXIT_SUB;
    $ret;
}

# ----------------------------------------------------------------------
# Fails if a defined field is not on the search field
# Ignores non-fields  (extensible attributes, and other parameters)
# ----------------------------------------------------------------------
sub _verify_search_parameters {
    my ( $self, $parm_ref ) = @_;

    LOG_ENTER_SUB;

    if ( !defined $parm_ref ) { warn MYNAMELINE . " NO PARM_REF defined\n"; return; }

    foreach my $p ( sort( keys(%$parm_ref) ) ) {
        if ( URL_FIELD_EXISTS($p) ) {
            confess "'$p' NOT SEARCHABLE FOR " . $self->_obj_name . "\n" if ( !$self->_is_field_searchable($p) );
            confess "VALUE FOR '$p' NOT AN ARRAY\n" if ( ref( $parm_ref->{$p} ) ne 'ARRAY' );

            # Verify Type HERE

        }
    }
    LOG_EXIT_SUB;
}

# ----------------------------------------------------------------------
# Fails if a defined field is not on the search field
# Ignores non-fields  (extensible attributes, and other parameters)
# ----------------------------------------------------------------------
sub _verify_return_fields {
    my ( $self, $parm_ref ) = @_;

    LOG_ENTER_SUB;

    if ( !defined $parm_ref ) { warn MYNAMELINE . " NO PARM_REF defined\n"; return; }

    if ( ref($parm_ref) eq 'HASH' ) {
        foreach my $k ( keys(%$parm_ref) ) {
            confess "'$k' NOT A RETURN FIELD\n" if ( !$self->_return_field_exists($k) );
        }
    }
    elsif ( ref($parm_ref) eq 'ARRAY' ) {
        foreach my $k (@$parm_ref) {
            confess "'$k' NOT A RETURN FIELD\n" if ( !$self->_return_field_exists($k) );
        }
    }
    else {
        confess "'$parm_ref' NOT A RETURN FIELD\n" if ( !$self->_return_field_exists($parm_ref) );
    }

    LOG_EXIT_SUB;
}

# ----------------------------------------------------------------------
# Returns T/F
# ----------------------------------------------------------------------
sub _is_field_searchable {
    my ( $self, $field ) = @_;

    LOG_ENTER_SUB;

    confess if ( !defined $self->{$_IB_SEARCHABLE_FIELDS} );

    my $ret = $self->_searchable_field_exists($field);
    LOG_EXIT_SUB;
    return $ret;

}

# ----------------------------------------------------------------------
# return Field Exists
# ----------------------------------------------------------------------
sub _return_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    my $ret = $self->_field_exists( $self->{$_IB_FIELDS}, $f );
    LOG_EXIT_SUB;
    return $ret;
}

# ----------------------------------------------------------------------
# Base Field Exists
# ----------------------------------------------------------------------
sub _base_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    my $ret = $self->_field_exists( $self->{$_IB_BASE_FIELDS}, $f );
    LOG_EXIT_SUB;
    return $ret;
}

# ----------------------------------------------------------------------
# readonly Field Exists
# ----------------------------------------------------------------------
sub _readonly_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    my $ret = $self->_field_exists( $self->{$_IB_BASE_FIELDS}, $f );
    LOG_EXIT_SUB;
    return $ret;
}

# ----------------------------------------------------------------------
# Searchable Field Exists
# ----------------------------------------------------------------------
sub _searchable_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    my $ret = $self->_field_exists( $self->{$_IB_SEARCHABLE_FIELDS}, $f );
    LOG_EXIT_SUB;
    return $ret;
}

# ----------------------------------------------------------------------
# Field Exists
# ----------------------------------------------------------------------
sub _field_exists {
    my ( $self, $table_ref, $f ) = @_;

    LOG_ENTER_SUB;

    defined $table_ref   || confess @_;
    defined $f           || confess @_;
    URL_FIELD_EXISTS($f) || confess @_;

    my $ret = defined $table_ref->{$f};
    LOG_EXIT_SUB;
    return $ret;

}

1;
