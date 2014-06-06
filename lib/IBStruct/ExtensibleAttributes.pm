#!/usr/bin/perl

package IBStruct::ExtensibleAttributes;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# our @ISA = qw(IBStruct);

# ---------------------------
# PROTOTYPES
# ---------------------------
sub get_field;    # Override the parent

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly our $_EA_FIELDS       => '_EA_FIELDS';
Readonly our $_EA_DIRTY_FIELDS => '_EA_DIRTY_FIELDS';

# ---------------------------
# VARIABLES
# ---------------------------
my %_FIELDS => (
);
# my %_FIELD_TYPES => (
# );
# my %_DIRTY_FIELDS => (
# );

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my $self;
    LOG_ENTER_SUB;
    defined $parm_ref || LOG_FATAL;

    ref($parm_ref) eq "HASH" || LOG_FATAL;

    $self->{$_EA_FIELDS} = \%_FIELDS;

    LOG_DEBUG4 "DUMP:" . Dumper $parm_ref;

    foreach my $extattr (sort(keys(%$parm_ref))) {
	defined $parm_ref->{$extattr}->{$EXTATTR_VALUE} || LOG_FATAL "EXTATTR:" . Dumper $parm_ref->{$extattr};
        $self->{$_EA_FIELDS}->{$extattr} = $parm_ref->{$extattr}->{$EXTATTR_VALUE};
    }

    bless $self, $class;

    LOG_EXIT_SUB;

    $self;
}

# ---------------------------
#
# ---------------------------
sub get_field {
    my ( $self, $field ) = @_;
    my $ret = undef;

    LOG_ENTER_SUB;

    defined $field || LOG_FATAL;

    if ( defined $self->{$_EA_FIELDS}->{$field} ) {
        $ret = $self->{$_EA_FIELDS}->{$field};
    }

    LOG_EXIT_SUB;
    $ret;
}

# ---------------------------
#
# ---------------------------
sub add_field {
    my ( $self, $field, $value ) = @_;
    LOG_ENTER_SUB;
    defined $field || LOG_FATAL;

    $self->{$_EA_FIELDS}->{$field} = $value;

    LOG_EXIT_SUB;
}

1;
