#!/usr/bin/perl

package IBWAPI::Grid;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;
use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly::Hash our %_FIELDS => (
);

Readonly::Hash our %_BASE_FIELDS => (
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);


1;
