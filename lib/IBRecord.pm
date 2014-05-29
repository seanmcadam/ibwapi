#!/usr/bin/perl

package IBRecord;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use Data::Dumper;
use Carp;
use Readonly;
use strict;

use base qw( Exporter );

# ---------------------------
# PROTOTYPES
# ---------------------------
sub get_ref;          # Return the REF for the record
sub get_field;        # Return the field value
sub update_field;     # Add new value or get existing value update, and mark dirty
sub reload_record;    # Get the record from the server and reload values, make all clean
sub is_dirty;         # Indicate Dirty Status
sub flush;            # If Dirty flush the dirty values out

#
### These call the parent for action
#
sub _load_field;                 # Load Field, Mark Filed Loaded
sub _load_all;                   # Load All Fields, Mark Fields Loaded
sub _update_value;               # Get Field, Compare Field, update if needed
sub _update_value_mark_dirty;    # Mark Dirty if value change
sub _flush;                      # Call the flush action

sub CONVERT_JSON_ARRAY_TO_IB_FORMAT;
sub CONVERT_JSON_HASH_TO_IB_FORMAT;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_IBR_REF          => '_IBR_REF';
Readonly our $_IBR_PARENT       => '_IBR_PARENT';
Readonly our $_IBR_DIRTY        => '_IBR_DIRTY';
Readonly our $_IBR_DIRTY_FIELDS => '_IBR_DIRTY_FIELDS';
Readonly our $_IBR_FIELD_VALUES => '_IBR_FIELD_VALUES';
Readonly our $_IBR_FIELD_LOADED => '_IBR_FIELD_LOADED';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  CONVERT_JSON_ARRAY_TO_IB_FORMAT
  CONVERT_JSON_HASH_TO_IB_FORMAT
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parent, $field_ref ) = @_;
    my %s;
    my %v;
    my %l;
    my %d;
    my $self = \%s;

    LOG_ENTER_SUB;

    if ( ( !defined $parent ) || ( !( ref($parent) =~ /IBWAPI::/ ) ) ) { confess Dumper $parent; }
    if ( ( !defined $field_ref ) || ( ref($field_ref) ne 'HASH' ) ) { confess Dumper $field_ref; }

    if ( !defined $field_ref->{$FIELD_REF} ) { confess @_; }

    $s{$_IBR_FIELD_VALUES} = \%v;
    $s{$_IBR_FIELD_LOADED} = \%l;
    $s{$_IBR_DIRTY_FIELDS} = \%d;
    $s{$_IBR_DIRTY}        = 0;
    $s{$_IBR_REF}          = undef;
    $s{$_IBR_PARENT}       = $parent;

    #
    # Load the object filed values
    #
    foreach my $key ( sort( keys(%$field_ref) ) ) {

        if ( $key eq $FIELD_REF ) {
            $s{$_IBR_REF} = $field_ref->{$key};
            next;
        }

        URL_FIELD_EXISTS($key) || LOG_FATAL;
        $v{$key} = $field_ref->{$key};
        $l{$key} = 1;
        $d{$key} = 0;

    }

    ( defined $s{$_IBR_REF} && $s{$_IBR_REF} ne '' ) || LOG_FATAL "NO REF DEFINED";

    bless $self, $class;

    LOG_EXIT_SUB;

    $self;
}

# ---------------------------
# get_field (go get it if not loaded yet)
# ---------------------------
sub get_field {
    my ( $self, $f, $f2 ) = @_;
    my $ret;

    LOG_ENTER_SUB;

    if ( !defined $f || $f eq '' ) { confess @_; }
    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }
    my $type = URL_FIELD_TYPE($f);

    if ( $type eq $TYPE_EXTATTRS && ( !defined $f2 || $f2 eq '' ) ) {
        confess "Second Parameter required for EXTATTRS get requests\n";
    }

    #
    # Field not loaded so go get it, then proceed
    #
    if ( !defined $self->{$_IBR_FIELD_LOADED}->{$f} ) {
        $self->_load_field($f);
    }

    if (
        ( $type eq $TYPE_STRING )
        || ( $type eq $TYPE_BOOL )
        || ( $type eq $TYPE_INT )
        || ( $type eq $TYPE_TIMESTAMP )
        || ( $type eq $TYPE_UINT )
      ) {
        $ret = $self->{$_IBR_FIELD_VALUES}->{$f};
    }
    elsif ( $type eq $TYPE_EXTATTRS ) {
        if ( defined $self->{$_IBR_FIELD_VALUES}->{$FIELD_EXTATTRS}->{$f} ) {
            if ( !defined $self->{$_IBR_FIELD_VALUES}->{$FIELD_EXTATTRS}->{$f}->{$EXTATTR_VALUE} ) {
                confess "NO EXTATTR VLAUE for " . Dumper $self->{$_IBR_FIELD_VALUES}->{$FIELD_EXTATTRS}->{$f};
            }
            $ret = $self->{$_IBR_FIELD_VALUES}->{$FIELD_EXTATTRS}->{$f}->{$EXTATTR_VALUE};
        }
    }
    else {
        confess "get TYPE: $type not supported\n";
    }

    LOG_EXIT_SUB;

    $ret;
}

