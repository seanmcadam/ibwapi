#!/usr/bin/perl

package IBWAPI::Record_CNAME;
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
    $FIELD_CANONICAL         => 1,
    $FIELD_COMMENT         => 1,
    $FIELD_DISABLE         => 1,
    $FIELD_DNS_CANONICAL        => 1,
    $FIELD_DNS_NAME        => 1,
    $FIELD_EXTATTRS        => 1,
    $FIELD_NAME            => 1,
    $FIELD_TTL             => 1,
    $FIELD_USE_TTL         => 1,
    $FIELD_VIEW            => 1,
    $FIELD_ZONE            => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_CANONICAL => 1,
    $FIELD_NAME     => 1,
    $FIELD_VIEW     => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_CANONICAL => 1,
    $FIELD_NAME     => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_CANONICAL => 1,
    $FIELD_DNS_NAME        => 1,
    $FIELD_ZONE        => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_CANONICAL => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_NAME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_ZONE => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
