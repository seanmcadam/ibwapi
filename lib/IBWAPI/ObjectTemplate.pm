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
    my $self;
    if ( !defined $parm_ref ) { LOG_FATAL(PRINT_MYNAMELINE); }
    eval $EVAL_NEW_OBJECT_CODE;
    if ($@) { LOG_FATAL(PRINT_MYNAMELINE); }
    $self;
}

1;
