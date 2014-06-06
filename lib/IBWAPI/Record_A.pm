#!/usr/bin/perl

package IBWAPI::Record_A;
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
    $FIELD_COMMENT         => 1,
    $FIELD_DISABLE         => 1,
    $FIELD_DISCOVERED_DATA => 1,
    $FIELD_DNS_NAME        => 1,
    $FIELD_EXTATTRS        => 1,
    $FIELD_IPV4ADDR        => 1,
    $FIELD_NAME            => 1,
    $FIELD_TTL             => 1,
    $FIELD_USE_TTL         => 1,
    $FIELD_VIEW            => 1,
    $FIELD_ZONE            => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_IPV4ADDR => 1,
    $FIELD_NAME     => 1,
    $FIELD_VIEW     => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_IPV6ADDR => 1,
    $FIELD_NAME     => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DISCOVERED_DATA => 1,
    $FIELD_DNS_NAME        => 1,
    $FIELD_ZONE        => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_DISCOVERED_DATA => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_IPV4ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
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
