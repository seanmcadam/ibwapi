#!/usr/bin/perl

package IBStruct::LogicFilterRule;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

our @ISA = qw(IBStruct);

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly our %_FIELDS => (
);
Readonly our %_FIELD_TYPES => (
);

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

    my $self = $class->SUPER::new();

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$IB_STRUCT_FIELD}            = \%_FIELDS;
    $self->{$IB_STRUCT_TYPE}             = \%_FIELD_TYPES;

    if ( !defined $parm_ref ) { confess "parameters are required"; }
    if ( ref($parm_ref) ne 'HASH' ) { confess "bad parameter ref"; }

    bless $self, $class;

    $self;
}


1;
