#!/usr/bin/perl

package IBWAPI::Network;
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
    $FIELD_AUTHORITY                           => 1,
    $FIELD_AUTO_CREATE_REVERSEZONE             => 1,
    $FIELD_BOOTFILE                            => 1,
    $FIELD_BOOTSERVER                          => 1,
    $FIELD_COMMENT                             => 1,
    $FIELD_DDNS_DOMAINNAME                     => 1,
    $FIELD_DDNS_GENERATE_HOSTNAME              => 1,
    $FIELD_DDNS_HOSTNAME                       => 1,
    $FIELD_DDNS_SERVER_ALWAYS_UPDATES          => 1,
    $FIELD_DDNS_TTL                            => 1,
    $FIELD_DDNS_UPDATE_FIXED_ADDRESSES         => 1,
    $FIELD_DDNS_USER_OPTION81                  => 1,
    $FIELD_DENY_BOOTP                          => 1,
    $FIELD_DISABLE                             => 1,
    $FIELD_EMAIL_LIST                          => 1,
    $FIELD_ENABLE_DDNS                         => 1,
    $FIELD_ENABLE_DHCP_THRESHOLDS              => 1,
    $FIELD_ENABLE_EMAIL_WARNINGS               => 1,
    $FIELD_ENABLE_IFMAP_PUBLISHING             => 1,
    $FIELD_ENABLE_SNMP_WARNINGS                => 1,
    $FIELD_EXTATTRS                            => 1,
    $FIELD_HIGH_WATER_MARK                     => 1,
    $FIELD_HIGH_WATER_MARK_RESET               => 1,
    $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST     => 1,
    $FIELD_IPV4ADDR                            => 1,
    $FIELD_LEASE_SCAVENGE_TIME                 => 1,
    $FIELD_LOW_WATER_MARK                      => 1,
    $FIELD_LOW_WATER_MARK_RESET                => 1,
    $FIELD_MEMBERS                             => 1,
    $FIELD_NETMASK                             => 1,
    $FIELD_NETWORK                             => 1,
    $FIELD_NETWORK_CONTAINER                   => 1,
    $FIELD_NETWORK_VIEW                        => 1,
    $FIELD_NEXTSERVER                          => 1,
    $FIELD_OPTIONS                             => 1,
    $FIELD_PXE_LEASE_TIME                      => 1,
    $FIELD_RECYCLE_LEASES                      => 1,
    $FIELD_TEMPLATE                            => 1,
    $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL         => 1,
    $FIELD_USE_AUTHORITY                       => 1,
    $FIELD_USE_BOOTFILE                        => 1,
    $FIELD_USE_BOOTSERVER                      => 1,
    $FIELD_USE_DDNS_DOMAINNAME                 => 1,
    $FIELD_USE_DDNS_GENERATE_HOSTNAME          => 1,
    $FIELD_USE_DDNS_TTL                        => 1,
    $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES     => 1,
    $FIELD_USE_DDNS_USE_OPTION81               => 1,
    $FIELD_USE_DENY_BOOTP                      => 1,
    $FIELD_USE_EMAIL_LIST                      => 1,
    $FIELD_USE_ENABLE_DDNS                     => 1,
    $FIELD_USE_ENABLE_DHCP_THRESHOLDS          => 1,
    $FIELD_USE_ENABLE_IFMAP_PUBLISHING         => 1,
    $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST => 1,
    $FIELD_USE_LEASE_SCAVENGE_TIME             => 1,
    $FIELD_USE_NEXTSERVER                      => 1,
    $FIELD_USE_OPTIONS                         => 1,
    $FIELD_USE_RECYCLE_LEASES                  => 1,
    $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL     => 1,
    $FIELD_USE_ZONE_ASSOCIATIONS               => 1,
    $FIELD_ZONE_ASSOCIATIONS                   => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT      => 1,
    $FIELD_NETWORK      => 1,
    $FIELD_NETWORK_VIEW => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_NETWORK => 1,
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
    $FIELD_CONTAINS_ADDRESS => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_IPV4ADDR => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
    },
    $FIELD_NETWORK => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
    },
    $FIELD_NETWORK_CONTAINER => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NETWORK_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_MEMBER => {
        $SEARCH_PARM_EQUAL => 1,
    },

);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
    $FIELD_CONTAINS_ADDRESS => 1,
    $FIELD_MEMBER           => 1,
);

1;
