#!/usr/bin/perl

package IBStruct::DiscoveryData;
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

Readonly our $DISCOVERY_DATA_DISCOVERED_NAME                    => 'DISCOVERY_DATA_DISCOVERED_NAME';
Readonly our $DISCOVERY_DATA_DISCOVERER                         => 'DISCOVERY_DATA_DISCOVERER';
Readonly our $DISCOVERY_DATA_DUID                               => 'DISCOVERY_DATA_DUID';
Readonly our $DISCOVERY_DATA_FIRST_DISCOVERED                   => 'DISCOVERY_DATA_FIRST_DISCOVERED';
Readonly our $DISCOVERY_DATA_LAST_DISCOVERED                    => 'DISCOVERY_DATA_LAST_DISCOVERED';
Readonly our $DISCOVERY_DATA_MAC_ADDRESS                        => 'DISCOVERY_DATA_MAC_ADDRESS';
Readonly our $DISCOVERY_DATA_NETBIOS_NAME                       => 'DISCOVERY_DATA_NETBIOS_NAME';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_DESCRIPTION      => 'DISCOVERY_DATA_NETWORK_COMPONENT_DESCRIPTION';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_IP               => 'DISCOVERY_DATA_NETWORK_COMPONENT_IP';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_NAME             => 'DISCOVERY_DATA_NETWORK_COMPONENT_NAME';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_PORT_DESCRIPTION => 'DISCOVERY_DATA_NETWORK_COMPONENT_PORT_DESCRIPTION';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NAME        => 'DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NAME';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NUMBER      => 'DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NUMBER';
Readonly our $DISCOVERY_DATA_NETWORK_COMPONENT_TYPE             => 'DISCOVERY_DATA_NETWORK_COMPONENT_TYPE';
Readonly our $DISCOVERY_DATA_OS                                 => 'DISCOVERY_DATA_OS';
Readonly our $DISCOVERY_DATA_PORT_DUPLEX                        => 'DISCOVERY_DATA_PORT_DUPLEX';
Readonly our $DISCOVERY_DATA_PORT_LINK_STATUS                   => 'DISCOVERY_DATA_PORT_LINK_STATUS';
Readonly our $DISCOVERY_DATA_PORT_SPEED                         => 'DISCOVERY_DATA_PORT_SPEED';
Readonly our $DISCOVERY_DATA_PORT_STATUS                        => 'DISCOVERY_DATA_PORT_STATUS';
Readonly our $DISCOVERY_DATA_PORT_VLAN_DESCRIPTION              => 'DISCOVERY_DATA_PORT_VLAN_DESCRIPTION';
Readonly our $DISCOVERY_DATA_PORT_VLAN_NAME                     => 'DISCOVERY_DATA_PORT_VLAN_NAME';
Readonly our $DISCOVERY_DATA_PORT_VLAN_NUMBER                   => 'DISCOVERY_DATA_PORT_VLAN_NUMBER';
Readonly our $DISCOVERY_DATA_V_ADAPTER                          => 'DISCOVERY_DATA_V_ADAPTER';
Readonly our $DISCOVERY_DATA_V_CLUSTER                          => 'DISCOVERY_DATA_V_CLUSTER';
Readonly our $DISCOVERY_DATA_V_DATACENTER                       => 'DISCOVERY_DATA_V_DATACENTER';
Readonly our $DISCOVERY_DATA_V_ENTITY_NAME                      => 'DISCOVERY_DATA_V_ENTITY_NAME';
Readonly our $DISCOVERY_DATA_V_ENTITY_TYPE                      => 'DISCOVERY_DATA_V_ENTITY_TYPE';
Readonly our $DISCOVERY_DATA_V_HOST                             => 'DISCOVERY_DATA_V_HOST';
Readonly our $DISCOVERY_DATA_V_SWITCH                           => 'DISCOVERY_DATA_V_SWITCH';

