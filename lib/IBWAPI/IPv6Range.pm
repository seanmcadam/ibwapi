#!/usr/bin/perl

package IBWAPI::IPv6Range;
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
    $FIELD_ADDRESS_TYPE            => 1,
    $FIELD_COMMENT                 => 1,
    $FIELD_DISABLE                 => 1,
    $FIELD_END_ADDR                => 1,
    $FIELD_EXCLUDE                 => 1,
    $FIELD_EXTATTRS                => 1,
    $FIELD_IPV6_END_PREFIX         => 1,
    $FIELD_IPV6_PREFIX_BITS        => 1,
    $FIELD_IPV6_START_PREFIX       => 1,
    $FIELD_MEMBER                  => 1,
    $FIELD_NAME                    => 1,
    $FIELD_NETWORK                 => 1,
    $FIELD_NETWORK_VIEW            => 1,
    $FIELD_RECYCLE_LEASES          => 1,
    $FIELD_SERVER_ASSOCIATION_TYPE => 1,
    $FIELD_START_ADDR              => 1,
    $FIELD_TEMPLATE                => 1,
    $FIELD_USE_RECYCLE_LEASES      => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_COMMENT      => 1,
    $FIELD_END_ADDR     => 1,
    $FIELD_NETWORK      => 1,
    $FIELD_NETWORK_VIEW => 1,
    $FIELD_START_ADDR   => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_NETWORK => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_ADDRESS_TYPE => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_END_ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6_END_PREFIX => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6_PREFIX_BITS => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_IPV6_START_PREFIX => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_MEMBER => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NAME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
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
    },
    $FIELD_START_ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
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
