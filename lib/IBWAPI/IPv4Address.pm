#!/usr/bin/perl

package IBWAPI::IPv4Address;
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
    $FIELD_DHCP_CLIENT_IDENTIFIER => 1,
    $FIELD_EXTATTRS               => 1,
    $FIELD_FINGERPRINT            => 1,
    $FIELD_IP_ADDRESS             => 1,
    $FIELD_IS_CONFLICT            => 1,
    $FIELD_LEASE_STATE            => 1,
    $FIELD_MAC_ADDRESS            => 1,
    $FIELD_NAMES                  => 1,
    $FIELD_NETWORK                => 1,
    $FIELD_NETWORK_VIEW           => 1,
    $FIELD_OBJECTS                => 1,
    $FIELD_STATUS                 => 1,
    $FIELD_TYPES                  => 1,
    $FIELD_USAGE                  => 1,
    $FIELD_USERNAME               => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_DHCP_CLIENT_IDENTIFIER => 1,
    $FIELD_IP_ADDRESS             => 1,
    $FIELD_IS_CONFLICT            => 1,
    $FIELD_LEASE_STATE            => 1,
    $FIELD_MAC_ADDRESS            => 1,
    $FIELD_NAMES                  => 1,
    $FIELD_NETWORK                => 1,
    $FIELD_NETWORK_VIEW           => 1,
    $FIELD_OBJECTS                => 1,
    $FIELD_STATUS                 => 1,
    $FIELD_TYPES                  => 1,
    $FIELD_USAGE                  => 1,
    $FIELD_USERNAME               => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_DHCP_CLIENT_IDENTIFIER => 1,
    $FIELD_FINGERPRINT            => 1,
    $FIELD_IP_ADDRESS             => 1,
    $FIELD_IS_CONFLICT            => 1,
    $FIELD_LEASE_STATE            => 1,
    $FIELD_MAC_ADDRESS            => 1,
    $FIELD_NAMES                  => 1,
    $FIELD_NETWORK                => 1,
    $FIELD_NETWORK_VIEW           => 1,
    $FIELD_OBJECTS                => 1,
    $FIELD_STATUS                 => 1,
    $FIELD_TYPES                  => 1,
    $FIELD_USAGE                  => 1,
    $FIELD_USERNAME               => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_DHCP_CLIENT_IDENTIFIER => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
      },
    $FIELD_EXTATTRS => {},
    $FIELD_FINGERPRINT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
      },
    $FIELD_IP_ADDRESS => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
      },
    $FIELD_IS_CONFLICT => {
        $SEARCH_PARM_EQUAL => 1,
      },
    $FIELD_LEASE_STATE => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
      },
    $FIELD_MAC_ADDRESS => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
      },
    $FIELD_NAMES => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
      },
    $FIELD_NETWORK => {
        $SEARCH_PARM_EQUAL => 1,
      },
    $FIELD_NETWORK_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
      },
    $FIELD_STATUS => {
        $SEARCH_PARM_EQUAL => 1,
      },
    $FIELD_TYPES => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
      },
    $FIELD_USAGE => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
      },
    $FIELD_USERNAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
      },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

1;
