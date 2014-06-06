#!/usr/bin/perl

package IBRecord;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use IBStruct::ExtensibleAttributes;
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
sub _create_or_update_value;     # Get Field, Compare Field, update if needed
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

    defined $parent || LOG_FATAL;
    ref($parent) =~ /^IBWAPI/ || LOG_FATAL;
    defined $field_ref || LOG_FATAL;
    ref($field_ref) eq 'HASH' || LOG_FATAL;
    defined $field_ref->{$FIELD_REF} || LOG_FATAL;

    $s{$_IBR_FIELD_VALUES} = \%v;
    $s{$_IBR_FIELD_LOADED} = \%l;
    $s{$_IBR_DIRTY_FIELDS} = \%d;
    $s{$_IBR_DIRTY}        = 0;
    $s{$_IBR_REF}          = undef;
    $s{$_IBR_PARENT}       = $parent;

    bless $self, $class;

    #
    # Load the object filed values
    #
    foreach my $key ( sort( keys(%$field_ref) ) ) {

        if ( $key eq $FIELD_REF ) {
            $s{$_IBR_REF} = $field_ref->{$key};
            next;
        }

        URL_FIELD_EXISTS($key) || LOG_FATAL;

        $self->_create_or_update_value( $key, $field_ref->{$key} );

        $l{$key} = 1;
        $d{$key} = 0;

    }

    ( defined $s{$_IBR_REF} && $s{$_IBR_REF} ne '' ) || LOG_FATAL "NO REF DEFINED";

    LOG_EXIT_SUB;

    $self;
}

