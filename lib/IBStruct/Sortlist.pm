#!/usr/bin/perl

package IBStruct::SortList;
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
    LOG_ENTER_SUB;
    defined $parm_ref || LOG_FATAL;
    eval $EVAL_NEW_OBJECT_CODE;
    if ($@) { LOG_FATAL "EVAL:" . $@; }
    LOG_EXIT_SUB;

    $self;

}

1;
