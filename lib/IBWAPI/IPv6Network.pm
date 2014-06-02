#!/usr/bin/perl

package IBWAPI::IPv6Network;
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
    $FIELD_AUTO_CREATE_REVERSEZONE         => 1,
    $FIELD_COMMENT                         => 1,
    $FIELD_DDNS_DOMAINNAME                 => 1,
    $FIELD_DDNS_ENABLE_OPTION_FQDN         => 1,
    $FIELD_DDNS_GENERATE_HOSTNAME          => 1,
    $FIELD_DDNS_SERVER_ALWAYS_UPDATES      => 1,
    $FIELD_DDNS_TTL                        => 1,
    $FIELD_DISABLE                         => 1,
    $FIELD_DOMAIN_NAME                     => 1,
    $FIELD_DOMAIN_NAME_SERVERS             => 1,
    $FIELD_ENABLE_DDNS                     => 1,
    $FIELD_ENABLE_IFMAP_PUBLISHING         => 1,
    $FIELD_EXTATTRS                        => 1,
    $FIELD_MEMBERS                         => 1,
    $FIELD_NETWORK                         => 1,
    $FIELD_NETWORK_CONTAINER               => 1,
    $FIELD_NETWORK_VIEW                    => 1,
    $FIELD_OPTIONS                         => 1,
    $FIELD_PREFERRED_LIFETIME              => 1,
    $FIELD_RECYCLE_LEASES                  => 1,
    $FIELD_TEMPLATE                        => 1,
    $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL     => 1,
    $FIELD_USE_DDNS_DOMAINNAME             => 1,
    $FIELD_USE_DDNS_ENABLE_OPTION_FQDN     => 1,
    $FIELD_USE_DDNS_GENERATE_HOSTNAME      => 1,
    $FIELD_USE_DDNS_TTL                    => 1,
    $FIELD_USE_DOMAIN_NAME                 => 1,
    $FIELD_USE_DOMAIN_NAME_SERVERS         => 1,
    $FIELD_USE_ENABLE_DDNS                 => 1,
    $FIELD_USE_ENABLE_IFMAP_PUBLISHING     => 1,
    $FIELD_USE_OPTIONS                     => 1,
    $FIELD_USE_PREFERRED_LIFETIME          => 1,
    $FIELD_USE_RECYCLE_LEASES              => 1,
    $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL => 1,
    $FIELD_USE_VALID_LIFETIME              => 1,
    $FIELD_USE_ZONE_ASSOCIATIONS           => 1,
    $FIELD_VALID_LIFETIME                  => 1,
    $FIELD_ZONE_ASSOCIATIONS               => 1,
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

);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
    $FIELD_SHARED_NETWORK_NAME => 1,
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
