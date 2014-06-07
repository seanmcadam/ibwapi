#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 59;

require_ok('IBConsts');
require_ok('IBWAPI');
require_ok('IBLWP');
require_ok('IBRecord');
require_ok('IBStruct');

require_ok('IBWAPI::Fixedaddress');
require_ok('IBWAPI::Grid');
require_ok('IBWAPI::IPv4Address');
require_ok('IBWAPI::IPv6Address');
require_ok('IBWAPI::IPv6Fixedaddress');
require_ok('IBWAPI::IPv6Networkcontainer');
require_ok('IBWAPI::IPv6Network');
require_ok('IBWAPI::IPv6Range');
require_ok('IBWAPI::Lease');
require_ok('IBWAPI::Macfilteraddress');
require_ok('IBWAPI::Member');
require_ok('IBWAPI::Namedacl');
require_ok('IBWAPI::Networkcontainer');
require_ok('IBWAPI::Network');
require_ok('IBWAPI::Networkview');
require_ok('IBWAPI::Range');
require_ok('IBWAPI::Record_AAAA');
require_ok('IBWAPI::Record_A');
require_ok('IBWAPI::Record_CNAME');
require_ok('IBWAPI::Record_Host_IPv4Addr');
require_ok('IBWAPI::Record_Host_IPv6Addr');
require_ok('IBWAPI::Record_Host');
require_ok('IBWAPI::Record_MX');
require_ok('IBWAPI::Record_PTR');
require_ok('IBWAPI::Record_SRV');
require_ok('IBWAPI::Record_TXT');
require_ok('IBWAPI::Restartservicestatus');
require_ok('IBWAPI::Scheduledtask');
require_ok('IBWAPI::Search');
require_ok('IBWAPI::View');
require_ok('IBWAPI::Zone_Auth');
require_ok('IBWAPI::Zone_Delegated');
require_ok('IBWAPI::Zone_Forward');
require_ok('IBWAPI::Zone_Stub');
require_ok('IBStruct::AddressAC');
require_ok('IBStruct::ChangedObject');
require_ok('IBStruct::DHCPMember');
require_ok('IBStruct::DHCPOption');
require_ok('IBStruct::DiscoveryData');
require_ok('IBStruct::DNSSECKeyParams');
require_ok('IBStruct::DNSSECTrustedKey');
require_ok('IBStruct::ExclusionRange');
require_ok('IBStruct::ExtensibleAttributes');
require_ok('IBStruct::ExtServer');
require_ok('IBStruct::FilterRule');
require_ok('IBStruct::ForwardingMemberServer');
require_ok('IBStruct::LogicFilterRule');
require_ok('IBStruct::MemberServer');
require_ok('IBStruct::MSDHCPOption');
require_ok('IBStruct::MSDHCPServer');
require_ok('IBStruct::MSDNSServer');
require_ok('IBStruct::Sortlist');
require_ok('IBStruct::TSIGAC');
require_ok('IBStruct::ZoneAssociation');


