#!/usr/bin/perl

package IBWAPI::Member;
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
    $FIELD_HOST_NAME => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_HOST_NAME => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_HOST_NAME => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_HOST_NAME => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
    $FIELD_IPV4_ADDRESS => 1,
    $FIELD_IPV6_ADDRESS => 1,
);


1;
