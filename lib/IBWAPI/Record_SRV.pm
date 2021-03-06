#!/usr/bin/perl

package IBWAPI::Record_SRV;
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
    $FIELD_COMMENT    => 1,
    $FIELD_DISABLE    => 1,
    $FIELD_DNS_NAME   => 1,
    $FIELD_DNS_TARGET => 1,
    $FIELD_EXTATTRS   => 1,
    $FIELD_NAME       => 1,
    $FIELD_PORT       => 1,
    $FIELD_PRIORITY   => 1,
    $FIELD_TARGET     => 1,
    $FIELD_TTL        => 1,
    $FIELD_USE_TTL    => 1,
    $FIELD_VIEW       => 1,
    $FIELD_WEIGHT     => 1,
    $FIELD_ZONE       => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_NAME   => 1,
    $FIELD_PORT   => 1,
    $FIELD_TARGET => 1,
    $FIELD_VIEW   => 1,
    $FIELD_WEIGHT => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_NAME     => 1,
    $FIELD_PORT     => 1,
    $FIELD_PRIORITY => 1,
    $FIELD_TARGET   => 1,
    $FIELD_WEIGHT   => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DNS_NAME   => 1,
    $FIELD_DNS_TARGET => 1,
    $FIELD_ZONE       => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_NAME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_PORT => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_PRIORITY => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
    },
    $FIELD_TARGET => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_WEIGHT => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
    },
    $FIELD_ZONE => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