# ---------------------------
# get_field (go get it if not loaded yet)
# ---------------------------
sub get_field {
    my ( $self, $f, $f2 ) = @_;
    my $ret;

    LOG_ENTER_SUB "($f)";

    ( defined $f && $f ne '' ) || LOG_FATAL;
    URL_FIELD_EXISTS($f) || LOG_FATAL;

    my $type = URL_FIELD_TYPE($f);

    #
    # Field not loaded so go get it, then proceed
    #
    if ( !defined $self->{$_IBR_FIELD_LOADED}->{$f} || $self->{$_IBR_FIELD_LOADED}->{$f} ) {
        LOG_DEBUG4 Dumper $self->{$_IBR_FIELD_LOADED};
        $self->_load_field($f);
    }

    if (
        ( $type eq $TYPE_STRING )
        || ( $type eq $TYPE_STRING_ARRAY )
        || ( $type eq $TYPE_BOOL )
        || ( $type eq $TYPE_INT )
        || ( $type eq $TYPE_TIMESTAMP )
        || ( $type eq $TYPE_UINT )
      ) {
        $ret = $self->{$_IBR_FIELD_VALUES}->{$f};
    }
    elsif ( $type eq $TYPE_EXTATTRS ) {
        ref( $self->{$_IBR_FIELD_VALUES}->{$f} ) eq $PERL_MODULE_EXTATTR 
		|| LOG_FATAL "REF:" . Dumper( $self->{$_IBR_FIELD_VALUES}->{$f} );
        ( defined $f2 && $f2 ne '' ) || LOG_FATAL Dumper $f2;

        $ret = $self->{$_IBR_FIELD_VALUES}->{$f}->get_field($f2);
    }
    #
    # IBStruct
    #
    elsif ( ref( $self->{$_IBR_FIELD_VALUES}->{$f} ) ne '' ) {
        ( defined $f2 && $f2 eq '' ) || LOG_FATAL;

        $ret = $self->{$_IBR_FIELD_VALUES}->{$f}->get_field($f2);
    }
    else {
        LOG_FATAL "get TYPE: $type not supported\n";
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

    ( defined $f && $f ne '' ) || LOG_FATAL;

    $ret = $self->get_field( $FIELD_EXTATTRS, $f );

    LOG_EXIT_SUB;

    $ret;
}

# ---------------------------
# update_field (go get it if not loaded yet)
# ---------------------------
sub update_field {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    LOG_ENTER_SUB;

    URL_FIELD_EXISTS($f) || LOG_FATAL;
    ref($v) ne '' || LOG_FATAL "Need to check for structs here";

    $self->_parent->is_field_readonly($f) && LOG_FATAL "READONLY FIELD $f";

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
sub _create_or_update_value {
    my ( $self, $f, $v ) = @_;
    my $dirty = 0;

    LOG_ENTER_SUB;

    if ( $f ne $FIELD_REF ) {

        URL_FIELD_EXISTS($f) || LOG_FATAL;

        my $type = URL_FIELD_TYPE($f);

        my $current = $self->{$_IBR_FIELD_VALUES}->{$f};

        LOG_DEBUG4 "FIELD:$f";
        LOG_DEBUG4 "TYPE:$type";
        LOG_DEBUG4 "VALUE:" . Dumper $v;
        LOG_DEBUG4 "CURRENT:" . Dumper $current;

	#
	# INT and UINT
	#
        if ( $type eq $TYPE_INT || $type eq $TYPE_UINT ) {
            $type eq $TYPE_UINT && $v < 0 && LOG_FATAL;

            if ( !( $current == $v ) ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
                $dirty++;
            }
        }
	#
	# STRING and TIMESTAMP
	#
        elsif ( $type eq $TYPE_STRING || $type eq $TYPE_TIMESTAMP ) {
            $type eq $TYPE_TIMESTAMP && !VERIFY_TIMESTAMP($v) && LOG_FATAL;
            if ( $current ne $v ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
                $dirty++;
            }
        }
	#
	# STRING_ARRAY
	#
        elsif ( $type eq $TYPE_STRING_ARRAY ) {
            if ( $current ne $v ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = $v;
                $dirty++;
            }
        }
	#
	# EXTATTRS
	#
        elsif ( $type eq $TYPE_EXTATTRS ) {
            $self->{$_IBR_FIELD_VALUES}->{$f} = IBStruct::ExtensibleAttributes->new($v);
            $dirty++;
        }
	#
	# BOOL
	#
        elsif ( $type eq $TYPE_BOOL ) {
            ref($v) eq $PERL_MODULE_JSON_BOOLEAN || LOG_FATAL "REF:" . ref($v) . ' ne ' . $PERL_MODULE_JSON_BOOLEAN;
            if ( !defined $current || $current eq ( $v ? $IB_TRUE : $IB_FALSE ) ) {
                $self->{$_IBR_FIELD_VALUES}->{$f} = ( $v ? $IB_TRUE : $IB_FALSE );
                $dirty++;
            }
        }
	#
	# OH NO!
	#
        else {
            LOG_FATAL "Updating TYPE: $type Not supported yet";
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
# update_value
# ---------------------------
sub _update_value_mark_dirty {
    my ( $self, $f, $v ) = @_;

    LOG_ENTER_SUB;
    if ( $self->_create_or_update_value( $f, $v ) ) {
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

    defined $rec_ref || LOG_FATAL;

    #
    # Needs work
    #
    foreach my $f ( keys(%$rec_ref) ) {
        URL_FIELD_EXISTS($f) || LOG_FATAL;
        my $v = $rec_ref->{$f};

        LOG_DEBUG4 MYNAMELINE . "$f: $v";

        $self->_create_or_update_value( $f, $v );

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
    my $ret;

    LOG_ENTER_SUB;

    $ret = $self->{$_IBR_REF};

    LOG_EXIT_SUB;

    $ret;
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

    $self->_parent->load_record_field( $self, $f );
    $self->{$_IBR_FIELD_LOADED}->{$f} = 1;

    LOG_EXIT_SUB;

}

# ---------------------------
# _parent
# ---------------------------
sub _parent {
    my ($self) = @_;
    my $ret;

    LOG_ENTER_SUB;

    $ret = $self->{$_IBR_PARENT};

    LOG_EXIT_SUB;

    $ret;

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

    ref($json_array) eq 'ARRAY' || LOG_FATAL;

    foreach my $rec (@$json_array) {
        defined $rec->{$_IB_REF} || LOG_FATAL;

        my %r = ();
        $result{ $rec->{$_IB_REF} } = \%r;
        foreach my $r ( keys(%$rec) ) {
            $r{ URL_NAME_FIELD($r) } = $rec->{$r};
        }
    }

    LOG_DEBUG4 Dumper \%result;

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

    ref($json_hash) eq 'HASH' || LOG_FATAL;
    defined $json_hash->{$_IB_REF} || LOG_FATAL;

    my %r = ();
    $result{ $json_hash->{$_IB_REF} } = \%r;
    foreach my $r ( keys(%$json_hash) ) {
        $r{ URL_NAME_FIELD($r) } = $json_hash->{$r};
    }

    LOG_DEBUG4 Dumper \%result;

    LOG_EXIT_SUB;

    \%result;
}

1;
