#!/usr/bin/perl

package IBWAPI::Search;
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

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