# ---------------------------
# get_extattr_field
# ---------------------------
sub get_extattr_field {
    my ( $self, $f ) = @_;
    my $ret;

    LOG_ENTER_SUB;

    if ( !defined $f || $f eq '' ) { confess @_; }

    $ret = $self->get_field( $FIELD_EXTATTRS, $f );

    LOG_EXIT_SUB;

    $ret;
}

# ---------------------------
# add_field
# ---------------------------
###sub add_field {
###    my ( $self, $f, $v ) = @_;
###
###    LOG_ENTER_SUB;
###
###    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }
###    if ( ref($v) ne '' ) { confess "Need to check for structs here\n"; }
###
###    my $type    = URL_FIELD_TYPE($f);
###    my $current = $self->{$_IBR_FIELD_VALUES}->{$f};
###
###    #
###    # Field exists already
###    #
###    if ( defined $self->{$_IBR_FIELD_LOADED}->{$f} ) {
###        LOG_WARN " Field:$f Exists already\n";
###    }
###
###    if ( $type eq $TYPE_BOOL ) {
###        if ( $current ^ $v ) {
###            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
###        }
###    }
###    elsif ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
###        if ( !( $current == $v ) ) {
###            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
###        }
###    }
###    elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
###        if ( $current ne $v ) {
###            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
###        }
###    }
###    else {
###        confess "Updating TYPE: $type Not supported yet\n";
###    }
###
###    #$TYPE_EXTATTRS
###    #$TYPE_MEMBERS
###    #$TYPE_OPTIONS
###    #$TYPE_STRING_ARRAY
###    #$TYPE_UNKNOWN
###    #$TYPE_ZONE_ASSOCIATIONS
###
###    LOG_EXIT_SUB;
###
###}

# ---------------------------
# update_field (go get it if not loaded yet)
# ---------------------------
sub update_field {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    LOG_ENTER_SUB;

    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }
    ref($v) ne '' || LOG_FATAL "Need to check for structs here";

    #
    # Field not loaded so go get it, then proceed
    #
    if ( !defined $self->{$_IBR_FIELD_LOADED}->{$f} ) {
        $self->_load_field($f);
    }

    $self->_update_value_mark_dirty( $f, $v );

    LOG_EXIT_SUB;

}

