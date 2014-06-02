#!/usr/bin/perl

package IBWAPI::Record_Host_IPv6Addr;
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
    $FIELD_ADDRESS_TYPE                    => 1,
    $FIELD_CONFIGURE_FOR_DHCP              => 1,
    $FIELD_DISCOVERED_DATA                 => 1,
    $FIELD_DOMAIN_NAME                     => 1,
    $FIELD_DOMAIN_NAME_SERVERS             => 1,
    $FIELD_DUID                            => 1,
    $FIELD_HOST                            => 1,
    $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS => 1,
    $FIELD_IPV6ADDR                        => 1,
    $FIELD_IPV6PREFIX                      => 1,
    $FIELD_IPV6PREFIX_BITS                 => 1,
    $FIELD_MATCH_CLIENT                    => 1,
    $FIELD_OPTIONS                         => 1,
    $FIELD_PREFERRED_LIFETIME              => 1,
    $FIELD_USE_DOMAIN_NAME                 => 1,
    $FIELD_USE_DOMAIN_NAME_SERVERS         => 1,
    $FIELD_USE_FOR_EA_INHERITANCE          => 1,
    $FIELD_USE_OPTIONS                     => 1,
    $FIELD_USE_PREFERRED_LIFETIME          => 1,
    $FIELD_USE_VALID_LIFETIME              => 1,
    $FIELD_VALID_LIFETIME                  => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_CONFIGURE_FOR_DHCP => 1,
    $FIELD_DUID               => 1,
    $FIELD_HOST               => 1,
    $FIELD_IPV6ADDR           => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DISCOVERED_DATA => 1,
    $FIELD_HOST            => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_DISCOVERED_DATA => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_DUID => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_IPV6ADDR => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6PREFIX => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6PREFIX_BITS => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
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