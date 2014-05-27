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
sub get_ref;
sub get_field;
sub add_field;
sub update_field;
sub reload_record;
sub is_dirty;
sub flush;
sub _get_field;
sub _flush;
sub _lwp;
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
    my %d;
    my $self = \%s;

    LOG_ENTER_SUB;

    if ( ( !defined $parent ) || ( !( ref($parent) =~ /IBWAPI::/ ) ) ) { confess Dumper $parent; }
    if ( ( !defined $field_ref ) || ( ref($field_ref) ne 'HASH' ) ) { confess Dumper $field_ref; }

    if ( !defined $field_ref->{$FIELD_REF} ) { confess @_; }

    $s{$_IBR_FIELD_VALUES} = \%v;
    $s{$_IBR_REF}          = undef;
    $s{$_IBR_DIRTY_FIELDS} = \%d;
    $s{$_IBR_DIRTY}        = 0;
    $s{$_IBR_PARENT}       = $parent;

    #
    # Load the object filed values
    #
    foreach my $key ( sort( keys(%$field_ref) ) ) {

        if ( $key eq $FIELD_REF ) {
            $s{$_IBR_REF} = $field_ref->{$key};
            next;
        }

        if ( !URL_FIELD_EXISTS($key) ) { confess @_; }
        $v{$key} = $field_ref->{$key};
        $d{$key} = 0;

    }

    if ( !defined $s{$_IBR_REF} || !$s{$_IBR_REF} ) { confess MYNAMELINE("NO REF DEFINED"); }

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
    if ( !defined $self->{$_IBR_FIELD_VALUES}->{$f} ) {
        $self->_get_field($f);
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
sub add_field {
    my ( $self, $f, $v ) = @_;

    LOG_ENTER_SUB;

    if ( !URL_FIELD_EXISTS($f) ) { confess @_; }
    if ( ref($v) ne '' ) { confess "Need to check for structs here\n"; }

    my $type    = URL_FIELD_TYPE($f);
    my $current = $self->{$_IBR_FIELD_VALUES}->{$f};

    #
    # Field exists already
    #
    if ( defined $self->{$_IBR_FIELD_VALUES}->{$f} ) {
        warn MYNAMELINE . " Field:$f Exists already\n";
    }

    if ( $type eq $TYPE_BOOL ) {
        if ( $current ^ $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
        }
    }
    elsif ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
        if ( !( $current == $v ) ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
        }
    }
    elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
        if ( $current ne $v ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
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

    LOG_EXIT_SUB;

}

# ---------------------------
# update_field (go get it if not loaded yet)
# ---------------------------
sub update_field {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    LOG_ENTER_SUB;

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

    LOG_EXIT_SUB;

}

# ---------------------------
# reload_record (called from LWP)
# ---------------------------
sub reload_record {
    my ( $self, $rec_ref ) = @_;

    LOG_ENTER_SUB;

    if ( !defined $rec_ref ) { confess @_; }

    foreach my $f ( keys(%$rec_ref) ) {
        if ( !URL_FIELD_EXISTS($f) ) { confess Dumper @_; }
        my $v       = $rec_ref->{$f};
        my $type    = URL_FIELD_TYPE($f);
        my $current = $self->{$_IBR_FIELD_VALUES}->{$f};

        # $self->{$_IBR_FIELD_VALUES}->{$f} = $rec_ref->{$f};

        if ( $type eq $TYPE_BOOL ) {
            if ( $current ^ $v ) {
                print MYNAMELINE . " $type Update $f = $v\n" if $DEBUG;
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            }
        }
        elsif ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
            if ( !( $current == $v ) ) {
                print MYNAMELINE . " $type Update $f = $v\n" if $DEBUG;
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            }
        }
        elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
            if ( $current ne $v ) {
                print MYNAMELINE . " $type Update $f = $v\n" if $DEBUG;
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            }
        }
        elsif ( $type eq $TYPE_EXTATTRS ) {
            if ( ref($v) ne 'HASH' ) { confess; }
            if ( defined $current && ref($current) ne 'HASH' ) { confess; }

            #
            # Load new values from server
            #
            if ( !defined $current ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
            }

            #
            # Values from the server were removed (erased)
            # untested, and unliley
            #
            elsif ( !defined $v ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = undef;
            }

            #
            # Update new values from server
            #
            else {

                #
                # Untested...
                #
                foreach my $attr ( sort( keys(%$v) ) ) {
                    if ( !( ( $self->{$_IBR_FIELD_VALUES}->{$f}->{$attr} eq $v->{$attr} )
                            || ( $self->{$_IBR_FIELD_VALUES}->{$f}->{$attr} == $v->{$attr} ) ) ) {
                        $self->{$_IBR_FIELD_VALUES}->{$f}->{$attr} = $v->{$attr};
                    }

                }
            }

        }
        else {
            confess "Updating TYPE: $type Not supported yet\n";
        }

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

    $self->{$_IBR_DIRTY};

    LOG_EXIT_SUB;
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
# _lwp
# ---------------------------
sub _lwp {
    my ($self) = @_;

    LOG_ENTER_SUB;

    my $ret = $self->{$_IBR_PARENT}->_lwp();

    LOG_EXIT_SUB;

    return $ret;
}

# ---------------------------
# _get_field, go to the server and get the field, and return it
# Returns nothing
# ---------------------------
sub _get_field {
    my ( $self, $f ) = @_;

    LOG_ENTER_SUB;

    my $ret = $self->_lwp->get( $self, $f );

    LOG_EXIT_SUB;

    return $ret;

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