# ---------------------------
# update_value
# ---------------------------
sub _update_value {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    LOG_ENTER_SUB;

    if( $f eq $FIELD_REF ) { return; }

    URL_FIELD_EXISTS($f) || LOG_FATAL;
    ref($v) ne '' && LOG_FATAL "Value is a Struct:" . ref($v);

    ### defined $self->{$_IBR_FIELD_LOADED}->{$f} || LOG_FATAL "Filed no Loaded: $f";

    my $type = URL_FIELD_TYPE($f);

    my $current = $self->{$_IBR_FIELD_VALUES}->{$f};

    if ( !defined $self->{$_IBR_FIELD_VALUES}->{$f} ) {
        $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
        $dirty++;
    }
    elsif ( $type eq $TYPE_BOOL ) {
        if ( $current ^ $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    elsif ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
        $type eq $TYPE_UINT && $v < 0 && LOG_FATAL;

        if ( !( $current == $v ) ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
        $type eq $TYPE_TIMESTAMP && !VERIFY_TIMESTAMP($v) && LOG_FATAL;
        if ( $current ne $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    else {
        LOG_FATAL "Updating TYPE: $type Not supported yet";
    }

    #$TYPE_EXTATTRS
    #$TYPE_MEMBERS
    #$TYPE_OPTIONS
    #$TYPE_STRING_ARRAY
    #$TYPE_UNKNOWN
    #$TYPE_ZONE_ASSOCIATIONS

    LOG_EXIT_SUB;

}

# ---------------------------
# update_value
# ---------------------------
sub _update_value_mark_dirty {
    my ( $self, $f, $v ) = @_;

    LOG_ENTER_SUB;
    if ( $self->_update_value( $f, $v ) ) {
        $self->{$_IBR_DIRTY}++;
        $self->{$_IBR_DIRTY_FIELDS}->{$f}++;
    }
    LOG_EXIT_SUB;
}

# ---------------------------
# reload_record (called from LWP)
# ---------------------------
sub reload_record {
    my ( $self, $rec_ref ) = @_;

    LOG_ENTER_SUB;

    if ( !defined $rec_ref ) { confess @_; }

    #
    # Needs work
    #
    foreach my $f ( keys(%$rec_ref) ) {
        URL_FIELD_EXISTS($f) || LOG_FATAL;
        my $v = $rec_ref->{$f};

        $self->_update_value( $f, $v );

        $self->{$_IBR_DIRTY_FIELDS}->{$f} = undef;
        $self->{$_IBR_FIELD_LOADED}->{$f} = 1;
    }

    LOG_EXIT_SUB;

}

# ---------------------------
# ref
# ---------------------------
sub get_ref {
    my ($self) = @_;

    LOG_ENTER_SUB;

    return $self->{$_IBR_REF};

    LOG_EXIT_SUB;
}

# ---------------------------
# is_dirty
# ---------------------------
sub is_dirty {
    my ($self) = @_;

    LOG_ENTER_SUB;

    LOG_EXIT_SUB;

    $self->{$_IBR_DIRTY};
}

# ---------------------------
# flush
# ---------------------------
sub flush {
    my ($self) = @_;

    LOG_ENTER_SUB;

    if ( $self->is_dirty ) {
        $self->_flush( $self->{$_IBR_REF} );
    }

    LOG_EXIT_SUB;
}

# ---------------------------
# _get_field, go to the server and get the field, and return it
# Returns nothing
# ---------------------------
sub _load_field {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    $self->{$_IBR_PARENT}->load_record_field( $self, $f );
    $self->{$_IBR_FIELD_LOADED}->{$f} = 1;

    LOG_EXIT_SUB;

}

# ---------------------------
# _flush
# ---------------------------
sub _flush {
    my ($self) = @_;

    LOG_ENTER_SUB;

    if ( $self->is_dirty() ) {

        #
        # Call parent->flush_ref( _ref, field )
        #
        $self->{$_IBR_DIRTY} = 0;
        foreach my $f ( keys( %{ $self->{$_IBR_DIRTY} } ) ) {
            $self->{$_IBR_DIRTY}->{$f} = 0;
        }

    }

    LOG_EXIT_SUB;

}

# ---------------------------
#
# ---------------------------
sub CONVERT_JSON_ARRAY_TO_IB_FORMAT {
    my ($json_array) = @_;
    my %result = ();

    LOG_ENTER_SUB;

    if ( ref($json_array) ne 'ARRAY' ) { confess Dumper @_; }

    foreach my $rec (@$json_array) {
        if ( !defined $rec->{$_IB_REF} ) { confess Dumper @_; }
        my %r = ();
        $result{ $rec->{$_IB_REF} } = \%r;
        foreach my $r ( keys(%$rec) ) {
            $r{ URL_NAME_FIELD($r) } = $rec->{$r};
        }
    }

    LOG_EXIT_SUB;

    \%result;
}

# ---------------------------
#
# ---------------------------
sub CONVERT_JSON_HASH_TO_IB_FORMAT {
    my ($json_hash) = @_;
    my %result = ();

    LOG_ENTER_SUB;

    if ( ref($json_hash) ne 'HASH' ) { confess Dumper @_; }
    if ( !defined $json_hash->{$_IB_REF} ) { confess Dumper @_; }

    my %r = ();
    $result{ $json_hash->{$_IB_REF} } = \%r;
    foreach my $r ( keys(%$json_hash) ) {
        $r{ URL_NAME_FIELD($r) } = $json_hash->{$r};
    }

    LOG_EXIT_SUB;

    \%result;
}

1;
