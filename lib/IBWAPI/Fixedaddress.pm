#!/usr/bin/perl

package IBWAPI::Fixedaddress;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;
use IBWAPI;
use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

our @ISA = qw(IBWAPI);

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_OBJECT_NAME => ( split( '::', __PACKAGE__ ) )[-1];

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

Readonly::Hash our %_FIELDS => (
    $FIELD_AGENT_CIRCUIT_ID                    => 1,
    $FIELD_AGENT_REMOTE_ID                     => 1,
    $FIELD_ALWAYS_UPDATE_DNS                   => 1,
    $FIELD_BOOTFILE                            => 1,
    $FIELD_BOOTSERVER                          => 1,
    $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO      => 1,
    $FIELD_COMMENT                             => 1,
    $FIELD_DDNS_DOMAINNAME                     => 1,
    $FIELD_DDNS_HOSTNAME                       => 1,
    $FIELD_DENY_BOOTP                          => 1,
    $FIELD_DHCP_CLIENT_IDENTIFIER              => 1,
    $FIELD_DISABLE                             => 1,
    $FIELD_DISCOVERED_DATA                     => 1,
    $FIELD_ENABLE_DDNS                         => 1,
    $FIELD_EXTATTRS                            => 1,
    $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST     => 1,
    $FIELD_IPV4ADDR                            => 1,
    $FIELD_MAC                                 => 1,
    $FIELD_MATCH_CLIENT                        => 1,
    $FIELD_MS_OPTIONS                          => 1,
    $FIELD_MS_SERVER                           => 1,
    $FIELD_NAME                                => 1,
    $FIELD_NETWORK                             => 1,
    $FIELD_NETWORK_VIEW                        => 1,
    $FIELD_NEXTSERVER                          => 1,
    $FIELD_OPTIONS                             => 1,
    $FIELD_PXE_LEASE_TIME                      => 1,
    $FIELD_TEMPLATE                            => 1,
    $FIELD_USE_BOOTFILE                        => 1,
    $FIELD_USE_BOOTSERVER                      => 1,
    $FIELD_USE_DDNS_DOMAINNAME                 => 1,
    $FIELD_USE_DENY_BOOTP                      => 1,
    $FIELD_USE_ENABLE_DDNS                     => 1,
    $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST => 1,
    $FIELD_USE_NEXTSERVER                      => 1,
    $FIELD_USE_OPTIONS                         => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_DHCP_CLIENT_IDENTIFIER => 1,
    $FIELD_IPV4ADDR               => 1,
    $FIELD_MAC                    => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_IPV4ADDR     => 1,
    $FIELD_NETWORK_VIEW => 1,
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
    $FIELD_MAC => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_MATCH_CLIENT => {
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
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);

# ---------------------------------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my $self;
    LOG_ENTER_SUB;
    defined $parm_ref || LOG_FATAL;
    eval $EVAL_NEW_OBJECT_CODE;
    if ($@) { LOG_FATAL $@; }
    LOG_EXIT_SUB;
    $self;
}

1;
