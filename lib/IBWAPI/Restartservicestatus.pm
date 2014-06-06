#!/usr/bin/perl

package IBWAPI::Restartservicestatus;
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
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_MEMBER => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
