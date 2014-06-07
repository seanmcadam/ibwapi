#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 36;
use IBWAPI;

new_ok('IBWAPI');

my @functions = qw(
  GET
  POST
  PUT
  DELETE
  FIXEDADDRESS
  GRID
  IPV4ADDRESS
  IPV6ADDRESS
  IPV6FIXEDADDRESS
  IPV6NETWORK
  IPV6NETWORKCONTAINER
  IPV6RANGE
  LEASE
  MACFILTERADDRESS
  MEMBER
  NAMEDACL
  NETWORK
  NETWORKCONTAINER
  NETWORKVIEW
  RANGE
  RECORD_A
  RECORD_AAAA
  RECORD_CNAME
  RECORD_HOST
  RECORD_HOST_IPV4ADDR
  RECORD_HOST_IPV6ADDR
  RECORD_MX
  RECORD_PTR
  RECORD_SRV
  RECORD_TXT
  RESTARTSERVICESSTATUS
  SCHEDULEDTASK
  SEARCH
  VIEW
  ZONE_AUTH
  ZONE_DELEGATED
  ZONE_FORWARD
  ZONE_STUB
);

can_ok( 'IBWAPI', @functions );

my $ibwapi = IBWAPI->new();

cmp_ok( ref( $ibwapi->FIXEDADDRESS ),          'eq', 'IBWAPI', 'FIXEDADDRESS' );
cmp_ok( ref( $ibwapi->GRID ),                  'eq', 'IBWAPI', 'GRID' );
cmp_ok( ref( $ibwapi->IPV4ADDRESS ),           'eq', 'IBWAPI', 'IPV4ADDRESS' );
cmp_ok( ref( $ibwapi->IPV6ADDRESS ),           'eq', 'IBWAPI', 'IPV6ADDRESS' );
cmp_ok( ref( $ibwapi->IPV6FIXEDADDRESS ),      'eq', 'IBWAPI', 'IPV6FIXEDADDRESS' );
cmp_ok( ref( $ibwapi->IPV6NETWORK ),           'eq', 'IBWAPI', 'IPV6NETWORK' );
cmp_ok( ref( $ibwapi->IPV6NETWORKCONTAINER ),  'eq', 'IBWAPI', 'IPV6NETWORKCONTAINER' );
cmp_ok( ref( $ibwapi->IPV6RANGE ),             'eq', 'IBWAPI', 'IPV6RANGE' );
cmp_ok( ref( $ibwapi->LEASE ),                 'eq', 'IBWAPI', 'LEASE' );
cmp_ok( ref( $ibwapi->MACFILTERADDRESS ),      'eq', 'IBWAPI', 'MACFILTERADDRESS' );
cmp_ok( ref( $ibwapi->MEMBER ),                'eq', 'IBWAPI', 'MEMBER' );
cmp_ok( ref( $ibwapi->NAMEDACL ),              'eq', 'IBWAPI', 'NAMEDACL' );
cmp_ok( ref( $ibwapi->NETWORK ),               'eq', 'IBWAPI', 'NETWORK' );
cmp_ok( ref( $ibwapi->NETWORKCONTAINER ),      'eq', 'IBWAPI', 'NETWORKCONTAINER' );
cmp_ok( ref( $ibwapi->NETWORKVIEW ),           'eq', 'IBWAPI', 'NETWORKVIEW' );
cmp_ok( ref( $ibwapi->RANGE ),                 'eq', 'IBWAPI', 'RANGE' );
cmp_ok( ref( $ibwapi->RECORD_A ),              'eq', 'IBWAPI', 'RECORD_A' );
cmp_ok( ref( $ibwapi->RECORD_AAAA ),           'eq', 'IBWAPI', 'RECORD_AAAA' );
cmp_ok( ref( $ibwapi->RECORD_CNAME ),          'eq', 'IBWAPI', 'RECORD_CNAME' );
cmp_ok( ref( $ibwapi->RECORD_HOST ),           'eq', 'IBWAPI', 'RECORD_HOST' );
cmp_ok( ref( $ibwapi->RECORD_HOST_IPV4ADDR ),  'eq', 'IBWAPI', 'RECORD_HOST_IPV4ADDR' );
cmp_ok( ref( $ibwapi->RECORD_HOST_IPV6ADDR ),  'eq', 'IBWAPI', 'RECORD_HOST_IPV6ADDR' );
cmp_ok( ref( $ibwapi->RECORD_MX ),             'eq', 'IBWAPI', 'RECORD_MX' );
cmp_ok( ref( $ibwapi->RECORD_PTR ),            'eq', 'IBWAPI', 'RECORD_PTR' );
cmp_ok( ref( $ibwapi->RECORD_SRV ),            'eq', 'IBWAPI', 'RECORD_SRV' );
cmp_ok( ref( $ibwapi->RECORD_TXT ),            'eq', 'IBWAPI', 'RECORD_TXT' );
cmp_ok( ref( $ibwapi->RESTARTSERVICESSTATUS ), 'eq', 'IBWAPI', 'RESTARTSERVICESSTATUS' );
cmp_ok( ref( $ibwapi->SCHEDULEDTASK ),         'eq', 'IBWAPI', 'SCHEDULEDTASK' );
cmp_ok( ref( $ibwapi->SEARCH ),                'eq', 'IBWAPI', 'SEARCH' );
cmp_ok( ref( $ibwapi->VIEW ),                  'eq', 'IBWAPI', 'VIEW' );
cmp_ok( ref( $ibwapi->ZONE_AUTH ),             'eq', 'IBWAPI', 'ZONE_AUTH' );
cmp_ok( ref( $ibwapi->ZONE_DELEGATED ),        'eq', 'IBWAPI', 'ZONE_DELEGATED' );
cmp_ok( ref( $ibwapi->ZONE_FORWARD ),          'eq', 'IBWAPI', 'ZONE_FORWARD' );
cmp_ok( ref( $ibwapi->ZONE_STUB ),             'eq', 'IBWAPI', 'ZONE_STUB' );

