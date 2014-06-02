#!/usr/bin/perl

package IBWAPI::View;
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
    $FIELD_BLACKLIST_ACTION                  => 1,
    $FIELD_BLACKLIST_LOG_QUERY               => 1,
    $FIELD_BLACKLIST_REDIRECT_ADDRESSES      => 1,
    $FIELD_BLACKLIST_REDIRECT_TTL            => 1,
    $FIELD_BLACKLIST_RULESETS                => 1,
    $FIELD_COMMENT                           => 1,
    $FIELD_CUSTOM_ROOT_NAME_SERVERS          => 1,
    $FIELD_DISABLE                           => 1,
    $FIELD_DNS64_ENABLED                     => 1,
    $FIELD_DNS64_GROUPS                      => 1,
    $FIELD_DNSSEC_ENABLED                    => 1,
    $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED => 1,
    $FIELD_DNSSEC_TRUSTED_KEYS               => 1,
    $FIELD_DNSSEC_VALIDATION_ENABLED         => 1,
    $FIELD_ENABLE_BLACKLIST                  => 1,
    $FIELD_EXTATTRS                          => 1,
    $FIELD_FILTER_AAAA                       => 1,
    $FIELD_FILTER_AAAA_LIST                  => 1,
    $FIELD_FORWARD_ONLY                      => 1,
    $FIELD_FORWARDERS                        => 1,
    $FIELD_IS_DEFAULT                        => 1,
    $FIELD_LAME_TTL                          => 1,
    $FIELD_MATCH_CLIENTS                     => 1,
    $FIELD_MATCH_DESTINATIONS                => 1,
    $FIELD_NAME                              => 1,
    $FIELD_NETWORK_VIEW                      => 1,
    $FIELD_NOTIFY_DELAY                      => 1,
    $FIELD_NXDOMAIN_LOG_QUERY                => 1,
    $FIELD_NXDOMAIN_REDIRECT                 => 1,
    $FIELD_NXDOMAIN_REDIRECT_ADDRESSES       => 1,
    $FIELD_NXDOMAIN_REDIRECT_TTL             => 1,
    $FIELD_NXDOMAIN_RULESETS                 => 1,
    $FIELD_RECURSION                         => 1,
    $FIELD_ROOT_NAME_SERVER_TYPE             => 1,
    $FIELD_SORTLIST                          => 1,
    $FIELD_USE_BLACKLIST                     => 1,
    $FIELD_USE_DNS64                         => 1,
    $FIELD_USE_DNSSEC                        => 1,
    $FIELD_USE_FILTER_AAAA                   => 1,
    $FIELD_USE_FORWARDERS                    => 1,
    $FIELD_USE_LAME_TTL                      => 1,
    $FIELD_USE_NXDOMAIN_REDIRECT             => 1,
    $FIELD_USE_RECURSION                     => 1,
    $FIELD_USE_ROOT_NAME_SERVER              => 1,
    $FIELD_USE_SORTLIST                      => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT    => 1,
    $FIELD_IS_DEFAULT => 1,
    $FIELD_NAME       => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_NAME => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_IS_DEFAULT => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_BLACKLIST_ACTION => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_BLACKLIST_LOG_QUERY => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_DNS64_ENABLED => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_DNSSEC_ENABLED => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_DNSSEC_VALIDATION_ENABLED => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_ENABLE_BLACKLIST => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_FILTER_AAAA => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_FORWARD_ONLY => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_IS_DEFAULT => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_NETWORK_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NXDOMAIN_LOG_QUERY => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NXDOMAIN_REDIRECT => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NXDOMAIN_REDIRECT_ADDRESSES => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_RECURSION => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_ROOT_NAME_SERVER_TYPE => {
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
