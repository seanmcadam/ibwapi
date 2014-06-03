#!/usr/bin/perl

package IBWAPI::Zone_Auth;
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
    $FIELD_ADDRESS                              => 1,
    $FIELD_ALLOW_ACTIVE_DIR                     => 1,
    $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE   => 1,
    $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES          => 1,
    $FIELD_ALLOW_QUERY                          => 1,
    $FIELD_ALLOW_TRANSFER                       => 1,
    $FIELD_ALLOW_UPDATE                         => 1,
    $FIELD_ALLOW_UPDATE_FORWARDING              => 1,
    $FIELD_COMMENT                              => 1,
    $FIELD_COPY_XFER_TO_NOTIFY                  => 1,
    $FIELD_CREATE_PTR_FOR_BULK_HOSTS            => 1,
    $FIELD_CREATE_PTR_FOR_HOSTS                 => 1,
    $FIELD_CREATE_UNDERSCORE_ZONES              => 1,
    $FIELD_DISABLE                              => 1,
    $FIELD_DISABLE_FORWARDING                   => 1,
    $FIELD_DISPLAY_DOMAIN                       => 1,
    $FIELD_DNS_FQDN                             => 1,
    $FIELD_DNS_SOA_EMAIL                        => 1,
    $FIELD_DNS_SOA_MNAME                        => 1,
    $FIELD_DNSSEC_KEY_PARAMS                    => 1,
    $FIELD_DO_HOST_ABSTRACTION                  => 1,
    $FIELD_EFFECTIVE_CHECK_NAMES_POLICY         => 1,
    $FIELD_EFFECTIVE_RECORD_NAME_POLICY         => 1,
    $FIELD_EXTATTRS                             => 1,
    $FIELD_EXTERNAL_PRIMARIES                   => 1,
    $FIELD_EXTERNAL_SECONDARIES                 => 1,
    $FIELD_FQDN                                 => 1,
    $FIELD_GRID_PRIMARY                         => 1,
    $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D => 1,
    $FIELD_GRID_SECONDARIES                     => 1,
    $FIELD_IMPORT_FROM                          => 1,
    $FIELD_IS_DNSSEC_ENABLED                    => 1,
    $FIELD_IS_DNSSEC_SIGNED                     => 1,
    $FIELD_LAST_QUERIED                         => 1,
    $FIELD_LOCKED                               => 1,
    $FIELD_LOCKED_BY                            => 1,
    $FIELD_MASK_PREFIX                          => 1,
    $FIELD_MS_AD_INTEGRATED                     => 1,
    $FIELD_MS_ALLOW_TRANSFER                    => 1,
    $FIELD_MS_ALLOW_TRANSFER_MODE               => 1,
    $FIELD_MS_DDNS_MODE                         => 1,
    $FIELD_MS_MANAGED                           => 1,
    $FIELD_MS_PRIMARIES                         => 1,
    $FIELD_MS_READ_ONLY                         => 1,
    $FIELD_MS_SECONDARIES                       => 1,
    $FIELD_MS_SYNC_MASTER_NAME                  => 1,
    $FIELD_NETWORK_ASSOCIATIONS                 => 1,
    $FIELD_NETWORK_VIEW                         => 1,
    $FIELD_NOTIFY_DELAY                         => 1,
    $FIELD_NS_GROUP                             => 1,
    $FIELD_PARENT                               => 1,
    $FIELD_PREFIX                               => 1,
    $FIELD_PRIMARY_TYPE                         => 1,
    $FIELD_RECORD_NAME_POLICY                   => 1,
    $FIELD_RECORDS_MONITORED                    => 1,
    $FIELD_RR_NOT_QUERIED_ENABLED_TIME          => 1,
    $FIELD_SET_SOA_SERIAL_NUMBER                => 1,
    $FIELD_SOA_DEFAULT_TTL                      => 1,
    $FIELD_SOA_EMAIL                            => 1,
    $FIELD_SOA_EXPIRE                           => 1,
    $FIELD_SOA_MNAME                            => 1,
    $FIELD_SOA_NEGATIVE_TTL                     => 1,
    $FIELD_SOA_REFRESH                          => 1,
    $FIELD_SOA_RETRY                            => 1,
    $FIELD_SOA_SERIAL_NUMBER                    => 1,
    $FIELD_SRGS                                 => 1,
    $FIELD_UPDATE_FORWARDING                    => 1,
    $FIELD_USE_ALLOW_ACTIVE_DIR                 => 1,
    $FIELD_USE_ALLOW_QUERY                      => 1,
    $FIELD_USE_ALLOW_TRANSFER                   => 1,
    $FIELD_USE_ALLOW_UPDATE                     => 1,
    $FIELD_USE_ALLOW_UPDATE_FORWARDING          => 1,
    $FIELD_USE_CHECK_NAMES_POLICY               => 1,
    $FIELD_USE_COPY_XFER_TO_NOTIFY              => 1,
    $FIELD_USE_DNSSEC_KEY_PARAMS                => 1,
    $FIELD_USE_EXTERNAL_PRIMARY                 => 1,
    $FIELD_USE_GRID_ZONE_TIMER                  => 1,
    $FIELD_USE_IMPORT_FROM                      => 1,
    $FIELD_USE_NOTIFY_DELAY                     => 1,
    $FIELD_USE_RECORD_NAME_POLICY               => 1,
    $FIELD_USE_SOA_EMAIL                        => 1,
    $FIELD_USE_SOA_MNAME                        => 1,
    $FIELD_USING_SRG_ASSOCIATIONS               => 1,
    $FIELD_VIEW                                 => 1,
    $FIELD_ZONE_FORMAT                          => 1,
    $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME        => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_FQDN => 1,
    $FIELD_VIEW => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_FQDN => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_ADDRESS                              => 1,
    $FIELD_DISPLAY_DOMAIN                       => 1,
    $FIELD_DNS_FQDN                             => 1,
    $FIELD_DNS_SOA_EMAIL                        => 1,
    $FIELD_DNS_SOA_MNAME                        => 1,
    $FIELD_EFFECTIVE_RECORD_NAME_POLICY         => 1,
    $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D => 1,
    $FIELD_IS_DNSSEC_ENABLED                    => 1,
    $FIELD_IS_DNSSEC_SIGNED                     => 1,
    $FIELD_LAST_QUERIED                         => 1,
    $FIELD_LOCKED_BY                            => 1,
    $FIELD_MASK_PREFIX                          => 1,
    $FIELD_MS_MANAGED                           => 1,
    $FIELD_MS_READ_ONLY                         => 1,
    $FIELD_MS_SYNC_MASTER_NAME                  => 1,
    $FIELD_NETWORK_ASSOCIATIONS                 => 1,
    $FIELD_NETWORK_VIEW                         => 1,
    $FIELD_PARENT                               => 1,
    $FIELD_PRIMARY_TYPE                         => 1,
    $FIELD_RECORD_NAME_POLICY                   => 1,
    $FIELD_RECORDS_MONITORED                    => 1,
    $FIELD_RR_NOT_QUERIED_ENABLED_TIME          => 1,
    $FIELD_USING_SRG_ASSOCIATIONS               => 1,
    $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME        => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_FQDN => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_PARENT => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_VIEW => {
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
