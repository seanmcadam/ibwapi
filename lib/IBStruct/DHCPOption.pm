#!/usr/bin/perl

package IBStruct::DHCPOption;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

our @ISA = qw(IBStruct);

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly our $DHCPOPTIONS_NUM          => 'DHCPOPTIONS_NUM';
Readonly our $DHCPOPTIONS_VALUE        => 'DHCPOPTIONS_VALUE';
Readonly our $DHCPOPTIONS_USE_OPTION   => 'DHCPOPTIONS_USE_OPTION';
Readonly our $DHCPOPTIONS_NAME         => 'DHCPOPTIONS_NAME';
Readonly our $DHCPOPTIONS_VENDOR_CLASS => 'DHCPOPTIONS_VENDOR_CLASS';

Readonly our %_FIELDS => (
    $DHCPOPTIONS_NUM          => 1,
    $DHCPOPTIONS_VALUE        => 1,
    $DHCPOPTIONS_USE_OPTION   => 1,
    $DHCPOPTIONS_NAME         => 1,
    $DHCPOPTIONS_VENDOR_CLASS => 1,
);
Readonly our %_FIELD_TYPES => (
    $DHCPOPTIONS_NUM          => $TYPE_UINT,
    $DHCPOPTIONS_VALUE        => $TYPE_STRING,
    $DHCPOPTIONS_USE_OPTION   => $TYPE_BOOL,
    $DHCPOPTIONS_NAME         => $TYPE_STRING,
    $DHCPOPTIONS_VENDOR_CLASS => $TYPE_STRING,
);

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $DHCPOPTIONS_NUM
  $DHCPOPTIONS_VALUE
  $DHCPOPTIONS_USE_OPTION
  $DHCPOPTIONS_NAME
  $DHCPOPTIONS_VENDOR_CLASS
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my $self;
    LOG_ENTER_SUB;
    defined $parm_ref || LOG_FATAL;
    eval $EVAL_NEW_STRUCT_CODE;
    if ($@) { LOG_FATAL "EVAL:" . $@; }
    LOG_EXIT_SUB;
    $self;

}

1;
