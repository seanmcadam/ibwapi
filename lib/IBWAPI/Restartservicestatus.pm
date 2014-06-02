#!/usr/bin/perl

package IBWAPI::Restartservicestatus;
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
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DHCP_STATUS      => 1,
    $FIELD_DNS_STATUS       => 1,
    $FIELD_MEMBER           => 1,
    $FIELD_REPORTING_STATUS => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_MEMBER => {
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
