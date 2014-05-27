#!/usr/bin/perl

package IBWAPI::ObjectTemplate;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;
use IBWAPI;
use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

our @ISA = qw(IBWAPI);

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_OBJECT_NAME => ( split( '::', __PACKAGE__ ) )[-1];

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

Readonly::Hash our %_FIELDS => (
    $FIELD_COMMENT => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_COMMENT => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_NETWORK_CONTAINER => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
);

# ---------------------------------------------------
sub new {
    my ( $class, $parm_ref ) = @_;

    PRINT_MYNAMELINE if $DEBUG;

    $parm_ref->{$IB_FIELDS}            = \%_FIELDS;
    $parm_ref->{$IB_BASE_FIELDS}       = \%_BASE_FIELDS;
    $parm_ref->{$IB_READONLY_FIELDS}   = \%_READONLY_FIELDS;
    $parm_ref->{$IB_SEARCHABLE_FIELDS} = \%_SEARCHABLE_FIELDS;

    my $self = $class->SUPER::new( $_OBJECT_NAME, $parm_ref );

    bless $self, $class;

    $self->create_lwp($parm_ref);

    $self;
}

1;
