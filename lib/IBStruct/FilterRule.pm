#!/usr/bin/perl

package IBStruct::FilterRule;
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
    my $self;
    if ( !defined $parm_ref ) { LOG_FATAL(PRINT_MYNAMELINE); }
    eval $EVAL_NEW_STRUCT_CODE;
    if ($@) { LOG_FATAL(PRINT_MYNAMELINE); }
    $self;


}

1;