Readonly our %_FIELDS => (
    Readonly our DISCOVERY_DATA_DISCOVERED_NAME                    => 1,
    Readonly our DISCOVERY_DATA_DISCOVERER                         => 1,
    Readonly our DISCOVERY_DATA_DUID                               => 1,
    Readonly our DISCOVERY_DATA_FIRST_DISCOVERED                   => 1,
    Readonly our DISCOVERY_DATA_LAST_DISCOVERED                    => 1,
    Readonly our DISCOVERY_DATA_MAC_ADDRESS                        => 1,
    Readonly our DISCOVERY_DATA_NETBIOS_NAME                       => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_DESCRIPTION      => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_IP               => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_NAME             => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_DESCRIPTION => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NAME        => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NUMBER      => 1,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_TYPE             => 1,
    Readonly our DISCOVERY_DATA_OS                                 => 1,
    Readonly our DISCOVERY_DATA_PORT_DUPLEX                        => 1,
    Readonly our DISCOVERY_DATA_PORT_LINK_STATUS                   => 1,
    Readonly our DISCOVERY_DATA_PORT_SPEED                         => 1,
    Readonly our DISCOVERY_DATA_PORT_STATUS                        => 1,
    Readonly our DISCOVERY_DATA_PORT_VLAN_DESCRIPTION              => 1,
    Readonly our DISCOVERY_DATA_PORT_VLAN_NAME                     => 1,
    Readonly our DISCOVERY_DATA_PORT_VLAN_NUMBER                   => 1,
    Readonly our DISCOVERY_DATA_V_ADAPTER                          => 1,
    Readonly our DISCOVERY_DATA_V_CLUSTER                          => 1,
    Readonly our DISCOVERY_DATA_V_DATACENTER                       => 1,
    Readonly our DISCOVERY_DATA_V_ENTITY_NAME                      => 1,
    Readonly our DISCOVERY_DATA_V_ENTITY_TYPE                      => 1,
    Readonly our DISCOVERY_DATA_V_HOST                             => 1,
    Readonly our DISCOVERY_DATA_V_SWITCH                           => 1,
);
Readonly our %_FIELD_TYPES => (
    Readonly our DISCOVERY_DATA_DISCOVERED_NAME                    => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_DISCOVERER                         => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_DUID                               => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_FIRST_DISCOVERED                   => $TYPE_TIMESTAMP,
    Readonly our DISCOVERY_DATA_LAST_DISCOVERED                    => $TYPE_TIMESTAMP,
    Readonly our DISCOVERY_DATA_MAC_ADDRESS                        => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETBIOS_NAME                       => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_DESCRIPTION      => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_IP               => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_NAME             => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_DESCRIPTION => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NAME        => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NUMBER      => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_NETWORK_COMPONENT_TYPE             => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_OS                                 => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_DUPLEX                        => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_LINK_STATUS                   => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_SPEED                         => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_STATUS                        => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_VLAN_DESCRIPTION              => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_VLAN_NAME                     => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_PORT_VLAN_NUMBER                   => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_ADAPTER                          => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_CLUSTER                          => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_DATACENTER                       => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_ENTITY_NAME                      => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_ENTITY_TYPE                      => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_HOST                             => $TYPE_STRING,
    Readonly our DISCOVERY_DATA_V_SWITCH                           => $TYPE_STRING,
);

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  DISCOVERY_DATA_DISCOVERED_NAME
  DISCOVERY_DATA_DISCOVERER
  DISCOVERY_DATA_DUID
  DISCOVERY_DATA_FIRST_DISCOVERED
  DISCOVERY_DATA_LAST_DISCOVERED
  DISCOVERY_DATA_MAC_ADDRESS
  DISCOVERY_DATA_NETBIOS_NAME
  DISCOVERY_DATA_NETWORK_COMPONENT_DESCRIPTION
  DISCOVERY_DATA_NETWORK_COMPONENT_IP
  DISCOVERY_DATA_NETWORK_COMPONENT_NAME
  DISCOVERY_DATA_NETWORK_COMPONENT_PORT_DESCRIPTION
  DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NAME
  DISCOVERY_DATA_NETWORK_COMPONENT_PORT_NUMBER
  DISCOVERY_DATA_NETWORK_COMPONENT_TYPE
  DISCOVERY_DATA_OS
  DISCOVERY_DATA_PORT_DUPLEX
  DISCOVERY_DATA_PORT_LINK_STATUS
  DISCOVERY_DATA_PORT_SPEED
  DISCOVERY_DATA_PORT_STATUS
  DISCOVERY_DATA_PORT_VLAN_DESCRIPTION
  DISCOVERY_DATA_PORT_VLAN_NAME
  DISCOVERY_DATA_PORT_VLAN_NUMBER
  DISCOVERY_DATA_V_ADAPTER
  DISCOVERY_DATA_V_CLUSTER
  DISCOVERY_DATA_V_DATACENTER
  DISCOVERY_DATA_V_ENTITY_NAME
  DISCOVERY_DATA_V_ENTITY_TYPE
  DISCOVERY_DATA_V_HOST
  DISCOVERY_DATA_V_SWITCH
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my $self;
    LOG_ENTER_SUB;
    defined $parm_ref || LOG_FATAL;
    eval $EVAL_NEW_OBJECT_CODE;
    if ($@) { LOG_FATAL "EVAL:" . $@; }
    LOG_EXIT_SUB;
    $self;
}

1;