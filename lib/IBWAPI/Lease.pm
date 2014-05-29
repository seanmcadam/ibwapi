#!/usr/bin/perl

package IBWAPI::Lease;
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
    $FIELD_ADDRESS                 => 1,
    $FIELD_BILLING_CLASS           => 1,
    $FIELD_BINDING_STATE           => 1,
    $FIELD_CLIENT_HOSTNAME         => 1,
    $FIELD_CLTT                    => 1,
    $FIELD_DISCOVERED_DATA         => 1,
    $FIELD_ENDS                    => 1,
    $FIELD_HARDWARE                => 1,
    $FIELD_IPV6_DUID               => 1,
    $FIELD_IPV6_IAID               => 1,
    $FIELD_IPV6_PREFERRED_LIFETIME => 1,
    $FIELD_IPV6_PREFIX_BITS        => 1,
    $FIELD_NETWORK                 => 1,
    $FIELD_NETWORK_VIEW            => 1,
    $FIELD_NEVER_ENDS              => 1,
    $FIELD_NEVER_STARTS            => 1,
    $FIELD_NEXT_BINDING_STATE      => 1,
    $FIELD_ON_COMMIT               => 1,
    $FIELD_ON_EXPIRY               => 1,
    $FIELD_ON_RELEASE              => 1,
    $FIELD_OPTION                  => 1,
    $FIELD_PROTOCOL                => 1,
    $FIELD_SERVED_BY               => 1,
    $FIELD_SERVER_HOST_NAME        => 1,
    $FIELD_STARTS                  => 1,
    $FIELD_TSTP                    => 1,
    $FIELD_UID                     => 1,
    $FIELD_USERNAME                => 1,
    $FIELD_VARIABLE                => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_ADDRESS      => 1,
    $FIELD_NETWORK_VIEW => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_ADDRESS                 => 1,
    $FIELD_BILLING_CLASS           => 1,
    $FIELD_BINDING_STATE           => 1,
    $FIELD_CLIENT_HOSTNAME         => 1,
    $FIELD_CLTT                    => 1,
    $FIELD_DISCOVERED_DATA         => 1,
    $FIELD_ENDS                    => 1,
    $FIELD_HARDWARE                => 1,
    $FIELD_IPV6_DUID               => 1,
    $FIELD_IPV6_IAID               => 1,
    $FIELD_IPV6_PREFERRED_LIFETIME => 1,
    $FIELD_IPV6_PREFIX_BITS        => 1,
    $FIELD_NETWORK                 => 1,
    $FIELD_NETWORK_VIEW            => 1,
    $FIELD_NEVER_ENDS              => 1,
    $FIELD_NEVER_STARTS            => 1,
    $FIELD_NEXT_BINDING_STATE      => 1,
    $FIELD_ON_COMMIT               => 1,
    $FIELD_ON_EXPIRY               => 1,
    $FIELD_ON_RELEASE              => 1,
    $FIELD_OPTION                  => 1,
    $FIELD_PROTOCOL                => 1,
    $FIELD_SERVED_BY               => 1,
    $FIELD_SERVER_HOST_NAME        => 1,
    $FIELD_STARTS                  => 1,
    $FIELD_TSTP                    => 1,
    $FIELD_UID                     => 1,
    $FIELD_USERNAME                => 1,
    $FIELD_VARIABLE                => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_ADDRESS => {
        $SEARCH_PARM_NEGATIVE => 1,
        $SEARCH_PARM_GT       => 1,
        $SEARCH_PARM_EQUAL    => 1,
        $SEARCH_PARM_LT       => 1,
        $SEARCH_PARM_REGEX    => 1,
    },
    $FIELD_CLIENT_HOSTNAME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_DISCOVERED_DATA => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_HARDWARE => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6_DUID => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_IPV6_PREFIX_BITS => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_NETWORK_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_PROTOCOL => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_USERNAME => {
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
    if ( !defined $parm_ref ) { LOG_FATAL(PRINT_MYNAMELINE); }
    eval $EVAL_NEW_OBJECT_CODE;
    if ($@) { LOG_FATAL(PRINT_MYNAMELINE); }
    $self;
}

1;
