#!/usr/bin/perl

package IBWAPI::Record_Host_IPv4Addr;
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
    $FIELD_BOOTFILE                            => 1,
    $FIELD_BOOTSERVER                          => 1,
    $FIELD_CONFIGURE_FOR_DHCP                  => 1,
    $FIELD_DENY_BOOTP                          => 1,
    $FIELD_DISCOVERED_DATA                     => 1,
    $FIELD_ENABLE_PXE_LEASE_TIME               => 1,
    $FIELD_HOST                                => 1,
    $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS     => 1,
    $FIELD_IPV4ADDR                            => 1,
    $FIELD_LAST_QUERIED                        => 1,
    $FIELD_MAC                                 => 1,
    $FIELD_MATCH_CLIENT                        => 1,
    $FIELD_NETWORK                             => 1,
    $FIELD_NEXTSERVER                          => 1,
    $FIELD_OPTIONS                             => 1,
    $FIELD_PXE_LEASE_TIME                      => 1,
    $FIELD_USE_BOOTFILE                        => 1,
    $FIELD_USE_BOOTSERVER                      => 1,
    $FIELD_USE_DENY_BOOTP                      => 1,
    $FIELD_USE_FOR_EA_INHERITANCE              => 1,
    $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS => 1,
    $FIELD_USE_NEXTSERVER                      => 1,
    $FIELD_USE_OPTIONS                         => 1,
    $FIELD_USE_PXE_LEASE_TIME                  => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_CONFIGURE_FOR_DHCP => 1,
    $FIELD_HOST               => 1,
    $FIELD_IPV4ADDR           => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_IPV4ADDR => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DISCOVERED_DATA => 1,
    $FIELD_HOST            => 1,
    $FIELD_LAST_QUERIED    => 1,
    $FIELD_NETWORK         => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_DISCOVERED_DATA => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_IPV4ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_MAC => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
