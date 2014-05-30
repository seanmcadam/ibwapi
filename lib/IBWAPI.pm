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
# get_ib_record: ( REF )
# get_field:  ( REF, FIELD_NAME, [EXATTR_NAME] )
# ---------------------------

# ---------------------------
# PROTOTYPES
# ---------------------------
sub GET;
sub POST;
sub PUT;
sub DELETE;
sub get_ib_record;
sub add_ib_record;
sub load_record_field;
sub verify_record;
sub get_field;
sub get_extattr;
sub set_field;
sub is_field_searchable;
sub is_field_readonly;
sub _obj_name;
sub _lwp;
sub _get_search_parameters;
sub _verify_search_parameters;
sub _verify_return_fields;
sub _return_field_exists;
sub _base_field_exists;
sub _readonly_field_exists;
sub _searchable_field_exists;
sub _field_exists;

#
# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_DEFAULT_MAX_RESULTS  => 5000;
Readonly our $_LWP_OBJ              => '_LWP_OBJ';
Readonly our $_OPTIONS              => 'options';
Readonly our $_IB_RECORDS           => '_IB_RECORDS';
Readonly our $_IB_BASE_FIELDS       => '_IB_BASE_FIELDS';
Readonly our $_IB_PARM_REF_TYPES    => '_IB_PARM_REF_TYPES';
Readonly our $_IB_MAX_RESULTS       => '_IB_MAX_RESULTS';
Readonly our $_IB_OBJECT_NAME       => '_IB_OBJECT_NAME';
Readonly our $_IB_READONLY_FIELDS   => '_IB_READONLY_FIELDS';
Readonly our $_IB_FIELDS            => '_IB_FIELDS';
Readonly our $_IB_SEARCHABLE_FIELDS => '_IB_SEARCHABLE_FIELDS';
Readonly our $_IB_SEARCHONLY_FIELDS => '_IB_SEARCHONLY_FIELDS';
Readonly our $_IB_URL               => '_IB_URL';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
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

    LOG_ENTER_SUB;

    defined $module_name || LOG_FATAL;
    # URL_REF_MODULE_EXISTS( $module_name ) || LOG_FATAL "Module Name: '$module_name'";

    $h{$_IB_OBJECT_NAME} = $module_name;
    $h{$_IB_RECORDS}     = \%r;

    defined $parm_ref->{$IB_FIELDS}            || LOG_FATAL;
    defined $parm_ref->{$IB_BASE_FIELDS}       || LOG_FATAL;
    defined $parm_ref->{$IB_READONLY_FIELDS}   || LOG_FATAL;
    defined $parm_ref->{$IB_SEARCHABLE_FIELDS} || LOG_FATAL;
    defined $parm_ref->{$IB_SEARCHONLY_FIELDS} || LOG_FATAL;

    $h{$_IB_MAX_RESULTS} = ( defined $parm_ref->{$IB_MAX_RESULTS} ) ? $parm_ref->{$IB_MAX_RESULTS} : $_DEFAULT_MAX_RESULTS;

    $h{$_IB_FIELDS}            = $parm_ref->{$IB_FIELDS};
    $h{$_IB_BASE_FIELDS}       = $parm_ref->{$IB_BASE_FIELDS};
    $h{$_IB_READONLY_FIELDS}   = $parm_ref->{$IB_READONLY_FIELDS};
    $h{$_IB_SEARCHABLE_FIELDS} = $parm_ref->{$IB_SEARCHABLE_FIELDS};
    $h{$_IB_SEARCHONLY_FIELDS} = $parm_ref->{$IB_SEARCHONLY_FIELDS};

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
    !defined( $self->{$_LWP_OBJ} ) || LOG_FATAL;
    $self->{$_LWP_OBJ} = IBLWP->new( $self, $parm_ref );

    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
# Gets and Returns an Array of REFs
# ---------------------------------------------------------------------------------
sub GET {
    my ( $self, $search_field_ref, $return_field_ref ) = @_;
    my $ret_array_ref;

    LOG_ENTER_SUB;

    ref( $self->_lwp ) eq $PERL_MODULE_IBLWP || LOG_FATAL;
    defined $search_field_ref && ( ref($search_field_ref) eq 'HASH'  || LOG_FATAL );
    defined $return_field_ref && ( ref($return_field_ref) eq 'ARRAY' || LOG_FATAL );

    #
    # Verify parameters (Searchable fields)
    #
    $self->_verify_search_parameters($search_field_ref) if ( defined $search_field_ref );
    $self->_verify_return_fields($return_field_ref)     if ( defined $return_field_ref );

    $ret_array_ref = $self->_lwp->get(
        {
            $IBLWP_GET_OBJTYPE         => $self->_obj_name,
            $IBLWP_GET_SEARCH_REF      => $search_field_ref,
            $IBLWP_GET_RETURN_PLUS_REF => $return_field_ref,
        } );

    LOG_DEBUG4( "RETURN ARRAY of REF:" . Dumper $ret_array_ref );

    LOG_EXIT_SUB;
    return $ret_array_ref;

}

