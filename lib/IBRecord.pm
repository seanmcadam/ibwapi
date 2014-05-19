#!/usr/bin/perl

package IBRecord;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use Data::Dumper;
use Carp;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------
sub get_ref;
sub get_field;
sub update_field;
sub is_dirty;
sub flush;
sub _get_field;
sub _flush;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_IBR_REF          => '_IBR_REF';
Readonly our $_IBR_PARENT       => '_IBR_PARENT';
Readonly our $_IBR_DIRTY        => '_IBR_DIRTY';
Readonly our $_IBR_DIRTY_FIELDS => '_IBR_DIRTY_FIELDS';
Readonly our $_IBR_FIELD_VALUES => '_IBR_FIELD_VALUES';

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parent, $field_ref ) = @_;
    my %s;
    my %v;
    my %d;
    my $self = \%s;
    $s{$_IBR_FIELD_VALUES} = \%v;
    $s{$_IBR_REF}          = 0;
    $s{$_IBR_DIRTY_FIELDS} = \%d;
    $s{$_IBR_DIRTY}        = 0;

    if ( ( !defined $parent ) || ( ref($parent) =~ /IBWAPI::/ ) ) { confess @_; }
    if ( ( !defined $field_ref ) || ( ref($field_ref) ne 'HASH' ) ) { confess @_; }

    if ( !defined $field_ref->{$FIELD_REF} ) { confess @_; }

    #
    # Load the object filed values
    #
    foreach my $key ( sort( keys(%$field_ref) ) ) {
        if ( $key eq $FIELD_REF ) { next; }

        if ( !URL_FIELD_EXISTS($key) ) { confess @_; }
        $v{$key} = $field_ref->{$key};
        $d{$key} = 0;

    }

    bless $self, $class;
    $self;
}

# ---------------------------
# get_field (go get it if not loaded yet)
# ---------------------------
sub get_field {
    my ( $self, $f ) = @_;

    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }

    #
    # Field not loaded so go get it, then proceed
    #
    if ( !defined $self->{$_IBR_FIELD_VALUES}->{$f} ) {
        $self->_get_field($f);
    }

    $self->{$_IBR_FIELD_VALUES}->{$f};
}

# ---------------------------
# update_field (go get it if not loaded yet)
# ---------------------------
sub update_field {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }
    if ( ref($v) ne '' ) { confess "Need to check for structs here\n"; }

    my $type    = URL_FIELD_TYPE($f);
    my $current = $self->{$_IBR_FIELD_VALUES}->{$f};

    #
    # Field not loaded so go get it, then proceed
    #
    if ( !defined $self->{$_IBR_FIELD_VALUES}->{$f} ) {
        $self->_get_field($f);
    }

    if ( $type eq $TYPE_BOOL ) {
        if ( $current ^ $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    elsif ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
        if ( !( $current == $v ) ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
        if ( $current ne $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            $dirty++;
        }
    }
    else {
        confess "Updating TYPE: $type Not supported yet\n";
    }

    #$TYPE_EXTATTRS
    #$TYPE_MEMBERS
    #$TYPE_OPTIONS
    #$TYPE_STRING_ARRAY
    #$TYPE_UNKNOWN
    #$TYPE_ZONE_ASSOCIATIONS

    if ($dirty) {
        $self->{$_IBR_DIRTY}->{$f} = $v;
        $self->{$_IBR_DIRTY_FIELDS}->{$f}++;
    }

}

# ---------------------------
# ref
# ---------------------------
sub get_ref {
    my ($self) = @_;
    $self->{$_IBR_REF};
}

# ---------------------------
# is_dirty
# ---------------------------
sub is_dirty {
    my ($self) = @_;
    $self->{$_IBR_DIRTY};
}

# ---------------------------
# flush
# ---------------------------
sub flush {
    my ($self) = @_;
    if ( $self->is_dirty ) {
        $self->_flush( $self->{$_IBR_REF} );
    }
}

# ---------------------------
# _get_field, go to the server and get the field
# ---------------------------
sub _get_field {
    my ( $self, $f ) = @_;
    $self->{$_IBR_FIELD_VALUES}->{$f};

    #
    # Call parent->get_ref( _ref, field )
    #

}

# ---------------------------
# _flush
# ---------------------------
sub _flush {
    my ($self) = @_;
    if ( $self->is_dirty() ) {

        #
        # Call parent->flush_ref( _ref, field )
        #
        $self->{$_IBR_DIRTY} = 0;
        foreach my $f ( keys( %{ $self->{$_IBR_DIRTY} } ) ) {
            $self->{$_IBR_DIRTY}->{$f} = 0;
        }

    }
}

1;
