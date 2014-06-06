#!/usr/bin/perl

package IBWAPI::Range;
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
    $FIELD_ALWAYS_UPDATE_DNS                   => 'ALWAYS_UPDATE_DNS',
    $FIELD_AUTHORITY                           => 'AUTHORITY',
    $FIELD_BOOTFILE                            => 'BOOTFILE',
    $FIELD_BOOTSERVER                          => 'BOOTSERVER',
    $FIELD_COMMENT                             => 'COMMENT',
    $FIELD_DDNS_DOMAINNAME                     => 'DDNS_DOMAINNAME',
    $FIELD_DDNS_GENERATE_HOSTNAME              => 'DDNS_GENERATE_HOSTNAME',
    $FIELD_DENY_ALL_CLIENTS                    => 'DENY_ALL_CLIENTS',
    $FIELD_DENY_BOOTP                          => 'DENY_BOOTP',
    $FIELD_DISABLE                             => 'DISABLE',
    $FIELD_EMAIL_LIST                          => 'EMAIL_LIST',
    $FIELD_ENABLE_DDNS                         => 'ENABLE_DDNS',
    $FIELD_ENABLE_DHCP_THRESHOLDS              => 'ENABLE_DHCP_THRESHOLDS',
    $FIELD_ENABLE_EMAIL_WARNINGS               => 'ENABLE_EMAIL_WARNINGS',
    $FIELD_ENABLE_IFMAP_PUBLISHING             => 'ENABLE_IFMAP_PUBLISHING',
    $FIELD_ENABLE_SNMP_WARNINGS                => 'ENABLE_SNMP_WARNINGS',
    $FIELD_END_ADDR                            => 'END_ADDR',
    $FIELD_EXCLUDE                             => 'EXCLUDE',
    $FIELD_EXTATTRS                            => 'EXTATTRS',
    $FIELD_FAILOVER_ASSOCIATION                => 'FAILOVER_ASSOCIATION',
    $FIELD_FINGERPRINT_FILTER_RULES            => 'FINGERPRINT_FILTER_RULES',
    $FIELD_HIGH_WATER_MARK                     => 'HIGH_WATER_MARK',
    $FIELD_HIGH_WATER_MARK_RESET               => 'HIGH_WATER_MARK_RESET',
    $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST     => 'IGNORE_DHCP_OPTION_LIST_REQUEST',
    $FIELD_IS_SPLIT_SCOPE                      => 'IS_SPLIT_SCOPE',
    $FIELD_KNOWN_CLIENTS                       => 'KNOWN_CLIENTS',
    $FIELD_LEASE_SCAVENGE_TIME                 => 'LEASE_SCAVENGE_TIME',
    $FIELD_LOGIC_FILTER_RULES                  => 'LOGIC_FILTER_RULES',
    $FIELD_LOW_WATER_MARK                      => 'LOW_WATER_MARK',
    $FIELD_LOW_WATER_MARK_RESET                => 'LOW_WATER_MARK_RESET',
    $FIELD_MAC_FILTER_RULES                    => 'MAC_FILTER_RULES',
    $FIELD_MEMBER                              => 'MEMBER',
    $FIELD_MS_OPTIONS                          => 'MS_OPTIONS',
    $FIELD_MS_SERVER                           => 'MS_SERVER',
    $FIELD_NAC_FILTER_RULES                    => 'NAC_FILTER_RULES',
    $FIELD_NAME                                => 'NAME',
    $FIELD_NETWORK                             => 'NETWORK',
    $FIELD_NETWORK_VIEW                        => 'NETWORK_VIEW',
    $FIELD_NEXTSERVER                          => 'NEXTSERVER',
    $FIELD_OPTION_FILTER_RULES                 => 'OPTION_FILTER_RULES',
    $FIELD_OPTIONS                             => 'OPTIONS',
    $FIELD_PXE_LEASE_TIME                      => 'PXE_LEASE_TIME',
    $FIELD_RECYCLE_LEASES                      => 'RECYCLE_LEASES',
    $FIELD_RELAY_AGENT_FILTER_RULES            => 'RELAY_AGENT_FILTER_RULES',
    $FIELD_SERVER_ASSOCIATION_TYPE             => 'SERVER_ASSOCIATION_TYPE',
    $FIELD_SPLIT_MEMBER                        => 'SPLIT_MEMBER',
    $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT       => 'SPLIT_SCOPE_EXCLUSION_PERCENT',
    $FIELD_START_ADDR                          => 'START_ADDR',
    $FIELD_TEMPLATE                            => 'TEMPLATE',
    $FIELD_UNKNOWN_CLIENTS                     => 'UNKNOWN_CLIENTS',
    $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL         => 'UPDATE_DNS_ON_LEASE_RENEWAL',
    $FIELD_USE_AUTHORITY                       => 'USE_AUTHORITY',
    $FIELD_USE_BOOTFILE                        => 'USE_BOOTFILE',
    $FIELD_USE_BOOTSERVER                      => 'USE_BOOTSERVER',
    $FIELD_USE_DDNS_DOMAINNAME                 => 'USE_DDNS_DOMAINNAME',
    $FIELD_USE_DDNS_GENERATE_HOSTNAME          => 'USE_DDNS_GENERATE_HOSTNAME',
    $FIELD_USE_DENY_BOOTP                      => 'USE_DENY_BOOTP',
    $FIELD_USE_EMAIL_LIST                      => 'USE_EMAIL_LIST',
    $FIELD_USE_ENABLE_DDNS                     => 'USE_ENABLE_DDNS',
    $FIELD_USE_ENABLE_DHCP_THRESHOLDS          => 'USE_ENABLE_DHCP_THRESHOLDS',
    $FIELD_USE_ENABLE_IFMAP_PUBLISHING         => 'USE_ENABLE_IFMAP_PUBLISHING',
    $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST => 'USE_IGNORE_DHCP_OPTION_LIST_REQUEST',
    $FIELD_USE_KNOWN_CLIENTS                   => 'USE_KNOWN_CLIENTS',
    $FIELD_USE_LEASE_SCAVENGE_TIME             => 'USE_LEASE_SCAVENGE_TIME',
    $FIELD_USE_NEXTSERVER                      => 'USE_NEXTSERVER',
    $FIELD_USE_OPTIONS                         => 'USE_OPTIONS',
    $FIELD_USE_RECYCLE_LEASES                  => 'USE_RECYCLE_LEASES',
    $FIELD_USE_UNKNOWN_CLIENTS                 => 'USE_UNKNOWN_CLIENTS',
    $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL     => 'USE_UPDATE_DNS_ON_LEASE_RENEWAL',
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT      => 1,
    $FIELD_END_ADDR     => 1,
    $FIELD_NETWORK      => 1,
    $FIELD_NETWORK_VIEW => 1,
    $FIELD_START_ADDR   => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_END_ADDR   => 1,
    $FIELD_START_ADDR => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_IS_SPLIT_SCOPE => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_END_ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_FAILOVER_ASSOCIATION => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_MEMBER => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_MS_SERVER => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NETWORK => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_NETWORK_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_SERVER_ASSOCIATION_TYPE => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);


1;