# ---------------------------------------------------------------------------------
# Creates a new Record return Ref
# ---------------------------------------------------------------------------------
sub POST($$) {
    my ( $self, $field_ref ) = @_;
    my $ret = undef;

    LOG_ENTER_SUB;
    ref( $self->_lwp ) eq $PERL_MODULE_IBLWP || LOG_FATAL;

    LOG_FATAL PRINT_MYNAMELINE;
    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------------------------------------------------------------
# Updated Existing Record Ref (if Dirty)
# ---------------------------------------------------------------------------------
sub PUT {
    my ( $self, $ref ) = @_;
    my $ib_rec = undef;
    my $ret    = 0;

    LOG_ENTER_SUB;
    ref( $self->_lwp ) eq $PERL_MODULE_IBLWP || LOG_FATAL;

    URL_REF_MODULE_EXISTS($ref) || LOG_FATAL "BAD REF: $ref";

    $ib_rec = $self->get_ib_record($ref);

    defined $ib_rec || LOG_FATAL "No record for REF: $ref";

    if ( $ib_rec->is_dirty ) {
         $ib_rec->flush();
         $ret = 1;
    }
    else {
        LOG_WARN "IB REC Not Dirty: $ref";
    }

    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------------------------------------------------------------
# Deletes an Existing Record Ref
# ---------------------------------------------------------------------------------
sub DELETE {
    my ( $self, $ref ) = @_;
    LOG_ENTER_SUB;
    ref( $self->_lwp ) eq $PERL_MODULE_IBLWP || LOG_FATAL;

    LOG_FATAL PRINT_MYNAMELINE;
    LOG_EXIT_SUB;
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub get_ib_record {
    my ( $self, $ref ) = @_;
    my $ibr_rec = undef;

    LOG_ENTER_SUB;

    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;

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
sub load_record_field {
    my ( $self, $ref, $f ) = @_;
    my $ibr;

    LOG_ENTER_SUB;

    defined $ref                    || LOG_FATAL;
    URL_FIELD_EXISTS($f)            || LOG_FATAL;
    $self->_return_field_exists($f) || LOG_FATAL "'$f' NOT A RETURN FIELD";

    if ( ref($ref) eq $PERL_MODULE_IBRECORD ) {
        $ibr = $ref;
    }
    if ( URL_REF_MODULE_EXISTS($ref) ) {
        $ibr = $self->get_ib_record($ref);
    }

    my $ret = $self->_lwp->get(
        {
            $IBLWP_GET_RECORD => $ibr,
            $IBLWP_GET_RETURN_PLUS_REF => { $f => 1, },
        } );

    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
sub verify_record {
    my ( $self, $ref ) = @_;
    my $ibr_rec = undef;

    LOG_ENTER_SUB;

    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;

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
    my ( $self, $ref, $field, $extattr ) = @_;
    my $ibr_rec   = undef;
    my $ret_field = undef;

    LOG_ENTER_SUB;

    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;
    $self->_return_field_exists($field) || LOG_FATAL;

    if ( defined( $ibr_rec = $self->get_ib_record($ref) ) ) {
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

    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;
    ( defined $attr && $attr ne '' ) || LOG_FATAL;

    if ( defined( $ibr_rec = $self->get_ib_record($ref) ) ) {
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

    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;
    $self->_return_field_exists($field) || LOG_FATAL;

    # Verify TYPE HERE

    if ( defined( $ibr_rec = $self->get($ref) ) ) {
        $ibr_rec->update_field( $field, $value );
    }

    LOG_EXIT_SUB;

}

# ---------------------------------------------------------------------------------
# Add an IBRecord to the _IB_RECORD HASH
# ---------------------------------------------------------------------------------
sub add_ib_record {
    my ( $self, $obj ) = @_;
    my $ret = 0;

    LOG_ENTER_SUB;

    ( defined $obj && ref($obj) eq $PERL_MODULE_IBRECORD ) || LOG_FATAL;
    my $ref = $obj->get_ref();
    ( defined $ref && URL_REF_MODULE_EXISTS($ref) ) || LOG_FATAL;

    my $name = ( split( /\//, $ref ) )[0];
    my $obj_name = URL_NAME_MODULE($name);

    ( $obj_name eq $self->_obj_name ) || LOG_FATAL;

    if ( defined $self->{$_IB_RECORDS}->{$ref} ) {
        LOG_FATAL "Adding the same object: '$ref'\n";
    }
    else {
        $self->{$_IB_RECORDS}->{$ref} = $obj;
        $ret = 1;
        LOG_INFO "Adding the new ib record: '$ref'\n";
    }

    LOG_EXIT_SUB;
    $ret;

}

# ----------------------------------------------------------------------
# Returns T/F
# ----------------------------------------------------------------------
sub is_field_readonly {
    my ( $self, $field ) = @_;

    LOG_ENTER_SUB;
    my $ret = $self->_readonly_field_exists($field);
    LOG_EXIT_SUB;
    return $ret;

}

# ----------------------------------------------------------------------
# Returns T/F
# ----------------------------------------------------------------------
sub is_field_searchable {
    my ( $self, $field ) = @_;

    LOG_ENTER_SUB;
    my $ret = $self->_searchable_field_exists($field);
    LOG_EXIT_SUB;
    return $ret;

}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _obj_name {
    my ($self) = @_;

    LOG_ENTER_SUB;

    defined $self->{$_IB_OBJECT_NAME} || LOG_FATAL;

    LOG_EXIT_SUB;
    $self->{$_IB_OBJECT_NAME};
}

# ---------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------
sub _lwp {
    my ($self) = @_;

    LOG_ENTER_SUB;

    defined $self->{$_LWP_OBJ} || LOG_FATAL;

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
            $self->is_field_searchable($p) || LOG_FATAL "FIELD '$p' NOT SEARCHABLE FOR " . $self->{$_IB_OBJECT_NAME};
            ref( $parm_ref->{$p} ) eq 'ARRAY' || LOG_FATAL;
            defined $parm_ref->{$p}->[0]              || LOG_FATAL;
            defined $parm_ref->{$p}->[1]              || LOG_FATAL;
            URL_SEARCH_EXISTS( $parm_ref->{$p}->[0] ) || LOG_FATAL;

            $ret .= '&';
            $ret .= URL_FIELD_NAME($p) . URL_SEARCH_NAME( $parm_ref->{$p}->[0] ) . $parm_ref->{$p}->[1];

        }
        else {
            LOG_WARN "SEARCH PARM $p NOT FOUND\n";
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

    if ( !defined $parm_ref ) {
        LOG_WARN MYNAMELINE . " NO PARM_REF defined\n";
        return;
    }

    foreach my $p ( sort( keys(%$parm_ref) ) ) {
        if ( URL_FIELD_EXISTS($p) ) {
            ( $self->is_field_searchable($p) ) || LOG_FATAL;
            ( ref( $parm_ref->{$p} ) eq 'ARRAY' ) || LOG_WARN;

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

    defined $parm_ref || LOG_FATAL;

    if ( ref($parm_ref) eq 'HASH' ) {
        foreach my $k ( keys(%$parm_ref) ) {
            $self->_return_field_exists($k) || LOG_FATAL "'$k' NOT A RETURN FIELD";
        }
    }
    elsif ( ref($parm_ref) eq 'ARRAY' ) {
        foreach my $k (@$parm_ref) {
            $self->_return_field_exists($k) || LOG_FATAL "'$k' NOT A RETURN FIELD";
        }
    }
    else {
        $self->_return_field_exists($parm_ref) || LOG_FATAL "'$parm_ref' NOT A RETURN FIELD";
    }

    LOG_EXIT_SUB;
}

# ----------------------------------------------------------------------
# return Field Exists
# ----------------------------------------------------------------------
sub _return_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || LOG_FATAL PRINT_MYNAMELINE;
    URL_FIELD_EXISTS($f) || LOG_FATAL PRINT_MYNAMELINE;

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

    defined $f || LOG_FATAL PRINT_MYNAMELINE;
    URL_FIELD_EXISTS($f) || LOG_FATAL PRINT_MYNAMELINE;

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

    defined $f || LOG_FATAL PRINT_MYNAMELINE;
    URL_FIELD_EXISTS($f) || LOG_FATAL PRINT_MYNAMELINE;

    my $ret = $self->_field_exists( $self->{$_IB_READONLY_FIELDS}, $f );
    LOG_EXIT_SUB;
    return $ret;
}

# ----------------------------------------------------------------------
# Searchable Field Exists
# ----------------------------------------------------------------------
sub _searchable_field_exists {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    defined $f || LOG_FATAL PRINT_MYNAMELINE;
    URL_FIELD_EXISTS($f) || LOG_FATAL PRINT_MYNAMELINE;

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

    defined $table_ref   || LOG_FATAL PRINT_MYNAMELINE;
    defined $f           || LOG_FATAL PRINT_MYNAMELINE;
    URL_FIELD_EXISTS($f) || LOG_FATAL PRINT_MYNAMELINE;

    my $ret = defined $table_ref->{$f};
    LOG_EXIT_SUB;
    return $ret;

}

1;
