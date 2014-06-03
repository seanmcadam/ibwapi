#!/usr/bin/perl

package IBWAPI::Zone_Delegated;
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
    $FIELD_ADDRESS                  => 1,
    $FIELD_COMMENT                  => 1,
    $FIELD_DELEGATE_TO              => 1,
    $FIELD_DELEGATED_TTL            => 1,
    $FIELD_DISABLE                  => 1,
    $FIELD_DISPLAY_DOMAIN           => 1,
    $FIELD_DNS_FQDN                 => 1,
    $FIELD_ENABLE_RFC2317_EXCLUSION => 1,
    $FIELD_EXTATTRS                 => 1,
    $FIELD_FQDN                     => 1,
    $FIELD_LOCKED                   => 1,
    $FIELD_LOCKED_BY                => 1,
    $FIELD_MASK_PREFIX              => 1,
    $FIELD_MS_AD_INTEGRATED         => 1,
    $FIELD_MS_DDNS_MODE             => 1,
    $FIELD_MS_MANAGED               => 1,
    $FIELD_MS_READ_ONLY             => 1,
    $FIELD_MS_SYNC_MASTER_NAME      => 1,
    $FIELD_PARENT                   => 1,
    $FIELD_PREFIX                   => 1,
    $FIELD_USE_DELEGATED_TTL        => 1,
    $FIELD_USING_SRG_ASSOCIATIONS   => 1,
    $FIELD_VIEW                     => 1,
    $FIELD_ZONE_FORMAT              => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_DELEGATE_TO => 1,
    $FIELD_FQDN        => 1,
    $FIELD_VIEW        => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_DELEGATE_TO => 1,
    $FIELD_FQDN        => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_ADDRESS                => 1,
    $FIELD_DISPLAY_DOMAIN         => 1,
    $FIELD_DNS_FQDN               => 1,
    $FIELD_LOCKED_BY              => 1,
    $FIELD_MASK_PREFIX            => 1,
    $FIELD_MS_MANAGED             => 1,
    $FIELD_MS_READ_ONLY           => 1,
    $FIELD_MS_SYNC_MASTER_NAME    => 1,
    $FIELD_PARENT                 => 1,
    $FIELD_USING_SRG_ASSOCIATIONS => 1,
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
