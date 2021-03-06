#!/usr/bin/perl

package IBConsts;
use base qw( Exporter );
use Data::Dumper;
use Carp;
use warnings;
use Readonly;
use strict;

sub URL_PARM_EXISTS;
sub URL_FIELD_EXISTS;
sub URL_NAME_FIELD_EXISTS;
sub URL_MODULE_EXISTS;
sub URL_REF_MODULE_EXISTS;
sub URL_NAME_MODULE_EXISTS;
sub URL_SEARCH_EXISTS;
sub URL_PARM_NAME;
sub URL_FIELD_NAME;
sub URL_FIELD_TYPE;
sub URL_NAME_FIELD;
sub URL_MODULE_NAME;
sub URL_NAME_MODULE;
sub URL_REF_NAME_MODULE;
sub URL_SEARCH_NAME;
sub VERIFY_TIMESTAMP;
sub MYNAME;
sub MYLINE;
sub MYNAMELINE;
sub PRINT_MYNAME;
sub PRINT_MYLINE;
sub PRINT_MYNAMELINE;
sub LOG_ENTER_SUB;
sub LOG_EXIT_SUB;
sub SET_LOGGING;
sub LOG_DEBUG4;
sub LOG_DEBUG3;
sub LOG_DEBUG2;
sub LOG_DEBUG1;
sub LOG_DEBUG0;
sub LOG_INFO;
sub LOG_WARN;
sub LOG_ERROR;
sub LOG_FATAL;

Readonly our $_IB_VERSION => '0.95';

Readonly our $LOG_FATAL  => ' LOG_FATAL';
Readonly our $LOG_ERROR  => ' LOG_ERROR';
Readonly our $LOG_WARN   => '  LOG_WARN';
Readonly our $LOG_INFO   => '  LOG_INFO';
Readonly our $LOG_DEBUG0 => 'LOG_DEBUG0';
Readonly our $LOG_DEBUG1 => 'LOG_DEBUG1';
Readonly our $LOG_DEBUG2 => 'LOG_DEBUG2';
Readonly our $LOG_DEBUG3 => 'LOG_DEBUG3';
Readonly our $LOG_DEBUG4 => 'LOG_DEBUG4';
Readonly our $LOG_ENTER  => ' SUB ENTER';
Readonly our $LOG_EXIT   => ' SUB  EXIT';
Readonly our $LOG_URL    => '       URL';

Readonly our $_LOG_FATAL  => 0;
Readonly our $_LOG_ERROR  => $_LOG_FATAL + 1;
Readonly our $_LOG_WARN   => $_LOG_ERROR + 1;
Readonly our $_LOG_INFO   => $_LOG_WARN + 1;
Readonly our $_LOG_DEBUG0 => $_LOG_INFO + 1;
Readonly our $_LOG_DEBUG1 => $_LOG_DEBUG0 + 1;
Readonly our $_LOG_DEBUG2 => $_LOG_DEBUG1 + 1;
Readonly our $_LOG_DEBUG3 => $_LOG_DEBUG2 + 1;
Readonly our $_LOG_DEBUG4 => $_LOG_DEBUG3 + 1;

Readonly our $_LOG_SUB_ROUTINE_LEVEL => $_LOG_DEBUG3;
Readonly our $_LOG_URL_LEVEL         => $_LOG_DEBUG1;

Readonly::Hash our %_LOG_LEVEL => (
    $LOG_FATAL  => $_LOG_FATAL,
    $LOG_ERROR  => $_LOG_ERROR,
    $LOG_WARN   => $_LOG_WARN,
    $LOG_INFO   => $_LOG_INFO,
    $LOG_DEBUG0 => $_LOG_DEBUG0,
    $LOG_DEBUG1 => $_LOG_DEBUG1,
    $LOG_DEBUG2 => $_LOG_DEBUG2,
    $LOG_DEBUG3 => $_LOG_DEBUG3,
    $LOG_DEBUG4 => $_LOG_DEBUG4,
    $LOG_ENTER  => $_LOG_SUB_ROUTINE_LEVEL,
    $LOG_EXIT   => $_LOG_SUB_ROUTINE_LEVEL,
    $LOG_URL    => $_LOG_URL_LEVEL,
);

#
# These match the file names of the perl modules
#
Readonly our $MODULE_FIXEDADDRESS         => 'Fixedaddress';
Readonly our $MODULE_GRID                 => 'Grid';
Readonly our $MODULE_IPV4ADDRESS          => 'IPv4Address';
Readonly our $MODULE_IPV6ADDRESS          => 'IPv6Address';
Readonly our $MODULE_IPV6FIXEDADDRESS     => 'IPv6Fixedaddress';
Readonly our $MODULE_IPV6NETWORKCONTAINER => 'IPv6Networkcontainer';
Readonly our $MODULE_IPV6NETWORK          => 'IPv6Network';
Readonly our $MODULE_IPV6RANGE            => 'IPv6Range';
Readonly our $MODULE_LEASE                => 'Lease';
Readonly our $MODULE_MACFILTERADDRESS     => 'Macfilteraddress';
Readonly our $MODULE_MEMBER               => 'Member';
Readonly our $MODULE_NAMEDACL             => 'Namedacl';
Readonly our $MODULE_NETWORK              => 'Network';
Readonly our $MODULE_NETWORKCONTAINER     => 'Networkcontainer';
Readonly our $MODULE_NETWORKVIEW          => 'Networkview';
Readonly our $MODULE_RANGE                => 'Range';
Readonly our $MODULE_RECORD_AAAA          => 'Record_AAAA';
Readonly our $MODULE_RECORD_A             => 'Record_A';
Readonly our $MODULE_RECORD_CNAME         => 'Record_CNAME';
Readonly our $MODULE_RECORD_HOST          => 'Record_Host';
Readonly our $MODULE_RECORD_HOST_IPV4ADDR => 'Record_Host_IPv4Addr';
Readonly our $MODULE_RECORD_HOST_IPV6ADDR => 'Record_Host_IPv6Addr';
Readonly our $MODULE_RECORD_MX            => 'Record_MX';
Readonly our $MODULE_RECORD_PTR           => 'Record_PTR';
Readonly our $MODULE_RECORD_SRV           => 'Record_SRV';
Readonly our $MODULE_RECORD_TXT           => 'Record_TXT';
Readonly our $MODULE_RESTARTSERVICESTATUS => 'Restartservicestatus';
Readonly our $MODULE_SCHEDULEDTASK        => 'Scheduledtask';
Readonly our $MODULE_SEARCH               => 'Search';
Readonly our $MODULE_VIEW                 => 'View';
Readonly our $MODULE_ZONE_AUTH            => 'Zone_Auth';
Readonly our $MODULE_ZONE_DELEGATED       => 'Zone_Delegated';
Readonly our $MODULE_ZONE_FORWARD         => 'Zone_Forward';
Readonly our $MODULE_ZONE_STUB            => 'Zone_Stub';

Readonly our $PERL_MODULE_EXTATTR                   => 'IBStruct::ExtensibleAttributes';
Readonly our $PERL_MODULE_IBCONSTS                  => 'IBConsts';
Readonly our $PERL_MODULE_IBLWP                     => 'IBLWP';
Readonly our $PERL_MODULE_IBRECORD                  => 'IBRecord';
Readonly our $PERL_MODULE_IBWAPI                    => 'IBWAPI';
Readonly our $PERL_MODULE_JSON_BOOLEAN              => 'JSON::XS::Boolean';
Readonly our $PERL_MODULE_FIXEDADDRESS              => $PERL_MODULE_IBWAPI . '::' . $MODULE_FIXEDADDRESS;
Readonly our $PERL_MODULE_GRID                      => $PERL_MODULE_IBWAPI . '::' . $MODULE_GRID;
Readonly our $PERL_MODULE_IPV4ADDRESS               => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV4ADDRESS;
Readonly our $PERL_MODULE_IPV6ADDRESS               => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV6ADDRESS;
Readonly our $PERL_MODULE_IPV6FIXEDADDRESS          => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV6FIXEDADDRESS;
Readonly our $PERL_MODULE_IPV6NETWORKCONTAINER      => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV6NETWORKCONTAINER;
Readonly our $PERL_MODULE_IPV6NETWORK               => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV6NETWORK;
Readonly our $PERL_MODULE_IPV6RANGE                 => $PERL_MODULE_IBWAPI . '::' . $MODULE_IPV6RANGE;
Readonly our $PERL_MODULE_LEASE                     => $PERL_MODULE_IBWAPI . '::' . $MODULE_LEASE;
Readonly our $PERL_MODULE_MACFILTERADDRESS          => $PERL_MODULE_IBWAPI . '::' . $MODULE_MACFILTERADDRESS;
Readonly our $PERL_MODULE_MEMBER                    => $PERL_MODULE_IBWAPI . '::' . $MODULE_MEMBER;
Readonly our $PERL_MODULE_NAMEDACL                  => $PERL_MODULE_IBWAPI . '::' . $MODULE_NAMEDACL;
Readonly our $PERL_MODULE_NETWORKCONTAINER          => $PERL_MODULE_IBWAPI . '::' . $MODULE_NETWORKCONTAINER;
Readonly our $PERL_MODULE_NETWORK                   => $PERL_MODULE_IBWAPI . '::' . $MODULE_NETWORK;
Readonly our $PERL_MODULE_NETWORKVIEW               => $PERL_MODULE_IBWAPI . '::' . $MODULE_NETWORKVIEW;
Readonly our $PERL_MODULE_RANGE                     => $PERL_MODULE_IBWAPI . '::' . $MODULE_RANGE;
Readonly our $PERL_MODULE_RECORD_AAAA               => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_A;
Readonly our $PERL_MODULE_RECORD_A                  => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_AAAA;
Readonly our $PERL_MODULE_RECORD_CNAME              => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_CNAME;
Readonly our $PERL_MODULE_RECORD_HOST_IPV4ADDR      => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_HOST_IPV4ADDR;
Readonly our $PERL_MODULE_RECORD_HOST_IPV6ADDR      => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_HOST_IPV6ADDR;
Readonly our $PERL_MODULE_RECORD_HOST               => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_HOST;
Readonly our $PERL_MODULE_RECORD_MX                 => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_MX;
Readonly our $PERL_MODULE_RECORD_PTR                => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_PTR;
Readonly our $PERL_MODULE_RECORD_SRV                => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_SRV;
Readonly our $PERL_MODULE_RECORD_TXT                => $PERL_MODULE_IBWAPI . '::' . $MODULE_RECORD_TXT;
Readonly our $PERL_MODULE_RESTARTSERVICESTATUS      => $PERL_MODULE_IBWAPI . '::' . $MODULE_RESTARTSERVICESTATUS;
Readonly our $PERL_MODULE_SCHEDULEDTASK             => $PERL_MODULE_IBWAPI . '::' . $MODULE_SCHEDULEDTASK;
Readonly our $PERL_MODULE_SEARCH                    => $PERL_MODULE_IBWAPI . '::' . $MODULE_SEARCH;
Readonly our $PERL_MODULE_VIEW                      => $PERL_MODULE_IBWAPI . '::' . $MODULE_VIEW;
Readonly our $PERL_MODULE_ZONE_AUTH                 => $PERL_MODULE_IBWAPI . '::' . $MODULE_ZONE_AUTH;
Readonly our $PERL_MODULE_ZONE_DELEGATED            => $PERL_MODULE_IBWAPI . '::' . $MODULE_ZONE_DELEGATED;
Readonly our $PERL_MODULE_ZONE_FORWARD              => $PERL_MODULE_IBWAPI . '::' . $MODULE_ZONE_FORWARD;
Readonly our $PERL_MODULE_ZONE_STUB                 => $PERL_MODULE_IBWAPI . '::' . $MODULE_ZONE_STUB;
Readonly our $PERL_MODULE_FIXEDADDRESS_FILE         => $PERL_MODULE_IBWAPI . '/' . $MODULE_FIXEDADDRESS . '.pm';
Readonly our $PERL_MODULE_GRID_FILE                 => $PERL_MODULE_IBWAPI . '/' . $MODULE_GRID . '.pm';
Readonly our $PERL_MODULE_IPV4ADDRESS_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV4ADDRESS . '.pm';
Readonly our $PERL_MODULE_IPV6ADDRESS_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV6ADDRESS . '.pm';
Readonly our $PERL_MODULE_IPV6FIXEDADDRESS_FILE     => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV6FIXEDADDRESS . '.pm';
Readonly our $PERL_MODULE_IPV6NETWORKCONTAINER_FILE => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV6NETWORKCONTAINER . '.pm';
Readonly our $PERL_MODULE_IPV6NETWORK_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV6NETWORK . '.pm';
Readonly our $PERL_MODULE_IPV6RANGE_FILE            => $PERL_MODULE_IBWAPI . '/' . $MODULE_IPV6RANGE . '.pm';
Readonly our $PERL_MODULE_LEASE_FILE                => $PERL_MODULE_IBWAPI . '/' . $MODULE_LEASE . '.pm';
Readonly our $PERL_MODULE_MACFILTERADDRESS_FILE     => $PERL_MODULE_IBWAPI . '/' . $MODULE_MACFILTERADDRESS . '.pm';
Readonly our $PERL_MODULE_MEMBER_FILE               => $PERL_MODULE_IBWAPI . '/' . $MODULE_MEMBER . '.pm';
Readonly our $PERL_MODULE_NAMEDACL_FILE             => $PERL_MODULE_IBWAPI . '/' . $MODULE_NAMEDACL . '.pm';
Readonly our $PERL_MODULE_NETWORKCONTAINER_FILE     => $PERL_MODULE_IBWAPI . '/' . $MODULE_NETWORKCONTAINER . '.pm';
Readonly our $PERL_MODULE_NETWORK_FILE              => $PERL_MODULE_IBWAPI . '/' . $MODULE_NETWORK . '.pm';
Readonly our $PERL_MODULE_NETWORKVIEW_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_NETWORKVIEW . '.pm';
Readonly our $PERL_MODULE_RANGE_FILE                => $PERL_MODULE_IBWAPI . '/' . $MODULE_RANGE . '.pm';
Readonly our $PERL_MODULE_RECORD_AAAA_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_A . '.pm';
Readonly our $PERL_MODULE_RECORD_A_FILE             => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_AAAA . '.pm';
Readonly our $PERL_MODULE_RECORD_CNAME_FILE         => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_CNAME . '.pm';
Readonly our $PERL_MODULE_RECORD_HOST_IPV4ADDR_FILE => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_HOST_IPV4ADDR . '.pm';
Readonly our $PERL_MODULE_RECORD_HOST_IPV6ADDR_FILE => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_HOST_IPV6ADDR . '.pm';
Readonly our $PERL_MODULE_RECORD_HOST_FILE          => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_HOST . '.pm';
Readonly our $PERL_MODULE_RECORD_MX_FILE            => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_MX . '.pm';
Readonly our $PERL_MODULE_RECORD_PTR_FILE           => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_PTR . '.pm';
Readonly our $PERL_MODULE_RECORD_SRV_FILE           => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_SRV . '.pm';
Readonly our $PERL_MODULE_RECORD_TXT_FILE           => $PERL_MODULE_IBWAPI . '/' . $MODULE_RECORD_TXT . '.pm';
Readonly our $PERL_MODULE_RESTARTSERVICESTATUS_FILE => $PERL_MODULE_IBWAPI . '/' . $MODULE_RESTARTSERVICESTATUS . '.pm';
Readonly our $PERL_MODULE_SCHEDULEDTASK_FILE        => $PERL_MODULE_IBWAPI . '/' . $MODULE_SCHEDULEDTASK . '.pm';
Readonly our $PERL_MODULE_SEARCH_FILE               => $PERL_MODULE_IBWAPI . '/' . $MODULE_SEARCH . '.pm';
Readonly our $PERL_MODULE_VIEW_FILE                 => $PERL_MODULE_IBWAPI . '/' . $MODULE_VIEW . '.pm';
Readonly our $PERL_MODULE_ZONE_AUTH_FILE            => $PERL_MODULE_IBWAPI . '/' . $MODULE_ZONE_AUTH . '.pm';
Readonly our $PERL_MODULE_ZONE_DELEGATED_FILE       => $PERL_MODULE_IBWAPI . '/' . $MODULE_ZONE_DELEGATED . '.pm';
Readonly our $PERL_MODULE_ZONE_FORWARD_FILE         => $PERL_MODULE_IBWAPI . '/' . $MODULE_ZONE_FORWARD . '.pm';
Readonly our $PERL_MODULE_ZONE_STUB_FILE            => $PERL_MODULE_IBWAPI . '/' . $MODULE_ZONE_STUB . '.pm';

Readonly::Hash our %PERL_MODULE_FILE_NAMES => (
    $PERL_MODULE_FIXEDADDRESS         => $PERL_MODULE_FIXEDADDRESS_FILE,
    $PERL_MODULE_GRID                 => $PERL_MODULE_GRID_FILE,
    $PERL_MODULE_IPV4ADDRESS          => $PERL_MODULE_IPV4ADDRESS_FILE,
    $PERL_MODULE_IPV6ADDRESS          => $PERL_MODULE_IPV6ADDRESS_FILE,
    $PERL_MODULE_IPV6FIXEDADDRESS     => $PERL_MODULE_IPV6FIXEDADDRESS_FILE,
    $PERL_MODULE_IPV6NETWORKCONTAINER => $PERL_MODULE_IPV6NETWORKCONTAINER_FILE,
    $PERL_MODULE_IPV6NETWORK          => $PERL_MODULE_IPV6NETWORK_FILE,
    $PERL_MODULE_IPV6RANGE            => $PERL_MODULE_IPV6RANGE_FILE,
    $PERL_MODULE_LEASE                => $PERL_MODULE_LEASE_FILE,
    $PERL_MODULE_MACFILTERADDRESS     => $PERL_MODULE_MACFILTERADDRESS_FILE,
    $PERL_MODULE_MEMBER               => $PERL_MODULE_MEMBER_FILE,
    $PERL_MODULE_NAMEDACL             => $PERL_MODULE_NAMEDACL_FILE,
    $PERL_MODULE_NETWORKCONTAINER     => $PERL_MODULE_NETWORKCONTAINER_FILE,
    $PERL_MODULE_NETWORK              => $PERL_MODULE_NETWORK_FILE,
    $PERL_MODULE_NETWORKVIEW          => $PERL_MODULE_NETWORKVIEW_FILE,
    $PERL_MODULE_RANGE                => $PERL_MODULE_RANGE_FILE,
    $PERL_MODULE_RECORD_AAAA          => $PERL_MODULE_RECORD_AAAA_FILE,
    $PERL_MODULE_RECORD_A             => $PERL_MODULE_RECORD_A_FILE,
    $PERL_MODULE_RECORD_CNAME         => $PERL_MODULE_RECORD_CNAME_FILE,
    $PERL_MODULE_RECORD_HOST_IPV4ADDR => $PERL_MODULE_RECORD_HOST_IPV4ADDR_FILE,
    $PERL_MODULE_RECORD_HOST_IPV6ADDR => $PERL_MODULE_RECORD_HOST_IPV6ADDR_FILE,
    $PERL_MODULE_RECORD_HOST          => $PERL_MODULE_RECORD_HOST_FILE,
    $PERL_MODULE_RECORD_MX            => $PERL_MODULE_RECORD_MX_FILE,
    $PERL_MODULE_RECORD_PTR           => $PERL_MODULE_RECORD_PTR_FILE,
    $PERL_MODULE_RECORD_SRV           => $PERL_MODULE_RECORD_SRV_FILE,
    $PERL_MODULE_RECORD_TXT           => $PERL_MODULE_RECORD_TXT_FILE,
    $PERL_MODULE_RESTARTSERVICESTATUS => $PERL_MODULE_RESTARTSERVICESTATUS_FILE,
    $PERL_MODULE_SCHEDULEDTASK        => $PERL_MODULE_SCHEDULEDTASK_FILE,
    $PERL_MODULE_SEARCH               => $PERL_MODULE_SEARCH_FILE,
    $PERL_MODULE_VIEW                 => $PERL_MODULE_VIEW_FILE,
    $PERL_MODULE_ZONE_AUTH            => $PERL_MODULE_ZONE_AUTH_FILE,
    $PERL_MODULE_ZONE_DELEGATED       => $PERL_MODULE_ZONE_DELEGATED_FILE,
    $PERL_MODULE_ZONE_FORWARD         => $PERL_MODULE_ZONE_FORWARD_FILE,
    $PERL_MODULE_ZONE_STUB            => $PERL_MODULE_ZONE_STUB_FILE,
);

# ---------------------------
Readonly our $_IB_REF => '_ref';

Readonly our $IB_FIELDS             => 'IB_FIELDS';
Readonly our $IB_EMPTY_FIELD        => 'IB_EMPTY_FIELD';
Readonly our $IB_TRUE               => 'IB_TRUE';
Readonly our $IB_FALSE              => 'IB_FALSE';
Readonly our $IB_USERNAME           => 'IB_USERNAME';
Readonly our $IB_PASSWORD           => 'IB_PASSWORD';
Readonly our $IB_HOSTNAME           => 'IB_HOSTNAME';
Readonly our $IB_BASE_FIELDS        => 'IB_BASE_FIELDS';
Readonly our $IB_MAX_RESULTS        => 'IB_MAX_RESULTS';
Readonly our $IB_STRUCT_FIELDS      => 'IB_STRUCT_FIELDS';
Readonly our $IB_STRUCT_TYPES       => 'IB_STRUCT_TYPES';
Readonly our $IB_RETURN_FIELDS      => 'IB_RETURN_FIELDS';
Readonly our $IB_RETURN_FIELDS_PLUS => 'IB_RETURN_FIELDS_PLUS';
Readonly our $IB_RETURN_TYPE        => 'IB_RETURN_TYPE';
Readonly our $IB_READONLY_FIELDS    => 'IB_READONLY_FIELDS';
Readonly our $IB_SEARCHABLE_FIELDS  => 'IB_SEARCHABLE_FIELDS';
Readonly our $IB_SEARCHONLY_FIELDS  => 'IB_SEARCHONLY_FIELDS';

Readonly our $SEARCH_PARM_CASE_INSENSATIVE => 'SEARCH_PARM_CASE_INSENSATIVE';
Readonly our $SEARCH_PARM_EQUAL            => 'SEARCH_PARM_EQUAL';
Readonly our $SEARCH_PARM_GT               => 'SEARCH_PARM_GT';
Readonly our $SEARCH_PARM_NEGATIVE         => 'SEARCH_PARM_NEGATIVE';
Readonly our $SEARCH_PARM_LT               => 'SEARCH_PARM_LT';
Readonly our $SEARCH_PARM_REGEX            => 'SEARCH_PARM_REGEX';

Readonly our $TYPE_BOOL                          => 'TYPE_BOOL';
Readonly our $TYPE_BINDING_STATE                 => 'TYPE_BINDING_STATE';
Readonly our $TYPE_EXTATTRS                      => 'TYPE_EXTATTRS';
Readonly our $TYPE_INT                           => 'TYPE_INT';
Readonly our $TYPE_MEMBERS                       => 'TYPE_MEMBERS';
Readonly our $TYPE_MS_OPTIONS                    => 'TYPE_MS_OPTIONS';
Readonly our $TYPE_MS_SERVER                     => 'TYPE_MS_SERVER';
Readonly our $TYPE_OPTIONS                       => 'TYPE_OPTIONS';
Readonly our $TYPE_STRING                        => 'TYPE_STRING';
Readonly our $TYPE_STRING_ARRAY                  => 'TYPE_STRING_ARRAY';
Readonly our $TYPE_STRUCT_ADDRESSAC              => 'TYPE_STRUCT_ADDRESSAC';
Readonly our $TYPE_STRUCT_CHANGEDOBJECT          => 'TYPE_STRUCT_CHANGEDOBJECT';
Readonly our $TYPE_STRUCT_DHCPMEMBER             => 'TYPE_STRUCT_DHCPMEMBER';
Readonly our $TYPE_STRUCT_DHCPOPTION             => 'TYPE_STRUCT_DHCPOPTION';
Readonly our $TYPE_STRUCT_DISCOVERYDATA          => 'TYPE_STRUCT_DISCOVERYDATA';
Readonly our $TYPE_STRUCT_DNSSECKEYPARAMS        => 'TYPE_STRUCT_DNSSECKEYPARAMS';
Readonly our $TYPE_STRUCT_DNSSECTRUSTEDKEY       => 'TYPE_STRUCT_DNSSECTRUSTEDKEY';
Readonly our $TYPE_STRUCT_EXCLUSIONRANGE         => 'TYPE_STRUCT_EXCLUSIONRANGE';
Readonly our $TYPE_STRUCT_EXTSERVER              => 'TYPE_STRUCT_EXTSERVER';
Readonly our $TYPE_STRUCT_FILTERRULE             => 'TYPE_STRUCT_FILTERRULE';
Readonly our $TYPE_STRUCT_FORWARDINGMEMBERSERVER => 'TYPE_STRUCT_FORWARDINGMEMBERSERVER';
Readonly our $TYPE_STRUCT_LOGICFILTERRULE        => 'TYPE_STRUCT_LOGICFILTERRULE';
Readonly our $TYPE_STRUCT_MEMBERSERVER           => 'TYPE_STRUCT_MEMBERSERVER';
Readonly our $TYPE_STRUCT_MSDHCPOPTION           => 'TYPE_STRUCT_MSDHCPOPTION';
Readonly our $TYPE_STRUCT_MSDHCPSERVER           => 'TYPE_STRUCT_MSDHCPSERVER';
Readonly our $TYPE_STRUCT_SORTLIST               => 'TYPE_STRUCT_SORTLIST';
Readonly our $TYPE_STRUCT_TSIGAC                 => 'TYPE_STRUCT_TSIGAC';
Readonly our $TYPE_STRUCT_ZONEASSOCIATION        => 'TYPE_STRUCT_ZONEASSOCIATION';
Readonly our $TYPE_TIMESTAMP                     => 'TYPE_TIMESTAMP';
Readonly our $TYPE_UINT                          => 'TYPE_UINT';
Readonly our $TYPE_UNKNOWN                       => 'TYPE_UNKNOWN';
Readonly our $TYPE_ZONE_ASSOCIATIONS             => 'TYPE_ZONE_ASSOCIATIONS';

Readonly our $BINDING_STATE_ABANDONDED => 'ABANDONED';
Readonly our $BINDING_STATE_ACTIVE     => 'ACTIVE';
Readonly our $BINDING_STATE_BACKUP     => 'BACKUP';
Readonly our $BINDING_STATE_DECLINED   => 'DECLINED';
Readonly our $BINDING_STATE_EXPIRED    => 'EXPIRED';
Readonly our $BINDING_STATE_FREE       => 'FREE';
Readonly our $BINDING_STATE_OFFERED    => 'OFFERED';
Readonly our $BINDING_STATE_RELEASED   => 'RELEASED';
Readonly our $BINDING_STATE_RESET      => 'RESET';
Readonly our $BINDING_STATE_STATIC     => 'STATIC';

Readonly our $FIELD_REF                                  => 'FIELD_REF';
Readonly our $FIELD_ACCESS_LIST                          => 'FIELD_ACCESS_LIST';
Readonly our $FIELD_ADDRESS                              => 'FIELD_ADDRESS';
Readonly our $FIELD_ADDRESS_TYPE                         => 'FIELD_ADDRESS_TYPE';
Readonly our $FIELD_AGENT_CIRCUIT_ID                     => 'FIELD_AGENT_CIRCUIT_ID';
Readonly our $FIELD_AGENT_REMOTE_ID                      => 'FIELD_AGENT_REMOTE_ID';
Readonly our $FIELD_ALIASES                              => 'FIELD_ALIASES';
Readonly our $FIELD_ALLOW_ACTIVE_DIR                     => 'FIELD_ALLOW_ACTIVE_DIR';
Readonly our $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE   => 'FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE';
Readonly our $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES          => 'FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES';
Readonly our $FIELD_ALLOW_QUERY                          => 'FIELD_ALLOW_QUERY';
Readonly our $FIELD_ALLOW_TRANSFER                       => 'FIELD_ALLOW_TRANSFER';
Readonly our $FIELD_ALLOW_UPDATE                         => 'FIELD_ALLOW_UPDATE';
Readonly our $FIELD_ALLOW_UPDATE_FORWARDING              => 'FIELD_ALLOW_UPDATE_FORWARDING';
Readonly our $FIELD_ALWAYS_UPDATE_DNS                    => 'FIELD_ALWAYS_UPDATE_DNS';
Readonly our $FIELD_APPROVAL_STATUS                      => 'FIELD_APPROVAL_STATUS';
Readonly our $FIELD_APPROVER                             => 'FIELD_APPROVER';
Readonly our $FIELD_APPROVER_COMMENT                     => 'FIELD_APPROVER_COMMENT';
Readonly our $FIELD_AUTHENTICATION_TIME                  => 'FIELD_AUTHENTICATION_TIME';
Readonly our $FIELD_AUTHORITY                            => 'FIELD_AUTHORITY';
Readonly our $FIELD_AUTO_CREATE_REVERSEZONE              => 'FIELD_AUTO_CREATE_REVERSEZONE';
Readonly our $FIELD_AUTOMATIC_RESTART                    => 'FIELD_AUTOMATIC_RESTART';
Readonly our $FIELD_BILLING_CLASS                        => 'FIELD_BILLING_CLASS';
Readonly our $FIELD_BINDING_STATE                        => 'FIELD_BINDING_STATE';
Readonly our $FIELD_BLACKLIST_ACTION                     => 'FIELD_BLACKLIST_ACTION';
Readonly our $FIELD_BLACKLIST_LOG_QUERY                  => 'FIELD_BLACKLIST_LOG_QUERY';
Readonly our $FIELD_BLACKLIST_REDIRECT_ADDRESSES         => 'FIELD_BLACKLIST_REDIRECT_ADDRESSES';
Readonly our $FIELD_BLACKLIST_REDIRECT_TTL               => 'FIELD_BLACKLIST_REDIRECT_TTL';
Readonly our $FIELD_BLACKLIST_RULESETS                   => 'FIELD_BLACKLIST_RULESETS';
Readonly our $FIELD_BOOTFILE                             => 'FIELD_BOOTFILE';
Readonly our $FIELD_BOOTSERVER                           => 'FIELD_BOOTSERVER';
Readonly our $FIELD_CANONICAL                            => 'FIELD_CANONICAL';
Readonly our $FIELD_CHANGED_OBJECTS                      => 'FIELD_CHANGED_OBJECTS';
Readonly our $FIELD_CLIENT_HOSTNAME                      => 'FIELD_CLIENT_HOSTNAME';
Readonly our $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO       => 'FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO';
Readonly our $FIELD_CLTT                                 => 'FIELD_CLTT';
Readonly our $FIELD_COMMENT                              => 'FIELD_COMMENT';
Readonly our $FIELD_CONFIGURE_FOR_DHCP                   => 'FIELD_CONFIGURE_FOR_DHCP';
Readonly our $FIELD_CONFIGURE_FOR_DNS                    => 'FIELD_CONFIGURE_FOR_DNS';
Readonly our $FIELD_CONTAINS_ADDRESS                     => 'FIELD_CONTAINS_ADDRESS';
Readonly our $FIELD_COPY_XFER_TO_NOTIFY                  => 'FIELD_COPY_XFER_TO_NOTIFY';
Readonly our $FIELD_CREATE_PTR_FOR_BULK_HOSTS            => 'FIELD_CREATE_PTR_FOR_BULK_HOSTS';
Readonly our $FIELD_CREATE_PTR_FOR_HOSTS                 => 'FIELD_CREATE_PTR_FOR_HOSTS';
Readonly our $FIELD_CREATE_UNDERSCORE_ZONES              => 'FIELD_CREATE_UNDERSCORE_ZONES';
Readonly our $FIELD_CUSTOM_ROOT_NAME_SERVERS             => 'FIELD_CUSTOM_ROOT_NAME_SERVERS';
Readonly our $FIELD_DDNS_DOMAINNAME                      => 'FIELD_DDNS_DOMAINNAME';
Readonly our $FIELD_DDNS_ENABLE_OPTION_FQDN              => 'FIELD_DDNS_ENABLE_OPTION_FQDN';
Readonly our $FIELD_DDNS_GENERATE_HOSTNAME               => 'FIELD_DDNS_GENERATE_HOSTNAME';
Readonly our $FIELD_DDNS_HOSTNAME                        => 'FIELD_DDNS_HOSTNAME';
Readonly our $FIELD_DDNS_SERVER_ALWAYS_UPDATES           => 'FIELD_DDNS_SERVER_ALWAYS_UPDATES';
Readonly our $FIELD_DDNS_TTL                             => 'FIELD_DDNS_TTL';
Readonly our $FIELD_DDNS_UPDATE_FIXED_ADDRESSES          => 'FIELD_DDNS_UPDATE_FIXED_ADDRESSES';
Readonly our $FIELD_DDNS_USER_OPTION81                   => 'FIELD_DDNS_USER_OPTION81';
Readonly our $FIELD_DELEGATED_TTL                        => 'FIELD_DELEGATED_TTL';
Readonly our $FIELD_DELEGATE_TO                          => 'FIELD_DELEGATE_TO';
Readonly our $FIELD_DENY_ALL_CLIENTS                     => 'FIELD_DENY_ALL_CLIENTS';
Readonly our $FIELD_DENY_BOOTP                           => 'FIELD_DENY_BOOTP';
Readonly our $FIELD_DHCP_CLIENT_IDENTIFIER               => 'FIELD_DHCP_CLIENT_IDENTIFIER';
Readonly our $FIELD_DHCP_STATUS                          => 'FIELD_DHCP_STATUS';
Readonly our $FIELD_DISABLE                              => 'FIELD_DISABLE';
Readonly our $FIELD_DISABLE_FORWARDING                   => 'FIELD_DISABLE_FORWARDING';
Readonly our $FIELD_DISCOVERED_DATA                      => 'FIELD_DISCOVERED_DATA';
Readonly our $FIELD_DISPLAY_DOMAIN                       => 'FIELD_DISPLAY_DOMAIN';
Readonly our $FIELD_DNS64_ENABLED                        => 'FIELD_DNS64_ENABLED';
Readonly our $FIELD_DNS64_GROUPS                         => 'FIELD_DNS64_GROUPS';
Readonly our $FIELD_DNS_ALIASES                          => 'FIELD_DNS_ALIASES';
Readonly our $FIELD_DNS_CANONICAL                        => 'FIELD_DNS_CANONICAL';
Readonly our $FIELD_DNS_FQDN                             => 'FIELD_DNS_FQDN';
Readonly our $FIELD_DNS_MAIL_EXCHANGER                   => 'FIELD_DNS_MAIL_EXCHANGER';
Readonly our $FIELD_DNS_NAME                             => 'FIELD_DNS_NAME';
Readonly our $FIELD_DNS_PTRDNAME                         => 'FIELD_DNS_PTRDNAME';
Readonly our $FIELD_DNSSEC_ENABLED                       => 'FIELD_DNSSEC_ENABLED';
Readonly our $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED    => 'FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED';
Readonly our $FIELD_DNSSEC_KEY_PARAMS                    => 'FIELD_DNSSEC_KEY_PARAMS';
Readonly our $FIELD_DNSSEC_TRUSTED_KEYS                  => 'FIELD_DNSSEC_TRUSTED_KEYS';
Readonly our $FIELD_DNSSEC_VALIDATION_ENABLED            => 'FIELD_DNSSEC_VALIDATION_ENABLED';
Readonly our $FIELD_DNS_SOA_EMAIL                        => 'FIELD_DNS_SOA_EMAIL';
Readonly our $FIELD_DNS_SOA_MNAME                        => 'FIELD_DNS_SOA_MNAME';
Readonly our $FIELD_DNS_STATUS                           => 'FIELD_DNS_STATUS';
Readonly our $FIELD_DNS_TARGET                           => 'FIELD_DNS_TARGET';
Readonly our $FIELD_DO_HOST_ABSTRACTION                  => 'FIELD_DO_HOST_ABSTRACTION';
Readonly our $FIELD_DOMAIN_NAME                          => 'FIELD_DOMAIN_NAME';
Readonly our $FIELD_DOMAIN_NAME_SERVERS                  => 'FIELD_DOMAIN_NAME_SERVERS';
Readonly our $FIELD_DUID                                 => 'FIELD_DUID';
Readonly our $FIELD_EFFECTIVE_CHECK_NAMES_POLICY         => 'FIELD_EFFECTIVE_CHECK_NAMES_POLICY';
Readonly our $FIELD_EFFECTIVE_RECORD_NAME_POLICY         => 'FIELD_EFFECTIVE_RECORD_NAME_POLICY';
Readonly our $FIELD_EMAIL_LIST                           => 'FIELD_EMAIL_LIST';
Readonly our $FIELD_ENABLE_BLACKLIST                     => 'FIELD_ENABLE_BLACKLIST';
Readonly our $FIELD_ENABLE_DDNS                          => 'FIELD_ENABLE_DDNS';
Readonly our $FIELD_ENABLE_DHCP_THRESHOLDS               => 'FIELD_ENABLE_DHCP_THRESHOLDS';
Readonly our $FIELD_ENABLE_EMAIL_WARNINGS                => 'FIELD_ENABLE_EMAIL_WARNINGS';
Readonly our $FIELD_ENABLE_IFMAP_PUBLISHING              => 'FIELD_ENABLE_IFMAP_PUBLISHING';
Readonly our $FIELD_ENABLE_PXE_LEASE_TIME                => 'FIELD_ENABLE_PXE_LEASE_TIME';
Readonly our $FIELD_ENABLE_RFC2317_EXCLUSION             => 'FIELD_ENABLE_RFC2317_EXCLUSION';
Readonly our $FIELD_ENABLE_SNMP_WARNINGS                 => 'FIELD_ENABLE_SNMP_WARNINGS';
Readonly our $FIELD_END_ADDR                             => 'FIELD_END_ADDR';
Readonly our $FIELD_ENDS                                 => 'FIELD_ENDS';
Readonly our $FIELD_EXATTRS                              => 'FIELD_EXATTRS';
Readonly our $EXTATTR_VALUE                              => 'value';
Readonly our $FIELD_EXCLUDE                              => 'FIELD_EXCLUDE';
Readonly our $FIELD_EXECUTE_NOW                          => 'FIELD_EXECUTE_NOW';
Readonly our $FIELD_EXECUTION_STATUS                     => 'FIELD_EXECUTION_STATUS';
Readonly our $FIELD_EXECUTION_TIME                       => 'FIELD_EXECUTION_TIME';
Readonly our $FIELD_EXPIRATION_TIME                      => 'FIELD_EXPIRATION_TIME';
Readonly our $FIELD_EXPLODED_ACCESS_LIST                 => 'FIELD_EXPLODED_ACCESS_LIST';
Readonly our $FIELD_EXTATTRS                             => 'FIELD_EXTATTRS';
Readonly our $FIELD_EXTERNAL_PRIMARIES                   => 'FIELD_EXTERNAL_PRIMARIES';
Readonly our $FIELD_EXTERNAL_SECONDARIES                 => 'FIELD_EXTERNAL_SECONDARIES';
Readonly our $FIELD_FAILOVER_ASSOCIATION                 => 'FIELD_FAILOVER_ASSOCIATION';
Readonly our $FIELD_FILTER                               => 'FIELD_FILTER';
Readonly our $FIELD_FILTER_AAAA                          => 'FIELD_FILTER_AAAA';
Readonly our $FIELD_FILTER_AAAA_LIST                     => 'FIELD_FILTER_AAAA_LIST';
Readonly our $FIELD_FINGERPRINT                          => 'FIELD_FINGERPRINT';
Readonly our $FIELD_FINGERPRINT_FILTER_RULES             => 'FIELD_FINGERPRINT_FILTER_RULES';
Readonly our $FIELD_FORWARDERS                           => 'FIELD_FORWARDERS';
Readonly our $FIELD_FORWARDERS_ONLY                      => 'FIELD_FORWARDERS_ONLY';
Readonly our $FIELD_FORWARDING_SERVERS                   => 'FIELD_FORWARDING_SERVERS';
Readonly our $FIELD_FORWARD_ONLY                         => 'FIELD_FORWARD_ONLY';
Readonly our $FIELD_FORWARD_TO                           => 'FIELD_FORWARD_TO';
Readonly our $FIELD_FQDN                                 => 'FIELD_FQDN';
Readonly our $FIELD_GRID_PRIMARY                         => 'FIELD_GRID_PRIMARY';
Readonly our $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D => 'FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D';
Readonly our $FIELD_GRID_SECONDARIES                     => 'FIELD_GRID_SECONDARIES';
Readonly our $FIELD_GUEST_CUSTOM_FIELD1                  => 'FIELD_GUEST_CUSTOM_FIELD1';
Readonly our $FIELD_GUEST_CUSTOM_FIELD2                  => 'FIELD_GUEST_CUSTOM_FIELD2';
Readonly our $FIELD_GUEST_CUSTOM_FIELD3                  => 'FIELD_GUEST_CUSTOM_FIELD3';
Readonly our $FIELD_GUEST_CUSTOM_FIELD4                  => 'FIELD_GUEST_CUSTOM_FIELD4';
Readonly our $FIELD_GUEST_EMAIL                          => 'FIELD_GUEST_EMAIL';
Readonly our $FIELD_GUEST_FIRST_NAME                     => 'FIELD_GUEST_FIRST_NAME';
Readonly our $FIELD_GUEST_LAST_NAME                      => 'FIELD_GUEST_LAST_NAME';
Readonly our $FIELD_GUEST_MIDDLE_NAME                    => 'FIELD_GUEST_MIDDLE_NAME';
Readonly our $FIELD_GUEST_PHONE                          => 'FIELD_GUEST_PHONE';
Readonly our $FIELD_HARDWARE                             => 'FIELD_HARDWARE';
Readonly our $FIELD_HIGH_WATER_MARK                      => 'FIELD_HIGH_WATER_MARK';
Readonly our $FIELD_HIGH_WATER_MARK_RESET                => 'FIELD_HIGH_WATER_MARK_RESET';
Readonly our $FIELD_HOST                                 => 'FIELD_HOST';
Readonly our $FIELD_HOST_NAME                            => 'FIELD_HOST_NAME';
Readonly our $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS      => 'FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS';
Readonly our $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST      => 'FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST';
Readonly our $FIELD_IMPORT_FROM                          => 'FIELD_IMPORT_FROM';
Readonly our $FIELD_IP_ADDRESS                           => 'FIELD_IP_ADDRESS';
Readonly our $FIELD_IPV4ADDR                             => 'FIELD_IPV4ADDR';
Readonly our $FIELD_IPV4ADDRS                            => 'FIELD_IPV4ADDRS';
Readonly our $FIELD_IPV4_ADDRESS                         => 'FIELD_IPV4_ADDRESS';
Readonly our $FIELD_IPV6ADDR                             => 'FIELD_IPV6ADDR';
Readonly our $FIELD_IPV6ADDRS                            => 'FIELD_IPV6ADDRS';
Readonly our $FIELD_IPV6PREFIX                           => 'FIELD_IPV6PREFIX';
Readonly our $FIELD_IPV6PREFIX_BITS                      => 'FIELD_IPV6PREFIX_BITS';
Readonly our $FIELD_IPV6_ADDRESS                         => 'FIELD_IPV6_ADDRESS';
Readonly our $FIELD_IPV6_DUID                            => 'FIELD_IPV6_DUID';
Readonly our $FIELD_IPV6_END_PREFIX                      => 'FIELD_IPV6_END_PREFIX';
Readonly our $FIELD_IPV6_IAID                            => 'FIELD_IPV6_IAID';
Readonly our $FIELD_IPV6_PREFERRED_LIFETIME              => 'FIELD_IPV6_PREFERRED_LIFETIME';
Readonly our $FIELD_IPV6_PREFIX                          => 'FIELD_IPV6_PREFIX';
Readonly our $FIELD_IPV6_PREFIX_BITS                     => 'FIELD_IPV6_PREFIX_BITS';
Readonly our $FIELD_IPV6_START_PREFIX                    => 'FIELD_IPV6_START_PREFIX';
Readonly our $FIELD_IS_CONFLICT                          => 'FIELD_IS_CONFLICT';
Readonly our $FIELD_IS_DEFAULT                           => 'FIELD_IS_DEFAULT';
Readonly our $FIELD_IS_DNSSEC_ENABLED                    => 'FIELD_IS_DNSSEC_ENABLED';
Readonly our $FIELD_IS_DNSSEC_SIGNED                     => 'FIELD_IS_DNSSEC_SIGNED';
Readonly our $FIELD_IS_REGISTERED_USER                   => 'FIELD_IS_REGISTERED_USER';
Readonly our $FIELD_IS_SPLIT_SCOPE                       => 'FIELD_IS_SPLIT_SCOPE';
Readonly our $FIELD_KNOWN_CLIENTS                        => 'FIELD_KNOWN_CLIENTS';
Readonly our $FIELD_LAME_TTL                             => 'FIELD_LAME_TTL';
Readonly our $FIELD_LAST_QUERIED                         => 'FIELD_LAST_QUERIED';
Readonly our $FIELD_LEASE_SCAVENGE_TIME                  => 'FIELD_LEASE_SCAVENGE_TIME';
Readonly our $FIELD_LEASE_STATE                          => 'FIELD_LEASE_STATE';
Readonly our $FIELD_LOCKED                               => 'FIELD_LOCKED';
Readonly our $FIELD_LOCKED_BY                            => 'FIELD_LOCKED_BY';
Readonly our $FIELD_LOGIC_FILTER_RULES                   => 'FIELD_LOGIC_FILTER_RULES';
Readonly our $FIELD_LOW_WATER_MARK                       => 'FIELD_LOW_WATER_MARK';
Readonly our $FIELD_LOW_WATER_MARK_RESET                 => 'FIELD_LOW_WATER_MARK_RESET';
Readonly our $FIELD_MAC                                  => 'FIELD_MAC';
Readonly our $FIELD_MAC_ADDRESS                          => 'FIELD_MAC_ADDRESS';
Readonly our $FIELD_MAC_FILTER_RULES                     => 'FIELD_MAC_FILTER_RULES';
Readonly our $FIELD_MAIL_EXCHANGER                       => 'FIELD_MAIL_EXCHANGER';
Readonly our $FIELD_MASK_PREFIX                          => 'FIELD_MASK_PREFIX';
Readonly our $FIELD_MATCH_CLIENT                         => 'FIELD_MATCH_CLIENT';
Readonly our $FIELD_MATCH_CLIENTS                        => 'FIELD_MATCH_CLIENTS';
Readonly our $FIELD_MATCH_DESTINATIONS                   => 'FIELD_MATCH_DESTINATIONS';
Readonly our $FIELD_MEMBER                               => 'FIELD_MEMBER';
Readonly our $FIELD_MEMBERS                              => 'FIELD_MEMBERS';
Readonly our $FIELD_MS_AD_INTEGRATED                     => 'FIELD_MS_AD_INTEGRATED';
Readonly our $FIELD_MS_ALLOW_TRANSFER                    => 'FIELD_MS_ALLOW_TRANSFER';
Readonly our $FIELD_MS_ALLOW_TRANSFER_MODE               => 'FIELD_MS_ALLOW_TRANSFER_MODE';
Readonly our $FIELD_MS_DDNS_MODE                         => 'FIELD_MS_DDNS_MODE';
Readonly our $FIELD_MS_MANAGED                           => 'FIELD_MS_MANAGED';
Readonly our $FIELD_MS_OPTIONS                           => 'FIELD_MS_OPTIONS';
Readonly our $FIELD_MS_PRIMARIES                         => 'FIELD_MS_PRIMARIES';
Readonly our $FIELD_MS_READ_ONLY                         => 'FIELD_MS_READ_ONLY';
Readonly our $FIELD_MS_SECONDARIES                       => 'FIELD_MS_SECONDARIES';
Readonly our $FIELD_MS_SERVER                            => 'FIELD_MS_SERVER';
Readonly our $FIELD_MS_SYNC_MASTER_NAME                  => 'FIELD_MS_SYNC_MASTER_NAME';
Readonly our $FIELD_NAC_FILTER_RULES                     => 'FIELD_NAC_FILTER_RULES';
Readonly our $FIELD_NAME                                 => 'FIELD_NAME';
Readonly our $FIELD_NAMES                                => 'FIELD_NAMES';
Readonly our $FIELD_NETMASK                              => 'FIELD_NETMASK';
Readonly our $FIELD_NETWORK                              => 'FIELD_NETWORK';
Readonly our $FIELD_NETWORK_ASSOCIATIONS                 => 'FIELD_NETWORK_ASSOCIATIONS';
Readonly our $FIELD_NETWORK_CONTAINER                    => 'FIELD_NETWORK_CONTAINER';
Readonly our $FIELD_NETWORK_VIEW                         => 'FIELD_NETWORK_VIEW';
Readonly our $FIELD_NEVER_ENDS                           => 'FIELD_NEVER_ENDS';
Readonly our $FIELD_NEVER_EXPIRES                        => 'FIELD_NEVER_EXPIRES';
Readonly our $FIELD_NEVER_STARTS                         => 'FIELD_NEVER_STARTS';
Readonly our $FIELD_NEXT_BINDING_STATE                   => 'FIELD_NEXT_BINDING_STATE';
Readonly our $FIELD_NEXTSERVER                           => 'FIELD_NEXTSERVER';
Readonly our $FIELD_NOTIFY_DELAY                         => 'FIELD_NOTIFY_DELAY';
Readonly our $FIELD_NS_GROUP                             => 'FIELD_NS_GROUP';
Readonly our $FIELD_NXDOMAIN_LOG_QUERY                   => 'FIELD_NXDOMAIN_LOG_QUERY';
Readonly our $FIELD_NXDOMAIN_REDIRECT                    => 'FIELD_NXDOMAIN_REDIRECT';
Readonly our $FIELD_NXDOMAIN_REDIRECT_ADDRESSES          => 'FIELD_NXDOMAIN_REDIRECT_ADDRESSES';
Readonly our $FIELD_NXDOMAIN_REDIRECT_TTL                => 'FIELD_NXDOMAIN_REDIRECT_TTL';
Readonly our $FIELD_NXDOMAIN_RULESETS                    => 'FIELD_NXDOMAIN_RULESETS';
Readonly our $FIELD_OBJECTS                              => 'FIELD_OBJECTS';
Readonly our $FIELD_ON_COMMIT                            => 'FIELD_ON_COMMIT';
Readonly our $FIELD_ON_EXPIRY                            => 'FIELD_ON_EXPIRY';
Readonly our $FIELD_ON_RELEASE                           => 'FIELD_ON_RELEASE';
Readonly our $FIELD_OPTION                               => 'FIELD_OPTION';
Readonly our $FIELD_OPTION_FILTER_RULES                  => 'FIELD_OPTION_FILTER_RULES';
Readonly our $FIELD_OPTIONS                              => 'FIELD_OPTIONS';
Readonly our $FIELD_PARENT                               => 'FIELD_PARENT';
Readonly our $FIELD_PORT                                 => 'FIELD_PORT';
Readonly our $FIELD_PREFERENCE                           => 'FIELD_PREFERENCE';
Readonly our $FIELD_PREFERRED_LIFETIME                   => 'FIELD_PREFERRED_LIFETIME';
Readonly our $FIELD_PREFIX                               => 'FIELD_PREFIX';
Readonly our $FIELD_PRIMARY_TYPE                         => 'FIELD_PRIMARY_TYPE';
Readonly our $FIELD_PRIORITY                             => 'FIELD_PRIORITY';
Readonly our $FIELD_PROTOCOL                             => 'FIELD_PROTOCOL';
Readonly our $FIELD_PTRDNAME                             => 'FIELD_PTRDNAME';
Readonly our $FIELD_PXE_LEASE_TIME                       => 'FIELD_PXE_LEASE_TIME';
Readonly our $FIELD_RECORD_NAME_POLICY                   => 'FIELD_RECORD_NAME_POLICY';
Readonly our $FIELD_RECORDS_MONITORED                    => 'FIELD_RECORDS_MONITORED';
Readonly our $FIELD_RECURSION                            => 'FIELD_RECURSION';
Readonly our $FIELD_RECYCLE_LEASES                       => 'FIELD_RECYCLE_LEASES';
Readonly our $FIELD_RELAY_AGENT_FILTER_RULES             => 'FIELD_RELAY_AGENT_FILTER_RULES';
Readonly our $FIELD_REPORTING_STATUS                     => 'FIELD_REPORTING_STATUS';
Readonly our $FIELD_RESERVED_FOR_INFOBLOX                => 'FIELD_RESERVED_FOR_INFOBLOX';
Readonly our $FIELD_ROOT_NAME_SERVER_TYPE                => 'FIELD_ROOT_NAME_SERVER_TYPE';
Readonly our $FIELD_RR_NOT_QUERIED_ENABLED_TIME          => 'FIELD_RR_NOT_QUERIED_ENABLED_TIME';
Readonly our $FIELD_RRSET_ORDER                          => 'FIELD_RRSET_ORDER';
Readonly our $FIELD_SCHEDULED_TIME                       => 'FIELD_SCHEDULED_TIME';
Readonly our $FIELD_SERVED_BY                            => 'FIELD_SERVED_BY';
Readonly our $FIELD_SERVER_ASSOCIATION_TYPE              => 'FIELD_SERVER_ASSOCIATION_TYPE';
Readonly our $FIELD_SERVER_HOST_NAME                     => 'FIELD_SERVER_HOST_NAME';
Readonly our $FIELD_SET_SOA_SERIAL_NUMBER                => 'FIELD_SET_SOA_SERIAL_NUMBER';
Readonly our $FIELD_SHARED_NETWORK_NAME                  => 'FIELD_SHARED_NETWORK_NAME';
Readonly our $FIELD_SOA_DEFAULT_TTL                      => 'FIELD_SOA_DEFAULT_TTL';
Readonly our $FIELD_SOA_EMAIL                            => 'FIELD_SOA_EMAIL';
Readonly our $FIELD_SOA_EXPIRE                           => 'FIELD_SOA_EXPIRE';
Readonly our $FIELD_SOA_MNAME                            => 'FIELD_SOA_MNAME';
Readonly our $FIELD_SOA_NEGATIVE_TTL                     => 'FIELD_SOA_NEGATIVE_TTL';
Readonly our $FIELD_SOA_REFRESH                          => 'FIELD_SOA_REFRESH';
Readonly our $FIELD_SOA_RETRY                            => 'FIELD_SOA_RETRY';
Readonly our $FIELD_SOA_SERIAL_NUMBER                    => 'FIELD_SOA_SERIAL_NUMBER';
Readonly our $FIELD_SORTLIST                             => 'FIELD_SORTLIST';
Readonly our $FIELD_SPLIT_MEMBER                         => 'FIELD_SPLIT_MEMBER';
Readonly our $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT        => 'FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT';
Readonly our $FIELD_SRGS                                 => 'FIELD_SRGS';
Readonly our $FIELD_START_ADDR                           => 'FIELD_START_ADDR';
Readonly our $FIELD_STARTS                               => 'FIELD_STARTS';
Readonly our $FIELD_STATUS                               => 'FIELD_STATUS';
Readonly our $FIELD_STUB_FROM                            => 'FIELD_STUB_FROM';
Readonly our $FIELD_STUB_MEMBERS                         => 'FIELD_STUB_MEMBERS';
Readonly our $FIELD_STUB_MSSERVERS                       => 'FIELD_STUB_MSSERVERS';
Readonly our $FIELD_SUBMITTER                            => 'FIELD_SUBMITTER';
Readonly our $FIELD_SUBMITTER_COMMENT                    => 'FIELD_SUBMITTER_COMMENT';
Readonly our $FIELD_SUBMIT_TIME                          => 'FIELD_SUBMIT_TIME';
Readonly our $FIELD_TARGET                               => 'FIELD_TARGET';
Readonly our $FIELD_TASK_ID                              => 'FIELD_TASK_ID';
Readonly our $FIELD_TEMPLATE                             => 'FIELD_TEMPLATE';
Readonly our $FIELD_TEXT                                 => 'FIELD_TEXT';
Readonly our $FIELD_TICKET_NUMBER                        => 'FIELD_TICKET_NUMBER';
Readonly our $FIELD_TSFP                                 => 'FIELD_TSFP';
Readonly our $FIELD_TSTP                                 => 'FIELD_TSTP';
Readonly our $FIELD_TTL                                  => 'FIELD_TTL';
Readonly our $FIELD_TYPES                                => 'FIELD_TYPES';
Readonly our $FIELD_UID                                  => 'FIELD_UID';
Readonly our $FIELD_UNKNOWN_CLIENTS                      => 'FIELD_UNKNOWN_CLIENTS';
Readonly our $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL          => 'FIELD_UPDATE_DNS_ON_LEASE_RENEWAL';
Readonly our $FIELD_UPDATE_FORWARDING                    => 'FIELD_UPDATE_FORWARDING';
Readonly our $FIELD_USAGE                                => 'FIELD_USAGE';
Readonly our $FIELD_USE_ALLOW_ACTIVE_DIR                 => 'FIELD_USE_ALLOW_ACTIVE_DIR';
Readonly our $FIELD_USE_ALLOW_QUERY                      => 'FIELD_USE_ALLOW_QUERY';
Readonly our $FIELD_USE_ALLOW_TRANSFER                   => 'FIELD_USE_ALLOW_TRANSFER';
Readonly our $FIELD_USE_ALLOW_UPDATE                     => 'FIELD_USE_ALLOW_UPDATE';
Readonly our $FIELD_USE_ALLOW_UPDATE_FORWARDING          => 'FIELD_USE_ALLOW_UPDATE_FORWARDING';
Readonly our $FIELD_USE_AUTHORITY                        => 'FIELD_USE_AUTHORITY';
Readonly our $FIELD_USE_BLACKLIST                        => 'FIELD_USE_BLACKLIST';
Readonly our $FIELD_USE_BOOTFILE                         => 'FIELD_USE_BOOTFILE';
Readonly our $FIELD_USE_BOOTSERVER                       => 'FIELD_USE_BOOTSERVER';
Readonly our $FIELD_USE_CHECK_NAMES_POLICY               => 'FIELD_USE_CHECK_NAMES_POLICY';
Readonly our $FIELD_USE_COPY_XFER_TO_NOTIFY              => 'FIELD_USE_COPY_XFER_TO_NOTIFY';
Readonly our $FIELD_USE_DDNS_DOMAINNAME                  => 'FIELD_USE_DDNS_DOMAINNAME';
Readonly our $FIELD_USE_DDNS_ENABLE_OPTION_FQDN          => 'FIELD_USE_DDNS_ENABLE_OPTION_FQDN';
Readonly our $FIELD_USE_DDNS_GENERATE_HOSTNAME           => 'FIELD_USE_DDNS_GENERATE_HOSTNAME';
Readonly our $FIELD_USE_DDNS_TTL                         => 'FIELD_USE_DDNS_TTL';
Readonly our $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES      => 'FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES';
Readonly our $FIELD_USE_DDNS_USE_OPTION81                => 'FIELD_USE_DDNS_USE_OPTION81';
Readonly our $FIELD_USE_DELEGATED_TTL                    => 'FIELD_USE_DELEGATED_TTL';
Readonly our $FIELD_USE_DENY_BOOTP                       => 'FIELD_USE_DENY_BOOTP';
Readonly our $FIELD_USE_DNS64                            => 'FIELD_USE_DNS64';
Readonly our $FIELD_USE_DNSSEC                           => 'FIELD_USE_DNSSEC';
Readonly our $FIELD_USE_DNSSEC_KEY_PARAMS                => 'FIELD_USE_DNSSEC_KEY_PARAMS';
Readonly our $FIELD_USE_DOMAIN_NAME                      => 'FIELD_USE_DOMAIN_NAME';
Readonly our $FIELD_USE_DOMAIN_NAME_SERVERS              => 'FIELD_USE_DOMAIN_NAME_SERVERS';
Readonly our $FIELD_USE_EMAIL_LIST                       => 'FIELD_USE_EMAIL_LIST';
Readonly our $FIELD_USE_ENABLE_DDNS                      => 'FIELD_USE_ENABLE_DDNS';
Readonly our $FIELD_USE_ENABLE_DHCP_THRESHOLDS           => 'FIELD_USE_ENABLE_DHCP_THRESHOLDS';
Readonly our $FIELD_USE_ENABLE_IFMAP_PUBLISHING          => 'FIELD_USE_ENABLE_IFMAP_PUBLISHING';
Readonly our $FIELD_USE_EXTERNAL_PRIMARY                 => 'FIELD_USE_EXTERNAL_PRIMARY';
Readonly our $FIELD_USE_FILTER_AAAA                      => 'FIELD_USE_FILTER_AAAA';
Readonly our $FIELD_USE_FOR_EA_INHERITANCE               => 'FIELD_USE_FOR_EA_INHERITANCE';
Readonly our $FIELD_USE_FORWARDERS                       => 'FIELD_USE_FORWARDERS';
Readonly our $FIELD_USE_GRID_ZONE_TIMER                  => 'FIELD_USE_GRID_ZONE_TIMER';
Readonly our $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS  => 'FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS';
Readonly our $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST  => 'FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST';
Readonly our $FIELD_USE_IMPORT_FROM                      => 'FIELD_USE_IMPORT_FROM';
Readonly our $FIELD_USE_KNOWN_CLIENTS                    => 'FIELD_USE_KNOWN_CLIENTS';
Readonly our $FIELD_USE_LAME_TTL                         => 'FIELD_USE_LAME_TTL';
Readonly our $FIELD_USE_LEASE_SCAVENGE_TIME              => 'FIELD_USE_LEASE_SCAVENGE_TIME';
Readonly our $FIELD_USE_NEXTSERVER                       => 'FIELD_USE_NEXTSERVER';
Readonly our $FIELD_USE_NOTIFY_DELAY                     => 'FIELD_USE_NOTIFY_DELAY';
Readonly our $FIELD_USE_NXDOMAIN_REDIRECT                => 'FIELD_USE_NXDOMAIN_REDIRECT';
Readonly our $FIELD_USE_OPTIONS                          => 'FIELD_USE_OPTIONS';
Readonly our $FIELD_USE_PREFERRED_LIFETIME               => 'FIELD_USE_PREFERRED_LIFETIME';
Readonly our $FIELD_USE_PXE_LEASE_TIME                   => 'FIELD_USE_PXE_LEASE_TIME';
Readonly our $FIELD_USE_RECORD_NAME_POLICY               => 'FIELD_USE_RECORD_NAME_POLICY';
Readonly our $FIELD_USE_RECURSION                        => 'FIELD_USE_RECURSION';
Readonly our $FIELD_USE_RECYCLE_LEASES                   => 'FIELD_USE_RECYCLE_LEASES';
Readonly our $FIELD_USE_ROOT_NAME_SERVER                 => 'FIELD_USE_ROOT_NAME_SERVER';
Readonly our $FIELD_USE_SOA_EMAIL                        => 'FIELD_USE_SOA_EMAIL';
Readonly our $FIELD_USE_SOA_MNAME                        => 'FIELD_USE_SOA_MNAME';
Readonly our $FIELD_USE_SORTLIST                         => 'FIELD_USE_SORTLIST';
Readonly our $FIELD_USE_TTL                              => 'FIELD_USE_TTL';
Readonly our $FIELD_USE_UNKNOWN_CLIENTS                  => 'FIELD_USE_UNKNOWN_CLIENTS';
Readonly our $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL      => 'FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL';
Readonly our $FIELD_USE_VALID_LIFETIME                   => 'FIELD_USE_VALID_LIFETIME';
Readonly our $FIELD_USE_ZONE_ASSOCIATIONS                => 'FIELD_USE_ZONE_ASSOCIATIONS';
Readonly our $FIELD_USERNAME                             => 'FIELD_USERNAME';
Readonly our $FIELD_USING_SRG_ASSOCIATIONS               => 'FIELD_USING_SRG_ASSOCIATIONS';
Readonly our $FIELD_VALID_LIFETIME                       => 'FIELD_VALID_LIFETIME';
Readonly our $FIELD_VARIABLE                             => 'FIELD_VARIABLE';
Readonly our $FIELD_VIEW                                 => 'FIELD_VIEW';
Readonly our $FIELD_WEIGHT                               => 'FIELD_WEIGHT';
Readonly our $FIELD_ZONE                                 => 'FIELD_ZONE';
Readonly our $FIELD_ZONE_ASSOCIATIONS                    => 'FIELD_ZONE_ASSOCIATIONS';
Readonly our $FIELD_ZONE_FORMAT                          => 'FIELD_ZONE_FORMAT';
Readonly our $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME        => 'FIELD_ZONE_NOT_QUERIED_ENABLED_TIME';

Readonly::Hash our %_TYPE_NAME => (
    $TYPE_BOOL              => $TYPE_BOOL,
    $TYPE_EXTATTRS          => $TYPE_EXTATTRS,
    $TYPE_INT               => $TYPE_INT,
    $TYPE_MEMBERS           => $TYPE_MEMBERS,
    $TYPE_MS_OPTIONS        => $TYPE_MS_OPTIONS,
    $TYPE_MS_SERVER         => $TYPE_MS_SERVER,
    $TYPE_STRING            => $TYPE_STRING,
    $TYPE_STRING_ARRAY      => $TYPE_STRING_ARRAY,
    $TYPE_TIMESTAMP         => $TYPE_TIMESTAMP,
    $TYPE_UINT              => $TYPE_UINT,
    $TYPE_UNKNOWN           => $TYPE_UNKNOWN,
    $TYPE_ZONE_ASSOCIATIONS => $TYPE_ZONE_ASSOCIATIONS,
);

Readonly::Hash our %_SEARCH_NAME => (
    $SEARCH_PARM_CASE_INSENSATIVE => ':=',
    $SEARCH_PARM_EQUAL            => '=',
    $SEARCH_PARM_GT               => '>',
    $SEARCH_PARM_NEGATIVE         => '!',
    $SEARCH_PARM_LT               => '<',
    $SEARCH_PARM_REGEX            => '~=',
);

Readonly::Hash our %_PARM_NAME => (
    $IB_MAX_RESULTS        => '_max_results',
    $IB_RETURN_FIELDS      => '_return_fields',
    $IB_RETURN_FIELDS_PLUS => '_return_fields%2B',
    $IB_RETURN_TYPE        => '_return_type',
);

Readonly::Hash our %_NAME_PARM => (
    '_max_results'    => $IB_MAX_RESULTS,
    '_return_fields'  => $IB_RETURN_FIELDS,
    '_return_fields+' => $IB_RETURN_FIELDS_PLUS,
    '_return_type'    => $IB_RETURN_TYPE,
);

Readonly::Hash our %_FIELD_NAME => (
    $FIELD_REF                                  => $_IB_REF,
    $FIELD_ACCESS_LIST                          => 'access_list',
    $FIELD_ADDRESS                              => 'address',
    $FIELD_ADDRESS_TYPE                         => 'address_type',
    $FIELD_AGENT_CIRCUIT_ID                     => 'agent_circuit_id',
    $FIELD_AGENT_REMOTE_ID                      => 'agent_remote_id',
    $FIELD_ALIASES                              => 'aliases',
    $FIELD_ALLOW_ACTIVE_DIR                     => 'allow_active_dir',
    $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE   => 'allow_gss_tsig_for_underscore_zone',
    $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES          => 'allow_gss_tsig_zone_updates',
    $FIELD_ALLOW_QUERY                          => 'allow_query',
    $FIELD_ALLOW_TRANSFER                       => 'allow_transfer',
    $FIELD_ALLOW_UPDATE                         => 'allow_update',
    $FIELD_ALLOW_UPDATE_FORWARDING              => 'allow_update_forwarding',
    $FIELD_ALWAYS_UPDATE_DNS                    => 'always_update_dns',
    $FIELD_APPROVAL_STATUS                      => 'approval_status',
    $FIELD_APPROVER                             => 'approver',
    $FIELD_APPROVER_COMMENT                     => 'approver_comment',
    $FIELD_AUTHENTICATION_TIME                  => 'authentication_time',
    $FIELD_AUTHORITY                            => 'authority',
    $FIELD_AUTO_CREATE_REVERSEZONE              => 'auto_create_reversezone',
    $FIELD_AUTOMATIC_RESTART                    => 'automatic_restart',
    $FIELD_BILLING_CLASS                        => 'billing_class',
    $FIELD_BINDING_STATE                        => 'binding_state',
    $FIELD_BLACKLIST_ACTION                     => 'blacklist_action',
    $FIELD_BLACKLIST_LOG_QUERY                  => 'blacklist_log_query',
    $FIELD_BLACKLIST_REDIRECT_ADDRESSES         => 'blacklist_redirect_addresses',
    $FIELD_BLACKLIST_REDIRECT_TTL               => 'blacklist_redirect_ttl',
    $FIELD_BLACKLIST_RULESETS                   => 'blacklist_rulesets',
    $FIELD_BOOTFILE                             => 'bootfile',
    $FIELD_BOOTSERVER                           => 'bootserver',
    $FIELD_CANONICAL                            => 'canonical',
    $FIELD_CHANGED_OBJECTS                      => 'changed_objects',
    $FIELD_CLIENT_HOSTNAME                      => 'client_hostname',
    $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO       => 'client_identifier_prepend_zero',
    $FIELD_CLTT                                 => 'cltt',
    $FIELD_COMMENT                              => 'comment',
    $FIELD_CONFIGURE_FOR_DHCP                   => 'configure_for_dhcp',
    $FIELD_CONFIGURE_FOR_DNS                    => 'configure_for_dns',
    $FIELD_CONTAINS_ADDRESS                     => 'contains_address',
    $FIELD_COPY_XFER_TO_NOTIFY                  => 'copy_xfer_to_notify',
    $FIELD_CREATE_PTR_FOR_BULK_HOSTS            => 'create_ptr_for_bulk_hosts',
    $FIELD_CREATE_PTR_FOR_HOSTS                 => 'create_ptr_for_hosts',
    $FIELD_CREATE_UNDERSCORE_ZONES              => 'create_underscore_zones',
    $FIELD_CUSTOM_ROOT_NAME_SERVERS             => 'custom_root_name_servers',
    $FIELD_DDNS_DOMAINNAME                      => 'ddns_domainname',
    $FIELD_DDNS_GENERATE_HOSTNAME               => 'ddns_generate_hostname',
    $FIELD_DDNS_HOSTNAME                        => 'ddns_hostname',
    $FIELD_DDNS_SERVER_ALWAYS_UPDATES           => 'ddns_server_always_updates',
    $FIELD_DDNS_TTL                             => 'ddns_ttl',
    $FIELD_DDNS_UPDATE_FIXED_ADDRESSES          => 'ddns_update_fixed_addresses',
    $FIELD_DDNS_USER_OPTION81                   => 'ddns_user_option81',
    $FIELD_DELEGATED_TTL                        => 'delegated_ttl',
    $FIELD_DELEGATE_TO                          => 'delegate_to',
    $FIELD_DENY_ALL_CLIENTS                     => 'deny_all_clients',
    $FIELD_DENY_BOOTP                           => 'deny_bootp',
    $FIELD_DHCP_CLIENT_IDENTIFIER               => 'dhcp_client_identifier',
    $FIELD_DHCP_STATUS                          => 'dhcp_status',
    $FIELD_DISABLE                              => 'disable',
    $FIELD_DISABLE_FORWARDING                   => 'disable_forwarding',
    $FIELD_DISCOVERED_DATA                      => 'discovered_data',
    $FIELD_DISPLAY_DOMAIN                       => 'display_domain',
    $FIELD_DNS64_ENABLED                        => 'dns64_enabled',
    $FIELD_DNS64_GROUPS                         => 'dns64_groups',
    $FIELD_DNS_ALIASES                          => 'dns_aliases',
    $FIELD_DNS_CANONICAL                        => 'dns_canonical',
    $FIELD_DNS_FQDN                             => 'dns_fqdn',
    $FIELD_DNS_MAIL_EXCHANGER                   => 'dns_mail_exchanger',
    $FIELD_DNS_NAME                             => 'dns_name',
    $FIELD_DNS_PTRDNAME                         => 'dns_ptrdname',
    $FIELD_DNSSEC_ENABLED                       => 'dnssec_enabled',
    $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED    => 'dnssec_expired_signatures_enabled',
    $FIELD_DNSSEC_KEY_PARAMS                    => 'dnssec_key_params',
    $FIELD_DNSSEC_TRUSTED_KEYS                  => 'dnssec_trusted_keys',
    $FIELD_DNSSEC_VALIDATION_ENABLED            => 'dnssec_validation_enabled',
    $FIELD_DNS_SOA_EMAIL                        => 'dns_soa_email',
    $FIELD_DNS_SOA_MNAME                        => 'dns_soa_mname',
    $FIELD_DNS_STATUS                           => 'dns_status',
    $FIELD_DNS_TARGET                           => 'dns_target',
    $FIELD_DO_HOST_ABSTRACTION                  => 'do_host_abstraction',
    $FIELD_DOMAIN_NAME                          => 'domain_name',
    $FIELD_DOMAIN_NAME_SERVERS                  => 'domain_name_servers',
    $FIELD_DUID                                 => 'duid',
    $FIELD_EFFECTIVE_CHECK_NAMES_POLICY         => 'effective_check_names_policy',
    $FIELD_EFFECTIVE_RECORD_NAME_POLICY         => 'effective_record_name_policy',
    $FIELD_EMAIL_LIST                           => 'email_list',
    $FIELD_ENABLE_BLACKLIST                     => 'enable_blacklist',
    $FIELD_ENABLE_DDNS                          => 'enable_ddns',
    $FIELD_ENABLE_DHCP_THRESHOLDS               => 'enable_dhcp_thresholds',
    $FIELD_ENABLE_EMAIL_WARNINGS                => 'enable_email_warnings',
    $FIELD_ENABLE_IFMAP_PUBLISHING              => 'enable_ifmap_publishing',
    $FIELD_ENABLE_PXE_LEASE_TIME                => 'enable_pxe_lease_time',
    $FIELD_ENABLE_RFC2317_EXCLUSION             => 'enable_rfc2317_exclusion',
    $FIELD_ENABLE_SNMP_WARNINGS                 => 'enable_snmp_warnings',
    $FIELD_END_ADDR                             => 'end_addr',
    $FIELD_ENDS                                 => 'ends',
    $FIELD_EXCLUDE                              => 'exclude',
    $FIELD_EXECUTE_NOW                          => 'execute_now',
    $FIELD_EXECUTION_STATUS                     => 'execution_status',
    $FIELD_EXECUTION_TIME                       => 'execution_time',
    $FIELD_EXPIRATION_TIME                      => 'expiration_time',
    $FIELD_EXPLODED_ACCESS_LIST                 => 'exploded_access_list',
    $FIELD_EXTATTRS                             => 'extattrs',
    $FIELD_EXTERNAL_PRIMARIES                   => 'external_primaries',
    $FIELD_EXTERNAL_SECONDARIES                 => 'external_secondaries',
    $FIELD_FAILOVER_ASSOCIATION                 => 'failover_association',
    $FIELD_FILTER                               => 'filter',
    $FIELD_FILTER_AAAA                          => 'filter_aaaa',
    $FIELD_FILTER_AAAA_LIST                     => 'filter_aaaa_list',
    $FIELD_FINGERPRINT                          => 'fingerprint',
    $FIELD_FINGERPRINT_FILTER_RULES             => 'fingerprint_filter_rules',
    $FIELD_FORWARDERS                           => 'forwarders',
    $FIELD_FORWARDERS_ONLY                      => 'forwarders_only',
    $FIELD_FORWARDING_SERVERS                   => 'forwarding_servers',
    $FIELD_FORWARD_ONLY                         => 'forward_only',
    $FIELD_FORWARD_TO                           => 'forward_to',
    $FIELD_FQDN                                 => 'fqdn',
    $FIELD_GRID_PRIMARY                         => 'grid_primary',
    $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D => 'grid_primary_shared_with_ms_parent_d',
    $FIELD_GRID_SECONDARIES                     => 'grid_secondaries',
    $FIELD_GUEST_CUSTOM_FIELD1                  => 'guest_custom_field1',
    $FIELD_GUEST_CUSTOM_FIELD2                  => 'guest_custom_field2',
    $FIELD_GUEST_CUSTOM_FIELD3                  => 'guest_custom_field3',
    $FIELD_GUEST_CUSTOM_FIELD4                  => 'guest_custom_field4',
    $FIELD_GUEST_EMAIL                          => 'guest_email',
    $FIELD_GUEST_FIRST_NAME                     => 'guest_first_name',
    $FIELD_GUEST_LAST_NAME                      => 'guest_last_name',
    $FIELD_GUEST_MIDDLE_NAME                    => 'guest_middle_name',
    $FIELD_GUEST_PHONE                          => 'guest_phone',
    $FIELD_HARDWARE                             => 'hardware',
    $FIELD_HIGH_WATER_MARK                      => 'high_water_mark',
    $FIELD_HIGH_WATER_MARK_RESET                => 'high_water_mark_reset',
    $FIELD_HOST                                 => 'host',
    $FIELD_HOST_NAME                            => 'host_name',
    $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS      => 'ignore_client_requested_options',
    $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST      => 'ignore_dhcp_option_list_request',
    $FIELD_IMPORT_FROM                          => 'import_from',
    $FIELD_IP_ADDRESS                           => 'ip_address',
    $FIELD_IPV4ADDR                             => 'ipv4addr',
    $FIELD_IPV4ADDRS                            => 'ipv4addrs',
    $FIELD_IPV4_ADDRESS                         => 'ipv4_address',
    $FIELD_IPV6ADDR                             => 'ipv6addr',
    $FIELD_IPV6ADDRS                            => 'ipv6addrs',
    $FIELD_IPV6PREFIX                           => 'ipv6prefix',
    $FIELD_IPV6PREFIX_BITS                      => 'ipv6prefix_bits',
    $FIELD_IPV6_ADDRESS                         => 'ipv6_address',
    $FIELD_IPV6_DUID                            => 'ipv6_duid',
    $FIELD_IPV6_END_PREFIX                      => 'ipv6_end_prefix',
    $FIELD_IPV6_IAID                            => 'ipv6_iaid',
    $FIELD_IPV6_PREFERRED_LIFETIME              => 'ipv6_preferred_lifetime',
    $FIELD_IPV6_PREFIX                          => 'ipv6_prefix',
    $FIELD_IPV6_PREFIX_BITS                     => 'ipv6_prefix_bits',
    $FIELD_IPV6_START_PREFIX                    => 'ipv6_start_prefix',
    $FIELD_IS_CONFLICT                          => 'is_conflict',
    $FIELD_IS_DEFAULT                           => 'is_default',
    $FIELD_IS_DNSSEC_ENABLED                    => 'is_dnssec_enabled',
    $FIELD_IS_DNSSEC_SIGNED                     => 'is_dnssec_signed',
    $FIELD_IS_REGISTERED_USER                   => 'is_registered_user',
    $FIELD_IS_SPLIT_SCOPE                       => 'is_split_scope',
    $FIELD_KNOWN_CLIENTS                        => 'known_clients',
    $FIELD_LAME_TTL                             => 'lame_ttl',
    $FIELD_LAST_QUERIED                         => 'last_queried',
    $FIELD_LEASE_SCAVENGE_TIME                  => 'lease_scavenge_time',
    $FIELD_LEASE_STATE                          => 'lease_state',
    $FIELD_LOCKED                               => 'locked',
    $FIELD_LOCKED_BY                            => 'locked_by',
    $FIELD_LOGIC_FILTER_RULES                   => 'logic_filter_rules',
    $FIELD_LOW_WATER_MARK                       => 'low_water_mark',
    $FIELD_LOW_WATER_MARK_RESET                 => 'low_water_mark_reset',
    $FIELD_MAC                                  => 'mac',
    $FIELD_MAC_ADDRESS                          => 'mac_address',
    $FIELD_MAC_FILTER_RULES                     => 'mac_filter_rules',
    $FIELD_MAIL_EXCHANGER                       => 'mail_exchanger',
    $FIELD_MASK_PREFIX                          => 'mask_prefix',
    $FIELD_MATCH_CLIENT                         => 'match_client',
    $FIELD_MATCH_CLIENTS                        => 'match_clients',
    $FIELD_MATCH_DESTINATIONS                   => 'match_destinations',
    $FIELD_MEMBER                               => 'member',
    $FIELD_MEMBERS                              => 'members',
    $FIELD_MS_AD_INTEGRATED                     => 'ms_ad_integrated',
    $FIELD_MS_ALLOW_TRANSFER                    => 'ms_allow_transfer',
    $FIELD_MS_ALLOW_TRANSFER_MODE               => 'ms_allow_transfer_mode',
    $FIELD_MS_DDNS_MODE                         => 'ms_ddns_mode',
    $FIELD_MS_MANAGED                           => 'ms_managed',
    $FIELD_MS_OPTIONS                           => 'ms_options',
    $FIELD_MS_PRIMARIES                         => 'ms_primaries',
    $FIELD_MS_READ_ONLY                         => 'ms_read_only',
    $FIELD_MS_SECONDARIES                       => 'ms_secondaries',
    $FIELD_MS_SERVER                            => 'ms_server',
    $FIELD_MS_SYNC_MASTER_NAME                  => 'ms_sync_master_name',
    $FIELD_NAC_FILTER_RULES                     => 'nac_filter_rules',
    $FIELD_NAME                                 => 'name',
    $FIELD_NAMES                                => 'names',
    $FIELD_NETMASK                              => 'netmask',
    $FIELD_NETWORK                              => 'network',
    $FIELD_NETWORK_ASSOCIATIONS                 => 'network_associations',
    $FIELD_NETWORK_CONTAINER                    => 'network_container',
    $FIELD_NETWORK_VIEW                         => 'network_view',
    $FIELD_NEVER_ENDS                           => 'never_ends',
    $FIELD_NEVER_EXPIRES                        => 'never_expires',
    $FIELD_NEVER_STARTS                         => 'never_starts',
    $FIELD_NEXT_BINDING_STATE                   => 'next_binding_state',
    $FIELD_NEXTSERVER                           => 'nextserver',
    $FIELD_NOTIFY_DELAY                         => 'notify_delay',
    $FIELD_NS_GROUP                             => 'ns_group',
    $FIELD_NXDOMAIN_LOG_QUERY                   => 'nxdomain_log_query',
    $FIELD_NXDOMAIN_REDIRECT                    => 'nxdomain_redirect',
    $FIELD_NXDOMAIN_REDIRECT_ADDRESSES          => 'nxdomain_redirect_addresses',
    $FIELD_NXDOMAIN_REDIRECT_TTL                => 'nxdomain_redirect_ttl',
    $FIELD_NXDOMAIN_RULESETS                    => 'nxdomain_rulesets',
    $FIELD_OBJECTS                              => 'objects',
    $FIELD_ON_COMMIT                            => 'on_commit',
    $FIELD_ON_EXPIRY                            => 'on_expiry',
    $FIELD_ON_RELEASE                           => 'on_release',
    $FIELD_OPTION                               => 'option',
    $FIELD_OPTION_FILTER_RULES                  => 'option_filter_rules',
    $FIELD_OPTIONS                              => 'options',
    $FIELD_PARENT                               => 'parent',
    $FIELD_PORT                                 => 'port',
    $FIELD_PREFERENCE                           => 'preference',
    $FIELD_PREFERRED_LIFETIME                   => 'preferred_lifetime',
    $FIELD_PREFIX                               => 'prefix',
    $FIELD_PRIMARY_TYPE                         => 'primary_type',
    $FIELD_PRIORITY                             => 'priority',
    $FIELD_PROTOCOL                             => 'protocol',
    $FIELD_PTRDNAME                             => 'ptrdname',
    $FIELD_PXE_LEASE_TIME                       => 'pxe_lease_time',
    $FIELD_RECORD_NAME_POLICY                   => 'record_name_policy',
    $FIELD_RECORDS_MONITORED                    => 'records_monitored',
    $FIELD_RECURSION                            => 'recursion',
    $FIELD_RECYCLE_LEASES                       => 'recycle_leases',
    $FIELD_RELAY_AGENT_FILTER_RULES             => 'relay_agent_filter_rules',
    $FIELD_REPORTING_STATUS                     => 'reporting_status',
    $FIELD_RESERVED_FOR_INFOBLOX                => 'reserved_for_infoblox',
    $FIELD_ROOT_NAME_SERVER_TYPE                => 'root_name_server_type',
    $FIELD_RR_NOT_QUERIED_ENABLED_TIME          => 'rr_not_queried_enabled_time',
    $FIELD_RRSET_ORDER                          => 'rrset_order',
    $FIELD_SCHEDULED_TIME                       => 'scheduled_time',
    $FIELD_SERVED_BY                            => 'served_by',
    $FIELD_SERVER_ASSOCIATION_TYPE              => 'server_association_type',
    $FIELD_SERVER_HOST_NAME                     => 'server_host_name',
    $FIELD_SET_SOA_SERIAL_NUMBER                => 'set_soa_serial_number',
    $FIELD_SHARED_NETWORK_NAME                  => 'shared_network_name',
    $FIELD_SOA_DEFAULT_TTL                      => 'soa_default_ttl',
    $FIELD_SOA_EMAIL                            => 'soa_email',
    $FIELD_SOA_EXPIRE                           => 'soa_expire',
    $FIELD_SOA_MNAME                            => 'soa_mname',
    $FIELD_SOA_NEGATIVE_TTL                     => 'soa_negative_ttl',
    $FIELD_SOA_REFRESH                          => 'soa_refresh',
    $FIELD_SOA_RETRY                            => 'soa_retry',
    $FIELD_SOA_SERIAL_NUMBER                    => 'soa_serial_number',
    $FIELD_SORTLIST                             => 'sortlist',
    $FIELD_SPLIT_MEMBER                         => 'split_member',
    $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT        => 'split_scope_exclusion_percent',
    $FIELD_SRGS                                 => 'srgs',
    $FIELD_START_ADDR                           => 'start_addr',
    $FIELD_STARTS                               => 'starts',
    $FIELD_STATUS                               => 'status',
    $FIELD_STUB_FROM                            => 'stub_from',
    $FIELD_STUB_MEMBERS                         => 'stub_members',
    $FIELD_STUB_MSSERVERS                       => 'stub_msservers',
    $FIELD_SUBMITTER                            => 'submitter',
    $FIELD_SUBMITTER_COMMENT                    => 'submitter_comment',
    $FIELD_SUBMIT_TIME                          => 'submit_time',
    $FIELD_TARGET                               => 'target',
    $FIELD_TASK_ID                              => 'task_id',
    $FIELD_TEMPLATE                             => 'template',
    $FIELD_TEXT                                 => 'text',
    $FIELD_TICKET_NUMBER                        => 'ticket_number',
    $FIELD_TSFP                                 => 'tsfp',
    $FIELD_TSTP                                 => 'tstp',
    $FIELD_TTL                                  => 'ttl',
    $FIELD_TYPES                                => 'types',
    $FIELD_UID                                  => 'uid',
    $FIELD_UNKNOWN_CLIENTS                      => 'unknown_clients',
    $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL          => 'update_dns_on_lease_renewal',
    $FIELD_UPDATE_FORWARDING                    => 'update_forwarding',
    $FIELD_USAGE                                => 'usage',
    $FIELD_USE_ALLOW_ACTIVE_DIR                 => 'use_allow_active_dir',
    $FIELD_USE_ALLOW_QUERY                      => 'use_allow_query',
    $FIELD_USE_ALLOW_TRANSFER                   => 'use_allow_transfer',
    $FIELD_USE_ALLOW_UPDATE                     => 'use_allow_update',
    $FIELD_USE_ALLOW_UPDATE_FORWARDING          => 'use_allow_update_forwarding',
    $FIELD_USE_AUTHORITY                        => 'use_authority',
    $FIELD_USE_BLACKLIST                        => 'use_blacklist',
    $FIELD_USE_BOOTFILE                         => 'use_bootfile',
    $FIELD_USE_BOOTSERVER                       => 'use_bootserver',
    $FIELD_USE_CHECK_NAMES_POLICY               => 'use_check_names_policy',
    $FIELD_USE_COPY_XFER_TO_NOTIFY              => 'use_copy_xfer_to_notify',
    $FIELD_USE_DDNS_DOMAINNAME                  => 'use_ddns_domainname',
    $FIELD_USE_DDNS_ENABLE_OPTION_FQDN          => 'use_ddns_enable_option_fqdn',
    $FIELD_USE_DDNS_GENERATE_HOSTNAME           => 'use_ddns_generate_hostname',
    $FIELD_USE_DDNS_TTL                         => 'use_ddns_ttl',
    $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES      => 'use_ddns_update_fixed_addresses',
    $FIELD_USE_DDNS_USE_OPTION81                => 'use_ddns_use_option81',
    $FIELD_USE_DELEGATED_TTL                    => 'use_delegated_ttl',
    $FIELD_USE_DENY_BOOTP                       => 'use_deny_bootp',
    $FIELD_USE_DNS64                            => 'use_dns64',
    $FIELD_USE_DNSSEC                           => 'use_dnssec',
    $FIELD_USE_DNSSEC_KEY_PARAMS                => 'use_dnssec_key_params',
    $FIELD_USE_DOMAIN_NAME                      => 'use_domain_name',
    $FIELD_USE_DOMAIN_NAME_SERVERS              => 'use_domain_name_servers',
    $FIELD_USE_EMAIL_LIST                       => 'use_email_list',
    $FIELD_USE_ENABLE_DDNS                      => 'use_enable_ddns',
    $FIELD_USE_ENABLE_DHCP_THRESHOLDS           => 'use_enable_dhcp_thresholds',
    $FIELD_USE_ENABLE_IFMAP_PUBLISHING          => 'use_enable_ifmap_publishing',
    $FIELD_USE_EXTERNAL_PRIMARY                 => 'use_external_primary',
    $FIELD_USE_FILTER_AAAA                      => 'use_filter_aaaa',
    $FIELD_USE_FOR_EA_INHERITANCE               => 'use_for_ea_inheritance',
    $FIELD_USE_FORWARDERS                       => 'use_forwarders',
    $FIELD_USE_GRID_ZONE_TIMER                  => 'use_grid_zone_timer',
    $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS  => 'use_ignore_client_requested_options',
    $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST  => 'use_ignore_dhcp_option_list_request',
    $FIELD_USE_IMPORT_FROM                      => 'use_import_from',
    $FIELD_USE_KNOWN_CLIENTS                    => 'use_known_clients',
    $FIELD_USE_LAME_TTL                         => 'use_lame_ttl',
    $FIELD_USE_LEASE_SCAVENGE_TIME              => 'use_lease_scavenge_time',
    $FIELD_USE_NEXTSERVER                       => 'use_nextserver',
    $FIELD_USE_NOTIFY_DELAY                     => 'use_notify_delay',
    $FIELD_USE_NXDOMAIN_REDIRECT                => 'use_nxdomain_redirect',
    $FIELD_USE_OPTIONS                          => 'use_options',
    $FIELD_USE_PREFERRED_LIFETIME               => 'use_preferred_lifetime',
    $FIELD_USE_PXE_LEASE_TIME                   => 'use_pxe_lease_time',
    $FIELD_USE_RECORD_NAME_POLICY               => 'use_record_name_policy',
    $FIELD_USE_RECURSION                        => 'use_recursion',
    $FIELD_USE_RECYCLE_LEASES                   => 'use_recycle_leases',
    $FIELD_USERNAME                             => 'username',
    $FIELD_USE_ROOT_NAME_SERVER                 => 'use_root_name_server',
    $FIELD_USE_SOA_EMAIL                        => 'use_soa_email',
    $FIELD_USE_SOA_MNAME                        => 'use_soa_mname',
    $FIELD_USE_SORTLIST                         => 'use_sortlist',
    $FIELD_USE_TTL                              => 'use_ttl',
    $FIELD_USE_UNKNOWN_CLIENTS                  => 'use_unknown_clients',
    $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL      => 'use_update_dns_on_lease_renewal',
    $FIELD_USE_VALID_LIFETIME                   => 'use_valid_lifetime',
    $FIELD_USE_ZONE_ASSOCIATIONS                => 'use_zone_associations',
    $FIELD_USING_SRG_ASSOCIATIONS               => 'using_srg_associations',
    $FIELD_VALID_LIFETIME                       => 'valid_lifetime',
    $FIELD_VARIABLE                             => 'variable',
    $FIELD_VIEW                                 => 'view',
    $FIELD_WEIGHT                               => 'weight',
    $FIELD_ZONE                                 => 'zone',
    $FIELD_ZONE_ASSOCIATIONS                    => 'zone_associations',
    $FIELD_ZONE_FORMAT                          => 'zone_format',
    $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME        => 'zone_not_queried_enabled_time',
);

Readonly::Hash our %_NAME_FIELD => (
    $_IB_REF                               => $FIELD_REF,
    'access_list'                          => $FIELD_ACCESS_LIST,
    'address'                              => $FIELD_ADDRESS,
    'address_type'                         => $FIELD_ADDRESS_TYPE,
    'agent_circuit_id'                     => $FIELD_AGENT_CIRCUIT_ID,
    'agent_remote_id'                      => $FIELD_AGENT_REMOTE_ID,
    'aliases'                              => $FIELD_ALIASES,
    'allow_active_dir'                     => $FIELD_ALLOW_ACTIVE_DIR,
    'allow_gss_tsig_for_underscore_zone'   => $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE,
    'allow_gss_tsig_zone_updates'          => $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES,
    'allow_query'                          => $FIELD_ALLOW_QUERY,
    'allow_transfer'                       => $FIELD_ALLOW_TRANSFER,
    'allow_update'                         => $FIELD_ALLOW_UPDATE,
    'allow_update_forwarding'              => $FIELD_ALLOW_UPDATE_FORWARDING,
    'always_update_dns'                    => $FIELD_ALWAYS_UPDATE_DNS,
    'approval_status'                      => $FIELD_APPROVAL_STATUS,
    'approver'                             => $FIELD_APPROVER,
    'approver_comment'                     => $FIELD_APPROVER_COMMENT,
    'authentication_time'                  => $FIELD_AUTHENTICATION_TIME,
    'authority'                            => $FIELD_AUTHORITY,
    'auto_create_reversezone'              => $FIELD_AUTO_CREATE_REVERSEZONE,
    'automatic_restart'                    => $FIELD_AUTOMATIC_RESTART,
    'billing_class'                        => $FIELD_BILLING_CLASS,
    'binding_state'                        => $FIELD_BINDING_STATE,
    'blacklist_action'                     => $FIELD_BLACKLIST_ACTION,
    'blacklist_log_query'                  => $FIELD_BLACKLIST_LOG_QUERY,
    'blacklist_redirect_addresses'         => $FIELD_BLACKLIST_REDIRECT_ADDRESSES,
    'blacklist_redirect_ttl'               => $FIELD_BLACKLIST_REDIRECT_TTL,
    'blacklist_rulesets'                   => $FIELD_BLACKLIST_RULESETS,
    'bootfile'                             => $FIELD_BOOTFILE,
    'bootserver'                           => $FIELD_BOOTSERVER,
    'canonical'                            => $FIELD_CANONICAL,
    'changed_objects'                      => $FIELD_CHANGED_OBJECTS,
    'client_hostname'                      => $FIELD_CLIENT_HOSTNAME,
    'client_identifier_prepend_zero'       => $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO,
    'cltt'                                 => $FIELD_CLTT,
    'comment'                              => $FIELD_COMMENT,
    'configure_for_dhcp'                   => $FIELD_CONFIGURE_FOR_DHCP,
    'configure_for_dns'                    => $FIELD_CONFIGURE_FOR_DNS,
    'contains_address'                     => $FIELD_CONTAINS_ADDRESS,
    'copy_xfer_to_notify'                  => $FIELD_COPY_XFER_TO_NOTIFY,
    'create_ptr_for_bulk_hosts'            => $FIELD_CREATE_PTR_FOR_BULK_HOSTS,
    'create_ptr_for_hosts'                 => $FIELD_CREATE_PTR_FOR_HOSTS,
    'create_underscore_zones'              => $FIELD_CREATE_UNDERSCORE_ZONES,
    'custom_root_name_servers'             => $FIELD_CUSTOM_ROOT_NAME_SERVERS,
    'ddns_domainname'                      => $FIELD_DDNS_DOMAINNAME,
    'ddns_generate_hostname'               => $FIELD_DDNS_GENERATE_HOSTNAME,
    'ddns_hostname'                        => $FIELD_DDNS_HOSTNAME,
    'ddns_server_always_updates'           => $FIELD_DDNS_SERVER_ALWAYS_UPDATES,
    'ddns_ttl'                             => $FIELD_DDNS_TTL,
    'ddns_update_fixed_addresses'          => $FIELD_DDNS_UPDATE_FIXED_ADDRESSES,
    'ddns_user_option81'                   => $FIELD_DDNS_USER_OPTION81,
    'delegated_ttl'                        => $FIELD_DELEGATED_TTL,
    'delegate_to'                          => $FIELD_DELEGATE_TO,
    'deny_all_clients'                     => $FIELD_DENY_ALL_CLIENTS,
    'deny_bootp'                           => $FIELD_DENY_BOOTP,
    'dhcp_client_identifier'               => $FIELD_DHCP_CLIENT_IDENTIFIER,
    'dhcp_status'                          => $FIELD_DHCP_STATUS,
    'disable'                              => $FIELD_DISABLE,
    'disable_forwarding'                   => $FIELD_DISABLE_FORWARDING,
    'discovered_data'                      => $FIELD_DISCOVERED_DATA,
    'display_domain'                       => $FIELD_DISPLAY_DOMAIN,
    'dns64_enabled'                        => $FIELD_DNS64_ENABLED,
    'dns64_groups'                         => $FIELD_DNS64_GROUPS,
    'dns_aliases'                          => $FIELD_DNS_ALIASES,
    'dns_canonical'                        => $FIELD_DNS_CANONICAL,
    'dns_fqdn'                             => $FIELD_DNS_FQDN,
    'dns_mail_exchanger'                   => $FIELD_DNS_MAIL_EXCHANGER,
    'dns_name'                             => $FIELD_DNS_NAME,
    'dns_ptrdname'                         => $FIELD_DNS_PTRDNAME,
    'dnssec_enabled'                       => $FIELD_DNSSEC_ENABLED,
    'dnssec_expired_signatures_enabled'    => $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED,
    'dnssec_key_params'                    => $FIELD_DNSSEC_KEY_PARAMS,
    'dnssec_trusted_keys'                  => $FIELD_DNSSEC_TRUSTED_KEYS,
    'dnssec_validation_enabled'            => $FIELD_DNSSEC_VALIDATION_ENABLED,
    'dns_soa_email'                        => $FIELD_DNS_SOA_EMAIL,
    'dns_soa_mname'                        => $FIELD_DNS_SOA_MNAME,
    'dns_status'                           => $FIELD_DNS_STATUS,
    'dns_target'                           => $FIELD_DNS_TARGET,
    'do_host_abstraction'                  => $FIELD_DO_HOST_ABSTRACTION,
    'domain_name'                          => $FIELD_DOMAIN_NAME,
    'domain_name_servers'                  => $FIELD_DOMAIN_NAME_SERVERS,
    'duid'                                 => $FIELD_DUID,
    'effective_check_names_policy'         => $FIELD_EFFECTIVE_CHECK_NAMES_POLICY,
    'effective_record_name_policy'         => $FIELD_EFFECTIVE_RECORD_NAME_POLICY,
    'email_list'                           => $FIELD_EMAIL_LIST,
    'enable_blacklist'                     => $FIELD_ENABLE_BLACKLIST,
    'enable_ddns'                          => $FIELD_ENABLE_DDNS,
    'enable_dhcp_thresholds'               => $FIELD_ENABLE_DHCP_THRESHOLDS,
    'enable_email_warnings'                => $FIELD_ENABLE_EMAIL_WARNINGS,
    'enable_ifmap_publishing'              => $FIELD_ENABLE_IFMAP_PUBLISHING,
    'enable_pxe_lease_time'                => $FIELD_ENABLE_PXE_LEASE_TIME,
    'enable_rfc2317_exclusion'             => $FIELD_ENABLE_RFC2317_EXCLUSION,
    'enable_snmp_warnings'                 => $FIELD_ENABLE_SNMP_WARNINGS,
    'end_addr'                             => $FIELD_END_ADDR,
    'ends'                                 => $FIELD_ENDS,
    'exclude'                              => $FIELD_EXCLUDE,
    'execute_now'                          => $FIELD_EXECUTE_NOW,
    'execution_status'                     => $FIELD_EXECUTION_STATUS,
    'execution_time'                       => $FIELD_EXECUTION_TIME,
    'expiration_time'                      => $FIELD_EXPIRATION_TIME,
    'exploded_access_list'                 => $FIELD_EXPLODED_ACCESS_LIST,
    'extattrs'                             => $FIELD_EXTATTRS,
    'external_primaries'                   => $FIELD_EXTERNAL_PRIMARIES,
    'external_secondaries'                 => $FIELD_EXTERNAL_SECONDARIES,
    'failover_association'                 => $FIELD_FAILOVER_ASSOCIATION,
    'filter'                               => $FIELD_FILTER,
    'filter_aaaa'                          => $FIELD_FILTER_AAAA,
    'filter_aaaa_list'                     => $FIELD_FILTER_AAAA_LIST,
    'fingerprint'                          => $FIELD_FINGERPRINT,
    'fingerprint_filter_rules'             => $FIELD_FINGERPRINT_FILTER_RULES,
    'forwarders'                           => $FIELD_FORWARDERS,
    'forwarders_only'                      => $FIELD_FORWARDERS_ONLY,
    'forwarding_servers'                   => $FIELD_FORWARDING_SERVERS,
    'forward_only'                         => $FIELD_FORWARD_ONLY,
    'forward_to'                           => $FIELD_FORWARD_TO,
    'fqdn'                                 => $FIELD_FQDN,
    'grid_primary'                         => $FIELD_GRID_PRIMARY,
    'grid_primary_shared_with_ms_parent_d' => $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D,
    'grid_secondaries'                     => $FIELD_GRID_SECONDARIES,
    'guest_custom_field1'                  => $FIELD_GUEST_CUSTOM_FIELD1,
    'guest_custom_field2'                  => $FIELD_GUEST_CUSTOM_FIELD2,
    'guest_custom_field3'                  => $FIELD_GUEST_CUSTOM_FIELD3,
    'guest_custom_field4'                  => $FIELD_GUEST_CUSTOM_FIELD4,
    'guest_email'                          => $FIELD_GUEST_EMAIL,
    'guest_first_name'                     => $FIELD_GUEST_FIRST_NAME,
    'guest_last_name'                      => $FIELD_GUEST_LAST_NAME,
    'guest_middle_name'                    => $FIELD_GUEST_MIDDLE_NAME,
    'guest_phone'                          => $FIELD_GUEST_PHONE,
    'hardware'                             => $FIELD_HARDWARE,
    'high_water_mark'                      => $FIELD_HIGH_WATER_MARK,
    'high_water_mark_reset'                => $FIELD_HIGH_WATER_MARK_RESET,
    'host'                                 => $FIELD_HOST,
    'host_name'                            => $FIELD_HOST_NAME,
    'ignore_client_requested_options'      => $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS,
    'ignore_dhcp_option_list_request'      => $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST,
    'import_from'                          => $FIELD_IMPORT_FROM,
    'ip_address'                           => $FIELD_IP_ADDRESS,
    'ipv4addr'                             => $FIELD_IPV4ADDR,
    'ipv4addrs'                            => $FIELD_IPV4ADDRS,
    'ipv4_address'                         => $FIELD_IPV4_ADDRESS,
    'ipv6addr'                             => $FIELD_IPV6ADDR,
    'ipv6addrs'                            => $FIELD_IPV6ADDRS,
    'ipv6prefix'                           => $FIELD_IPV6PREFIX,
    'ipv6prefix_bits'                      => $FIELD_IPV6PREFIX_BITS,
    'ipv6_address'                         => $FIELD_IPV6_ADDRESS,
    'ipv6_duid'                            => $FIELD_IPV6_DUID,
    'ipv6_end_prefix'                      => $FIELD_IPV6_END_PREFIX,
    'ipv6_iaid'                            => $FIELD_IPV6_IAID,
    'ipv6_preferred_lifetime'              => $FIELD_IPV6_PREFERRED_LIFETIME,
    'ipv6_prefix'                          => $FIELD_IPV6_PREFIX,
    'ipv6_prefix_bits'                     => $FIELD_IPV6_PREFIX_BITS,
    'ipv6_start_prefix'                    => $FIELD_IPV6_START_PREFIX,
    'is_conflict'                          => $FIELD_IS_CONFLICT,
    'is_default'                           => $FIELD_IS_DEFAULT,
    'is_dnssec_enabled'                    => $FIELD_IS_DNSSEC_ENABLED,
    'is_dnssec_signed'                     => $FIELD_IS_DNSSEC_SIGNED,
    'is_registered_user'                   => $FIELD_IS_REGISTERED_USER,
    'is_split_scope'                       => $FIELD_IS_SPLIT_SCOPE,
    'known_clients'                        => $FIELD_KNOWN_CLIENTS,
    'lame_ttl'                             => $FIELD_LAME_TTL,
    'last_queried'                         => $FIELD_LAST_QUERIED,
    'lease_scavenge_time'                  => $FIELD_LEASE_SCAVENGE_TIME,
    'lease_state'                          => $FIELD_LEASE_STATE,
    'locked'                               => $FIELD_LOCKED,
    'locked_by'                            => $FIELD_LOCKED_BY,
    'logic_filter_rules'                   => $FIELD_LOGIC_FILTER_RULES,
    'low_water_mark'                       => $FIELD_LOW_WATER_MARK,
    'low_water_mark_reset'                 => $FIELD_LOW_WATER_MARK_RESET,
    'mac'                                  => $FIELD_MAC,
    'mac_address'                          => $FIELD_MAC_ADDRESS,
    'mac_filter_rules'                     => $FIELD_MAC_FILTER_RULES,
    'mail_exchanger'                       => $FIELD_MAIL_EXCHANGER,
    'mask_prefix'                          => $FIELD_MASK_PREFIX,
    'match_client'                         => $FIELD_MATCH_CLIENT,
    'match_clients'                        => $FIELD_MATCH_CLIENTS,
    'match_destinations'                   => $FIELD_MATCH_DESTINATIONS,
    'member'                               => $FIELD_MEMBER,
    'members'                              => $FIELD_MEMBERS,
    'ms_ad_integrated'                     => $FIELD_MS_AD_INTEGRATED,
    'ms_allow_transfer'                    => $FIELD_MS_ALLOW_TRANSFER,
    'ms_allow_transfer_mode'               => $FIELD_MS_ALLOW_TRANSFER_MODE,
    'ms_ddns_mode'                         => $FIELD_MS_DDNS_MODE,
    'ms_managed'                           => $FIELD_MS_MANAGED,
    'ms_options'                           => $FIELD_MS_OPTIONS,
    'ms_primaries'                         => $FIELD_MS_PRIMARIES,
    'ms_read_only'                         => $FIELD_MS_READ_ONLY,
    'ms_secondaries'                       => $FIELD_MS_SECONDARIES,
    'ms_server'                            => $FIELD_MS_SERVER,
    'ms_sync_master_name'                  => $FIELD_MS_SYNC_MASTER_NAME,
    'nac_filter_rules'                     => $FIELD_NAC_FILTER_RULES,
    'name'                                 => $FIELD_NAME,
    'names'                                => $FIELD_NAMES,
    'netmask'                              => $FIELD_NETMASK,
    'network'                              => $FIELD_NETWORK,
    'network_associations'                 => $FIELD_NETWORK_ASSOCIATIONS,
    'network_container'                    => $FIELD_NETWORK_CONTAINER,
    'network_view'                         => $FIELD_NETWORK_VIEW,
    'never_ends'                           => $FIELD_NEVER_ENDS,
    'never_expires'                        => $FIELD_NEVER_EXPIRES,
    'never_starts'                         => $FIELD_NEVER_STARTS,
    'next_binding_state'                   => $FIELD_NEXT_BINDING_STATE,
    'nextserver'                           => $FIELD_NEXTSERVER,
    'notify_delay'                         => $FIELD_NOTIFY_DELAY,
    'ns_group'                             => $FIELD_NS_GROUP,
    'nxdomain_log_query'                   => $FIELD_NXDOMAIN_LOG_QUERY,
    'nxdomain_redirect'                    => $FIELD_NXDOMAIN_REDIRECT,
    'nxdomain_redirect_addresses'          => $FIELD_NXDOMAIN_REDIRECT_ADDRESSES,
    'nxdomain_redirect_ttl'                => $FIELD_NXDOMAIN_REDIRECT_TTL,
    'nxdomain_rulesets'                    => $FIELD_NXDOMAIN_RULESETS,
    'objects'                              => $FIELD_OBJECTS,
    'on_commit'                            => $FIELD_ON_COMMIT,
    'on_expiry'                            => $FIELD_ON_EXPIRY,
    'on_release'                           => $FIELD_ON_RELEASE,
    'option'                               => $FIELD_OPTION,
    'option_filter_rules'                  => $FIELD_OPTION_FILTER_RULES,
    'options'                              => $FIELD_OPTIONS,
    'parent'                               => $FIELD_PARENT,
    'port'                                 => $FIELD_PORT,
    'preference'                           => $FIELD_PREFERENCE,
    'preferred_lifetime'                   => $FIELD_PREFERRED_LIFETIME,
    'prefix'                               => $FIELD_PREFIX,
    'primary_type'                         => $FIELD_PRIMARY_TYPE,
    'priority'                             => $FIELD_PRIORITY,
    'protocol'                             => $FIELD_PROTOCOL,
    'ptrdname'                             => $FIELD_PTRDNAME,
    'pxe_lease_time'                       => $FIELD_PXE_LEASE_TIME,
    'record_name_policy'                   => $FIELD_RECORD_NAME_POLICY,
    'records_monitored'                    => $FIELD_RECORDS_MONITORED,
    'recursion'                            => $FIELD_RECURSION,
    'recycle_leases'                       => $FIELD_RECYCLE_LEASES,
    'relay_agent_filter_rules'             => $FIELD_RELAY_AGENT_FILTER_RULES,
    'reporting_status'                     => $FIELD_REPORTING_STATUS,
    'reserved_for_infoblox'                => $FIELD_RESERVED_FOR_INFOBLOX,
    'root_name_server_type'                => $FIELD_ROOT_NAME_SERVER_TYPE,
    'rr_not_queried_enabled_time'          => $FIELD_RR_NOT_QUERIED_ENABLED_TIME,
    'rrset_order'                          => $FIELD_RRSET_ORDER,
    'scheduled_time'                       => $FIELD_SCHEDULED_TIME,
    'served_by'                            => $FIELD_SERVED_BY,
    'server_association_type'              => $FIELD_SERVER_ASSOCIATION_TYPE,
    'server_host_name'                     => $FIELD_SERVER_HOST_NAME,
    'set_soa_serial_number'                => $FIELD_SET_SOA_SERIAL_NUMBER,
    'shared_network_name'                  => $FIELD_SHARED_NETWORK_NAME,
    'soa_default_ttl'                      => $FIELD_SOA_DEFAULT_TTL,
    'soa_email'                            => $FIELD_SOA_EMAIL,
    'soa_expire'                           => $FIELD_SOA_EXPIRE,
    'soa_mname'                            => $FIELD_SOA_MNAME,
    'soa_negative_ttl'                     => $FIELD_SOA_NEGATIVE_TTL,
    'soa_refresh'                          => $FIELD_SOA_REFRESH,
    'soa_retry'                            => $FIELD_SOA_RETRY,
    'soa_serial_number'                    => $FIELD_SOA_SERIAL_NUMBER,
    'sortlist'                             => $FIELD_SORTLIST,
    'split_member'                         => $FIELD_SPLIT_MEMBER,
    'split_scope_exclusion_percent'        => $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT,
    'srgs'                                 => $FIELD_SRGS,
    'start_addr'                           => $FIELD_START_ADDR,
    'starts'                               => $FIELD_STARTS,
    'status'                               => $FIELD_STATUS,
    'stub_from'                            => $FIELD_STUB_FROM,
    'stub_members'                         => $FIELD_STUB_MEMBERS,
    'stub_msservers'                       => $FIELD_STUB_MSSERVERS,
    'submitter'                            => $FIELD_SUBMITTER,
    'submitter_comment'                    => $FIELD_SUBMITTER_COMMENT,
    'submit_time'                          => $FIELD_SUBMIT_TIME,
    'target'                               => $FIELD_TARGET,
    'task_id'                              => $FIELD_TASK_ID,
    'template'                             => $FIELD_TEMPLATE,
    'text'                                 => $FIELD_TEXT,
    'ticket_number'                        => $FIELD_TICKET_NUMBER,
    'tsfp'                                 => $FIELD_TSFP,
    'tstp'                                 => $FIELD_TSTP,
    'ttl'                                  => $FIELD_TTL,
    'types'                                => $FIELD_TYPES,
    'uid'                                  => $FIELD_UID,
    'unknown_clients'                      => $FIELD_UNKNOWN_CLIENTS,
    'update_dns_on_lease_renewal'          => $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL,
    'update_forwarding'                    => $FIELD_UPDATE_FORWARDING,
    'usage'                                => $FIELD_USAGE,
    'use_allow_active_dir'                 => $FIELD_USE_ALLOW_ACTIVE_DIR,
    'use_allow_query'                      => $FIELD_USE_ALLOW_QUERY,
    'use_allow_transfer'                   => $FIELD_USE_ALLOW_TRANSFER,
    'use_allow_update'                     => $FIELD_USE_ALLOW_UPDATE,
    'use_allow_update_forwarding'          => $FIELD_USE_ALLOW_UPDATE_FORWARDING,
    'use_authority'                        => $FIELD_USE_AUTHORITY,
    'use_blacklist'                        => $FIELD_USE_BLACKLIST,
    'use_bootfile'                         => $FIELD_USE_BOOTFILE,
    'use_bootserver'                       => $FIELD_USE_BOOTSERVER,
    'use_check_names_policy'               => $FIELD_USE_CHECK_NAMES_POLICY,
    'use_copy_xfer_to_notify'              => $FIELD_USE_COPY_XFER_TO_NOTIFY,
    'use_ddns_domainname'                  => $FIELD_USE_DDNS_DOMAINNAME,
    'use_ddns_enable_option_fqdn'          => $FIELD_USE_DDNS_ENABLE_OPTION_FQDN,
    'use_ddns_generate_hostname'           => $FIELD_USE_DDNS_GENERATE_HOSTNAME,
    'use_ddns_ttl'                         => $FIELD_USE_DDNS_TTL,
    'use_ddns_update_fixed_addresses'      => $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES,
    'use_ddns_use_option81'                => $FIELD_USE_DDNS_USE_OPTION81,
    'use_delegated_ttl'                    => $FIELD_USE_DELEGATED_TTL,
    'use_deny_bootp'                       => $FIELD_USE_DENY_BOOTP,
    'use_dns64'                            => $FIELD_USE_DNS64,
    'use_dnssec'                           => $FIELD_USE_DNSSEC,
    'use_dnssec_key_params'                => $FIELD_USE_DNSSEC_KEY_PARAMS,
    'use_domain_name'                      => $FIELD_USE_DOMAIN_NAME,
    'use_domain_name_servers'              => $FIELD_USE_DOMAIN_NAME_SERVERS,
    'use_email_list'                       => $FIELD_USE_EMAIL_LIST,
    'use_enable_ddns'                      => $FIELD_USE_ENABLE_DDNS,
    'use_enable_dhcp_thresholds'           => $FIELD_USE_ENABLE_DHCP_THRESHOLDS,
    'use_enable_ifmap_publishing'          => $FIELD_USE_ENABLE_IFMAP_PUBLISHING,
    'use_external_primary'                 => $FIELD_USE_EXTERNAL_PRIMARY,
    'use_filter_aaaa'                      => $FIELD_USE_FILTER_AAAA,
    'use_for_ea_inheritance'               => $FIELD_USE_FOR_EA_INHERITANCE,
    'use_forwarders'                       => $FIELD_USE_FORWARDERS,
    'use_grid_zone_timer'                  => $FIELD_USE_GRID_ZONE_TIMER,
    'use_ignore_client_requested_options'  => $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS,
    'use_ignore_dhcp_option_list_request'  => $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST,
    'use_import_from'                      => $FIELD_USE_IMPORT_FROM,
    'use_known_clients'                    => $FIELD_USE_KNOWN_CLIENTS,
    'use_lame_ttl'                         => $FIELD_USE_LAME_TTL,
    'use_lease_scavenge_time'              => $FIELD_USE_LEASE_SCAVENGE_TIME,
    'use_nextserver'                       => $FIELD_USE_NEXTSERVER,
    'use_notify_delay'                     => $FIELD_USE_NOTIFY_DELAY,
    'use_nxdomain_redirect'                => $FIELD_USE_NXDOMAIN_REDIRECT,
    'use_options'                          => $FIELD_USE_OPTIONS,
    'use_preferred_lifetime'               => $FIELD_USE_PREFERRED_LIFETIME,
    'use_pxe_lease_time'                   => $FIELD_USE_PXE_LEASE_TIME,
    'use_record_name_policy'               => $FIELD_USE_RECORD_NAME_POLICY,
    'use_recursion'                        => $FIELD_USE_RECURSION,
    'use_recycle_leases'                   => $FIELD_USE_RECYCLE_LEASES,
    'username'                             => $FIELD_USERNAME,
    'use_root_name_server'                 => $FIELD_USE_ROOT_NAME_SERVER,
    'use_soa_email'                        => $FIELD_USE_SOA_EMAIL,
    'use_soa_mname'                        => $FIELD_USE_SOA_MNAME,
    'use_sortlist'                         => $FIELD_USE_SORTLIST,
    'use_ttl'                              => $FIELD_USE_TTL,
    'use_unknown_clients'                  => $FIELD_USE_UNKNOWN_CLIENTS,
    'use_update_dns_on_lease_renewal'      => $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL,
    'use_valid_lifetime'                   => $FIELD_USE_VALID_LIFETIME,
    'use_zone_associations'                => $FIELD_USE_ZONE_ASSOCIATIONS,
    'using_srg_associations'               => $FIELD_USING_SRG_ASSOCIATIONS,
    'valid_lifetime'                       => $FIELD_VALID_LIFETIME,
    'variable'                             => $FIELD_VARIABLE,
    'view'                                 => $FIELD_VIEW,
    'weight'                               => $FIELD_WEIGHT,
    'zone'                                 => $FIELD_ZONE,
    'zone_associations'                    => $FIELD_ZONE_ASSOCIATIONS,
    'zone_format'                          => $FIELD_ZONE_FORMAT,
    'zone_not_queried_enabled_time'        => $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME,
);

#
# These need to be Updated HERE
#
Readonly::Hash our %_FIELD_TYPE => (
    $FIELD_REF                                  => $TYPE_STRING,
    $FIELD_ACCESS_LIST                          => $TYPE_UNKNOWN,
    $FIELD_ADDRESS                              => $TYPE_STRING,
    $FIELD_ADDRESS_TYPE                         => $TYPE_UNKNOWN,
    $FIELD_AGENT_CIRCUIT_ID                     => $TYPE_STRING,
    $FIELD_AGENT_REMOTE_ID                      => $TYPE_STRING,
    $FIELD_ALIASES                              => $TYPE_UNKNOWN,
    $FIELD_ALLOW_ACTIVE_DIR                     => $TYPE_UNKNOWN,
    $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE   => $TYPE_UNKNOWN,
    $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES          => $TYPE_UNKNOWN,
    $FIELD_ALLOW_QUERY                          => $TYPE_UNKNOWN,
    $FIELD_ALLOW_TRANSFER                       => $TYPE_UNKNOWN,
    $FIELD_ALLOW_UPDATE                         => $TYPE_UNKNOWN,
    $FIELD_ALLOW_UPDATE_FORWARDING              => $TYPE_UNKNOWN,
    $FIELD_ALWAYS_UPDATE_DNS                    => $TYPE_BOOL,
    $FIELD_APPROVAL_STATUS                      => $TYPE_UNKNOWN,
    $FIELD_APPROVER                             => $TYPE_UNKNOWN,
    $FIELD_APPROVER_COMMENT                     => $TYPE_UNKNOWN,
    $FIELD_AUTHENTICATION_TIME                  => $TYPE_UNKNOWN,
    $FIELD_AUTHORITY                            => $TYPE_BOOL,
    $FIELD_AUTO_CREATE_REVERSEZONE              => $TYPE_BOOL,
    $FIELD_AUTOMATIC_RESTART                    => $TYPE_UNKNOWN,
    $FIELD_BILLING_CLASS                        => $TYPE_STRING,
    $FIELD_BINDING_STATE                        => $TYPE_BINDING_STATE,
    $FIELD_BLACKLIST_ACTION                     => $TYPE_UNKNOWN,
    $FIELD_BLACKLIST_LOG_QUERY                  => $TYPE_UNKNOWN,
    $FIELD_BLACKLIST_REDIRECT_ADDRESSES         => $TYPE_UNKNOWN,
    $FIELD_BLACKLIST_REDIRECT_TTL               => $TYPE_UNKNOWN,
    $FIELD_BLACKLIST_RULESETS                   => $TYPE_UNKNOWN,
    $FIELD_BOOTFILE                             => $TYPE_STRING,
    $FIELD_BOOTSERVER                           => $TYPE_STRING,
    $FIELD_CANONICAL                            => $TYPE_UNKNOWN,
    $FIELD_CHANGED_OBJECTS                      => $TYPE_UNKNOWN,
    $FIELD_CLIENT_HOSTNAME                      => $TYPE_STRING,
    $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO       => $TYPE_BOOL,
    $FIELD_CLTT                                 => $TYPE_TIMESTAMP,
    $FIELD_COMMENT                              => $TYPE_STRING,
    $FIELD_CONFIGURE_FOR_DHCP                   => $TYPE_UNKNOWN,
    $FIELD_CONFIGURE_FOR_DNS                    => $TYPE_UNKNOWN,
    $FIELD_CONTAINS_ADDRESS                     => $TYPE_STRING,
    $FIELD_COPY_XFER_TO_NOTIFY                  => $TYPE_UNKNOWN,
    $FIELD_CREATE_PTR_FOR_BULK_HOSTS            => $TYPE_UNKNOWN,
    $FIELD_CREATE_PTR_FOR_HOSTS                 => $TYPE_UNKNOWN,
    $FIELD_CREATE_UNDERSCORE_ZONES              => $TYPE_UNKNOWN,
    $FIELD_CUSTOM_ROOT_NAME_SERVERS             => $TYPE_UNKNOWN,
    $FIELD_DDNS_DOMAINNAME                      => $TYPE_STRING,
    $FIELD_DDNS_GENERATE_HOSTNAME               => $TYPE_BOOL,
    $FIELD_DDNS_GENERATE_HOSTNAME               => $TYPE_STRING,
    $FIELD_DDNS_HOSTNAME                        => $TYPE_STRING,
    $FIELD_DDNS_SERVER_ALWAYS_UPDATES           => $TYPE_BOOL,
    $FIELD_DDNS_TTL                             => $TYPE_UINT,
    $FIELD_DDNS_UPDATE_FIXED_ADDRESSES          => $TYPE_BOOL,
    $FIELD_DDNS_USER_OPTION81                   => $TYPE_BOOL,
    $FIELD_DELEGATED_TTL                        => $TYPE_UNKNOWN,
    $FIELD_DELEGATE_TO                          => $TYPE_UNKNOWN,
    $FIELD_DENY_ALL_CLIENTS                     => $TYPE_UNKNOWN,
    $FIELD_DENY_BOOTP                           => $TYPE_BOOL,
    $FIELD_DHCP_CLIENT_IDENTIFIER               => $TYPE_STRING,
    $FIELD_DHCP_STATUS                          => $TYPE_UNKNOWN,
    $FIELD_DISABLE                              => $TYPE_BOOL,
    $FIELD_DISABLE_FORWARDING                   => $TYPE_UNKNOWN,
    $FIELD_DISCOVERED_DATA                      => $TYPE_STRUCT_DISCOVERYDATA,
    $FIELD_DISPLAY_DOMAIN                       => $TYPE_UNKNOWN,
    $FIELD_DNS64_ENABLED                        => $TYPE_UNKNOWN,
    $FIELD_DNS64_GROUPS                         => $TYPE_UNKNOWN,
    $FIELD_DNS_ALIASES                          => $TYPE_UNKNOWN,
    $FIELD_DNS_CANONICAL                        => $TYPE_UNKNOWN,
    $FIELD_DNS_FQDN                             => $TYPE_UNKNOWN,
    $FIELD_DNS_MAIL_EXCHANGER                   => $TYPE_UNKNOWN,
    $FIELD_DNS_NAME                             => $TYPE_UNKNOWN,
    $FIELD_DNS_PTRDNAME                         => $TYPE_UNKNOWN,
    $FIELD_DNSSEC_ENABLED                       => $TYPE_UNKNOWN,
    $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED    => $TYPE_UNKNOWN,
    $FIELD_DNSSEC_KEY_PARAMS                    => $TYPE_UNKNOWN,
    $FIELD_DNSSEC_TRUSTED_KEYS                  => $TYPE_UNKNOWN,
    $FIELD_DNSSEC_VALIDATION_ENABLED            => $TYPE_UNKNOWN,
    $FIELD_DNS_SOA_EMAIL                        => $TYPE_UNKNOWN,
    $FIELD_DNS_SOA_MNAME                        => $TYPE_UNKNOWN,
    $FIELD_DNS_STATUS                           => $TYPE_UNKNOWN,
    $FIELD_DNS_TARGET                           => $TYPE_UNKNOWN,
    $FIELD_DO_HOST_ABSTRACTION                  => $TYPE_UNKNOWN,
    $FIELD_DOMAIN_NAME                          => $TYPE_UNKNOWN,
    $FIELD_DOMAIN_NAME_SERVERS                  => $TYPE_UNKNOWN,
    $FIELD_DUID                                 => $TYPE_STRING,
    $FIELD_EFFECTIVE_CHECK_NAMES_POLICY         => $TYPE_UNKNOWN,
    $FIELD_EFFECTIVE_RECORD_NAME_POLICY         => $TYPE_UNKNOWN,
    $FIELD_EMAIL_LIST                           => $TYPE_STRING_ARRAY,
    $FIELD_ENABLE_BLACKLIST                     => $TYPE_BOOL,
    $FIELD_ENABLE_DDNS                          => $TYPE_BOOL,
    $FIELD_ENABLE_DHCP_THRESHOLDS               => $TYPE_BOOL,
    $FIELD_ENABLE_EMAIL_WARNINGS                => $TYPE_BOOL,
    $FIELD_ENABLE_IFMAP_PUBLISHING              => $TYPE_BOOL,
    $FIELD_ENABLE_PXE_LEASE_TIME                => $TYPE_BOOL,
    $FIELD_ENABLE_RFC2317_EXCLUSION             => $TYPE_BOOL,
    $FIELD_ENABLE_SNMP_WARNINGS                 => $TYPE_BOOL,
    $FIELD_END_ADDR                             => $TYPE_UNKNOWN,
    $FIELD_ENDS                                 => $TYPE_TIMESTAMP,
    $FIELD_EXCLUDE                              => $TYPE_UNKNOWN,
    $FIELD_EXECUTE_NOW                          => $TYPE_UNKNOWN,
    $FIELD_EXECUTION_STATUS                     => $TYPE_UNKNOWN,
    $FIELD_EXECUTION_TIME                       => $TYPE_UNKNOWN,
    $FIELD_EXPIRATION_TIME                      => $TYPE_UNKNOWN,
    $FIELD_EXPLODED_ACCESS_LIST                 => $TYPE_UNKNOWN,
    $FIELD_EXTATTRS                             => $TYPE_EXTATTRS,
    $FIELD_EXTERNAL_PRIMARIES                   => $TYPE_UNKNOWN,
    $FIELD_EXTERNAL_SECONDARIES                 => $TYPE_UNKNOWN,
    $FIELD_FAILOVER_ASSOCIATION                 => $TYPE_UNKNOWN,
    $FIELD_FILTER                               => $TYPE_UNKNOWN,
    $FIELD_FILTER_AAAA                          => $TYPE_UNKNOWN,
    $FIELD_FILTER_AAAA_LIST                     => $TYPE_UNKNOWN,
    $FIELD_FINGERPRINT                          => $TYPE_UNKNOWN,
    $FIELD_FINGERPRINT_FILTER_RULES             => $TYPE_UNKNOWN,
    $FIELD_FORWARDERS                           => $TYPE_UNKNOWN,
    $FIELD_FORWARDERS_ONLY                      => $TYPE_UNKNOWN,
    $FIELD_FORWARDING_SERVERS                   => $TYPE_UNKNOWN,
    $FIELD_FORWARD_ONLY                         => $TYPE_UNKNOWN,
    $FIELD_FORWARD_TO                           => $TYPE_UNKNOWN,
    $FIELD_FQDN                                 => $TYPE_STRING,
    $FIELD_GRID_PRIMARY                         => $TYPE_UNKNOWN,
    $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D => $TYPE_UNKNOWN,
    $FIELD_GRID_SECONDARIES                     => $TYPE_UNKNOWN,
    $FIELD_GUEST_CUSTOM_FIELD1                  => $TYPE_STRING,
    $FIELD_GUEST_CUSTOM_FIELD2                  => $TYPE_STRING,
    $FIELD_GUEST_CUSTOM_FIELD3                  => $TYPE_STRING,
    $FIELD_GUEST_CUSTOM_FIELD4                  => $TYPE_STRING,
    $FIELD_GUEST_EMAIL                          => $TYPE_STRING,
    $FIELD_GUEST_FIRST_NAME                     => $TYPE_STRING,
    $FIELD_GUEST_LAST_NAME                      => $TYPE_STRING,
    $FIELD_GUEST_MIDDLE_NAME                    => $TYPE_STRING,
    $FIELD_GUEST_PHONE                          => $TYPE_STRING,
    $FIELD_HARDWARE                             => $TYPE_STRING,
    $FIELD_HIGH_WATER_MARK                      => $TYPE_UINT,
    $FIELD_HIGH_WATER_MARK_RESET                => $TYPE_UINT,
    $FIELD_HOST                                 => $TYPE_UNKNOWN,
    $FIELD_HOST_NAME                            => $TYPE_UNKNOWN,
    $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS      => $TYPE_UNKNOWN,
    $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST      => $TYPE_BOOL,
    $FIELD_IMPORT_FROM                          => $TYPE_UNKNOWN,
    $FIELD_IP_ADDRESS                           => $TYPE_STRING,
    $FIELD_IPV4ADDR                             => $TYPE_STRING,
    $FIELD_IPV4ADDRS                            => $TYPE_STRING,
    $FIELD_IPV4_ADDRESS                         => $TYPE_STRING,
    $FIELD_IPV6ADDR                             => $TYPE_STRING,
    $FIELD_IPV6ADDRS                            => $TYPE_STRING,
    $FIELD_IPV6PREFIX                           => $TYPE_STRING,
    $FIELD_IPV6PREFIX_BITS                      => $TYPE_UINT,
    $FIELD_IPV6_ADDRESS                         => $TYPE_STRING,
    $FIELD_IPV6_DUID                            => $TYPE_STRING,
    $FIELD_IPV6_END_PREFIX                      => $TYPE_UNKNOWN,
    $FIELD_IPV6_IAID                            => $TYPE_STRING,
    $FIELD_IPV6_PREFERRED_LIFETIME              => $TYPE_INT,
    $FIELD_IPV6_PREFIX                          => $TYPE_UNKNOWN,
    $FIELD_IPV6_PREFIX_BITS                     => $TYPE_UINT,
    $FIELD_IPV6_START_PREFIX                    => $TYPE_UNKNOWN,
    $FIELD_IS_CONFLICT                          => $TYPE_BOOL,
    $FIELD_IS_DEFAULT                           => $TYPE_UNKNOWN,
    $FIELD_IS_DNSSEC_ENABLED                    => $TYPE_UNKNOWN,
    $FIELD_IS_DNSSEC_SIGNED                     => $TYPE_UNKNOWN,
    $FIELD_IS_REGISTERED_USER                   => $TYPE_UNKNOWN,
    $FIELD_IS_SPLIT_SCOPE                       => $TYPE_UNKNOWN,
    $FIELD_KNOWN_CLIENTS                        => $TYPE_UNKNOWN,
    $FIELD_LAME_TTL                             => $TYPE_UNKNOWN,
    $FIELD_LAST_QUERIED                         => $TYPE_UNKNOWN,
    $FIELD_LEASE_SCAVENGE_TIME                  => $TYPE_INT,
    $FIELD_LEASE_STATE                          => $TYPE_STRING,
    $FIELD_LOCKED                               => $TYPE_UNKNOWN,
    $FIELD_LOCKED_BY                            => $TYPE_UNKNOWN,
    $FIELD_LOGIC_FILTER_RULES                   => $TYPE_UNKNOWN,
    $FIELD_LOW_WATER_MARK                       => $TYPE_UINT,
    $FIELD_LOW_WATER_MARK_RESET                 => $TYPE_UINT,
    $FIELD_MAC                                  => $TYPE_STRING,
    $FIELD_MAC_ADDRESS                          => $TYPE_STRING,
    $FIELD_MAC_FILTER_RULES                     => $TYPE_UNKNOWN,
    $FIELD_MAIL_EXCHANGER                       => $TYPE_UNKNOWN,
    $FIELD_MASK_PREFIX                          => $TYPE_UNKNOWN,
    $FIELD_MATCH_CLIENT                         => $TYPE_STRING,
    $FIELD_MATCH_CLIENTS                        => $TYPE_UNKNOWN,
    $FIELD_MATCH_DESTINATIONS                   => $TYPE_UNKNOWN,
    $FIELD_MEMBER                               => $TYPE_UNKNOWN,
    $FIELD_MEMBERS                              => $TYPE_MEMBERS,
    $FIELD_MS_AD_INTEGRATED                     => $TYPE_UNKNOWN,
    $FIELD_MS_ALLOW_TRANSFER                    => $TYPE_UNKNOWN,
    $FIELD_MS_ALLOW_TRANSFER_MODE               => $TYPE_UNKNOWN,
    $FIELD_MS_DDNS_MODE                         => $TYPE_UNKNOWN,
    $FIELD_MS_MANAGED                           => $TYPE_UNKNOWN,
    $FIELD_MS_OPTIONS                           => $TYPE_MS_OPTIONS,
    $FIELD_MS_PRIMARIES                         => $TYPE_UNKNOWN,
    $FIELD_MS_READ_ONLY                         => $TYPE_UNKNOWN,
    $FIELD_MS_SECONDARIES                       => $TYPE_UNKNOWN,
    $FIELD_MS_SERVER                            => $TYPE_MS_SERVER,
    $FIELD_MS_SYNC_MASTER_NAME                  => $TYPE_UNKNOWN,
    $FIELD_NAC_FILTER_RULES                     => $TYPE_UNKNOWN,
    $FIELD_NAME                                 => $TYPE_STRING,
    $FIELD_NAMES                                => $TYPE_STRING_ARRAY,
    $FIELD_NETMASK                              => $TYPE_UINT,
    $FIELD_NETWORK                              => $TYPE_STRING,
    $FIELD_NETWORK_ASSOCIATIONS                 => $TYPE_UNKNOWN,
    $FIELD_NETWORK_CONTAINER                    => $TYPE_STRING,
    $FIELD_NETWORK_VIEW                         => $TYPE_STRING,
    $FIELD_NEVER_ENDS                           => $TYPE_BOOL,
    $FIELD_NEVER_EXPIRES                        => $TYPE_BOOL,
    $FIELD_NEVER_STARTS                         => $TYPE_BOOL,
    $FIELD_NEXT_BINDING_STATE                   => $TYPE_STRING,
    $FIELD_NEXTSERVER                           => $TYPE_STRING,
    $FIELD_NOTIFY_DELAY                         => $TYPE_UNKNOWN,
    $FIELD_NS_GROUP                             => $TYPE_UNKNOWN,
    $FIELD_NXDOMAIN_LOG_QUERY                   => $TYPE_UNKNOWN,
    $FIELD_NXDOMAIN_REDIRECT                    => $TYPE_UNKNOWN,
    $FIELD_NXDOMAIN_REDIRECT_ADDRESSES          => $TYPE_UNKNOWN,
    $FIELD_NXDOMAIN_REDIRECT_TTL                => $TYPE_UNKNOWN,
    $FIELD_NXDOMAIN_RULESETS                    => $TYPE_UNKNOWN,
    $FIELD_OBJECTS                              => $TYPE_STRING,
    $FIELD_ON_COMMIT                            => $TYPE_STRING,
    $FIELD_ON_EXPIRY                            => $TYPE_STRING,
    $FIELD_ON_RELEASE                           => $TYPE_STRING,
    $FIELD_OPTION                               => $TYPE_STRING,
    $FIELD_OPTION_FILTER_RULES                  => $TYPE_UNKNOWN,
    $FIELD_OPTIONS                              => $TYPE_OPTIONS,
    $FIELD_PARENT                               => $TYPE_UNKNOWN,
    $FIELD_PORT                                 => $TYPE_UNKNOWN,
    $FIELD_PREFERENCE                           => $TYPE_UNKNOWN,
    $FIELD_PREFERRED_LIFETIME                   => $TYPE_UNKNOWN,
    $FIELD_PREFIX                               => $TYPE_UNKNOWN,
    $FIELD_PRIMARY_TYPE                         => $TYPE_UNKNOWN,
    $FIELD_PRIORITY                             => $TYPE_UNKNOWN,
    $FIELD_PROTOCOL                             => $TYPE_STRING,
    $FIELD_PTRDNAME                             => $TYPE_UNKNOWN,
    $FIELD_PXE_LEASE_TIME                       => $TYPE_UINT,
    $FIELD_RECORD_NAME_POLICY                   => $TYPE_UNKNOWN,
    $FIELD_RECORDS_MONITORED                    => $TYPE_UNKNOWN,
    $FIELD_RECURSION                            => $TYPE_UNKNOWN,
    $FIELD_RECYCLE_LEASES                       => $TYPE_BOOL,
    $FIELD_RELAY_AGENT_FILTER_RULES             => $TYPE_UNKNOWN,
    $FIELD_REPORTING_STATUS                     => $TYPE_UNKNOWN,
    $FIELD_RESERVED_FOR_INFOBLOX                => $TYPE_UNKNOWN,
    $FIELD_ROOT_NAME_SERVER_TYPE                => $TYPE_UNKNOWN,
    $FIELD_RR_NOT_QUERIED_ENABLED_TIME          => $TYPE_UNKNOWN,
    $FIELD_RRSET_ORDER                          => $TYPE_UNKNOWN,
    $FIELD_SCHEDULED_TIME                       => $TYPE_UNKNOWN,
    $FIELD_SERVED_BY                            => $TYPE_STRING,
    $FIELD_SERVER_ASSOCIATION_TYPE              => $TYPE_UNKNOWN,
    $FIELD_SERVER_HOST_NAME                     => $TYPE_STRING,
    $FIELD_SET_SOA_SERIAL_NUMBER                => $TYPE_UNKNOWN,
    $FIELD_SHARED_NETWORK_NAME                  => $TYPE_STRING,
    $FIELD_SOA_DEFAULT_TTL                      => $TYPE_UNKNOWN,
    $FIELD_SOA_EMAIL                            => $TYPE_UNKNOWN,
    $FIELD_SOA_EXPIRE                           => $TYPE_UNKNOWN,
    $FIELD_SOA_MNAME                            => $TYPE_UNKNOWN,
    $FIELD_SOA_NEGATIVE_TTL                     => $TYPE_UNKNOWN,
    $FIELD_SOA_REFRESH                          => $TYPE_UNKNOWN,
    $FIELD_SOA_RETRY                            => $TYPE_UNKNOWN,
    $FIELD_SOA_SERIAL_NUMBER                    => $TYPE_UNKNOWN,
    $FIELD_SORTLIST                             => $TYPE_UNKNOWN,
    $FIELD_SPLIT_MEMBER                         => $TYPE_UNKNOWN,
    $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT        => $TYPE_UNKNOWN,
    $FIELD_SRGS                                 => $TYPE_UNKNOWN,
    $FIELD_START_ADDR                           => $TYPE_UNKNOWN,
    $FIELD_STARTS                               => $TYPE_TIMESTAMP,
    $FIELD_STATUS                               => $TYPE_STRING,
    $FIELD_STUB_FROM                            => $TYPE_UNKNOWN,
    $FIELD_STUB_MEMBERS                         => $TYPE_UNKNOWN,
    $FIELD_STUB_MSSERVERS                       => $TYPE_UNKNOWN,
    $FIELD_SUBMITTER                            => $TYPE_UNKNOWN,
    $FIELD_SUBMITTER_COMMENT                    => $TYPE_UNKNOWN,
    $FIELD_SUBMIT_TIME                          => $TYPE_UNKNOWN,
    $FIELD_TARGET                               => $TYPE_UNKNOWN,
    $FIELD_TASK_ID                              => $TYPE_UNKNOWN,
    $FIELD_TEMPLATE                             => $TYPE_STRING,
    $FIELD_TEXT                                 => $TYPE_UNKNOWN,
    $FIELD_TICKET_NUMBER                        => $TYPE_UNKNOWN,
    $FIELD_TSFP                                 => $TYPE_TIMESTAMP,
    $FIELD_TSTP                                 => $TYPE_TIMESTAMP,
    $FIELD_TTL                                  => $TYPE_UNKNOWN,
    $FIELD_TYPES                                => $TYPE_STRING_ARRAY,
    $FIELD_UID                                  => $TYPE_STRING,
    $FIELD_UNKNOWN_CLIENTS                      => $TYPE_UNKNOWN,
    $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL          => $TYPE_BOOL,
    $FIELD_UPDATE_FORWARDING                    => $TYPE_BOOL,
    $FIELD_USAGE                                => $TYPE_STRING_ARRAY,
    $FIELD_USE_ALLOW_ACTIVE_DIR                 => $TYPE_BOOL,
    $FIELD_USE_ALLOW_QUERY                      => $TYPE_BOOL,
    $FIELD_USE_ALLOW_TRANSFER                   => $TYPE_BOOL,
    $FIELD_USE_ALLOW_UPDATE                     => $TYPE_BOOL,
    $FIELD_USE_ALLOW_UPDATE_FORWARDING          => $TYPE_BOOL,
    $FIELD_USE_AUTHORITY                        => $TYPE_BOOL,
    $FIELD_USE_BLACKLIST                        => $TYPE_BOOL,
    $FIELD_USE_BOOTFILE                         => $TYPE_BOOL,
    $FIELD_USE_BOOTSERVER                       => $TYPE_BOOL,
    $FIELD_USE_CHECK_NAMES_POLICY               => $TYPE_BOOL,
    $FIELD_USE_COPY_XFER_TO_NOTIFY              => $TYPE_BOOL,
    $FIELD_USE_DDNS_DOMAINNAME                  => $TYPE_BOOL,
    $FIELD_USE_DDNS_ENABLE_OPTION_FQDN          => $TYPE_BOOL,
    $FIELD_USE_DDNS_GENERATE_HOSTNAME           => $TYPE_BOOL,
    $FIELD_USE_DDNS_TTL                         => $TYPE_BOOL,
    $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES      => $TYPE_BOOL,
    $FIELD_USE_DDNS_USE_OPTION81                => $TYPE_BOOL,
    $FIELD_USE_DELEGATED_TTL                    => $TYPE_BOOL,
    $FIELD_USE_DENY_BOOTP                       => $TYPE_BOOL,
    $FIELD_USE_DNS64                            => $TYPE_BOOL,
    $FIELD_USE_DNSSEC                           => $TYPE_BOOL,
    $FIELD_USE_DNSSEC_KEY_PARAMS                => $TYPE_BOOL,
    $FIELD_USE_DOMAIN_NAME                      => $TYPE_BOOL,
    $FIELD_USE_DOMAIN_NAME_SERVERS              => $TYPE_BOOL,
    $FIELD_USE_EMAIL_LIST                       => $TYPE_BOOL,
    $FIELD_USE_ENABLE_DDNS                      => $TYPE_BOOL,
    $FIELD_USE_ENABLE_DHCP_THRESHOLDS           => $TYPE_BOOL,
    $FIELD_USE_ENABLE_IFMAP_PUBLISHING          => $TYPE_BOOL,
    $FIELD_USE_EXTERNAL_PRIMARY                 => $TYPE_BOOL,
    $FIELD_USE_FILTER_AAAA                      => $TYPE_BOOL,
    $FIELD_USE_FOR_EA_INHERITANCE               => $TYPE_BOOL,
    $FIELD_USE_FORWARDERS                       => $TYPE_BOOL,
    $FIELD_USE_GRID_ZONE_TIMER                  => $TYPE_BOOL,
    $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS  => $TYPE_BOOL,
    $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST  => $TYPE_BOOL,
    $FIELD_USE_IMPORT_FROM                      => $TYPE_BOOL,
    $FIELD_USE_KNOWN_CLIENTS                    => $TYPE_BOOL,
    $FIELD_USE_LAME_TTL                         => $TYPE_BOOL,
    $FIELD_USE_LEASE_SCAVENGE_TIME              => $TYPE_BOOL,
    $FIELD_USE_NEXTSERVER                       => $TYPE_BOOL,
    $FIELD_USE_NOTIFY_DELAY                     => $TYPE_BOOL,
    $FIELD_USE_NXDOMAIN_REDIRECT                => $TYPE_BOOL,
    $FIELD_USE_OPTIONS                          => $TYPE_BOOL,
    $FIELD_USE_PREFERRED_LIFETIME               => $TYPE_BOOL,
    $FIELD_USE_PXE_LEASE_TIME                   => $TYPE_BOOL,
    $FIELD_USE_RECORD_NAME_POLICY               => $TYPE_BOOL,
    $FIELD_USE_RECURSION                        => $TYPE_BOOL,
    $FIELD_USE_RECYCLE_LEASES                   => $TYPE_BOOL,
    $FIELD_USE_ROOT_NAME_SERVER                 => $TYPE_BOOL,
    $FIELD_USE_SOA_EMAIL                        => $TYPE_BOOL,
    $FIELD_USE_SOA_MNAME                        => $TYPE_BOOL,
    $FIELD_USE_SORTLIST                         => $TYPE_BOOL,
    $FIELD_USE_TTL                              => $TYPE_BOOL,
    $FIELD_USE_UNKNOWN_CLIENTS                  => $TYPE_BOOL,
    $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL      => $TYPE_BOOL,
    $FIELD_USE_VALID_LIFETIME                   => $TYPE_BOOL,
    $FIELD_USE_ZONE_ASSOCIATIONS                => $TYPE_BOOL,
    $FIELD_USING_SRG_ASSOCIATIONS               => $TYPE_UNKNOWN,
    $FIELD_USERNAME                             => $TYPE_STRING,
    $FIELD_VALID_LIFETIME                       => $TYPE_UNKNOWN,
    $FIELD_VARIABLE                             => $TYPE_STRING,
    $FIELD_VIEW                                 => $TYPE_UNKNOWN,
    $FIELD_WEIGHT                               => $TYPE_UNKNOWN,
    $FIELD_ZONE                                 => $TYPE_UNKNOWN,
    $FIELD_ZONE_ASSOCIATIONS                    => $TYPE_ZONE_ASSOCIATIONS,
    $FIELD_ZONE_FORMAT                          => $TYPE_UNKNOWN,
    $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME        => $TYPE_UNKNOWN,
);

Readonly::Hash our %_MODULES => (
    $PERL_MODULE_FIXEDADDRESS         => 1,
    $PERL_MODULE_GRID                 => 1,
    $PERL_MODULE_IPV4ADDRESS          => 1,
    $PERL_MODULE_IPV6ADDRESS          => 1,
    $PERL_MODULE_IPV6FIXEDADDRESS     => 1,
    $PERL_MODULE_IPV6NETWORKCONTAINER => 1,
    $PERL_MODULE_IPV6NETWORK          => 1,
    $PERL_MODULE_IPV6RANGE            => 1,
    $PERL_MODULE_LEASE                => 1,
    $PERL_MODULE_MACFILTERADDRESS     => 1,
    $PERL_MODULE_MEMBER               => 1,
    $PERL_MODULE_NAMEDACL             => 1,
    $PERL_MODULE_NETWORKCONTAINER     => 1,
    $PERL_MODULE_NETWORK              => 1,
    $PERL_MODULE_NETWORKVIEW          => 1,
    $PERL_MODULE_RANGE                => 1,
    $PERL_MODULE_RECORD_AAAA          => 1,
    $PERL_MODULE_RECORD_A             => 1,
    $PERL_MODULE_RECORD_CNAME         => 1,
    $PERL_MODULE_RECORD_HOST_IPV4ADDR => 1,
    $PERL_MODULE_RECORD_HOST_IPV6ADDR => 1,
    $PERL_MODULE_RECORD_HOST          => 1,
    $PERL_MODULE_RECORD_MX            => 1,
    $PERL_MODULE_RECORD_PTR           => 1,
    $PERL_MODULE_RECORD_SRV           => 1,
    $PERL_MODULE_RECORD_TXT           => 1,
    $PERL_MODULE_RESTARTSERVICESTATUS => 1,
    $PERL_MODULE_SCHEDULEDTASK        => 1,
    $PERL_MODULE_SEARCH               => 1,
    $PERL_MODULE_VIEW                 => 1,
    $PERL_MODULE_ZONE_AUTH            => 1,
    $PERL_MODULE_ZONE_DELEGATED       => 1,
    $PERL_MODULE_ZONE_FORWARD         => 1,
    $PERL_MODULE_ZONE_STUB            => 1,
);

Readonly::Hash our %_MODULE_OBJ_NAME => (
    $MODULE_FIXEDADDRESS              => 'fixedaddress',
    $MODULE_GRID                      => 'grid',
    $MODULE_IPV4ADDRESS               => 'ipv4address',
    $MODULE_IPV6ADDRESS               => 'ipv6address',
    $MODULE_IPV6FIXEDADDRESS          => 'ipv6fixedaddress',
    $MODULE_IPV6NETWORKCONTAINER      => 'ipv6networkcontainer',
    $MODULE_IPV6NETWORK               => 'ipv6network',
    $MODULE_IPV6RANGE                 => 'ipv6range',
    $MODULE_LEASE                     => 'lease',
    $MODULE_MACFILTERADDRESS          => 'macfilteraddress',
    $MODULE_MEMBER                    => 'member',
    $MODULE_NAMEDACL                  => 'namedacl',
    $MODULE_NETWORKCONTAINER          => 'networkcontainer',
    $MODULE_NETWORK                   => 'network',
    $MODULE_NETWORKVIEW               => 'networkview',
    $MODULE_RANGE                     => 'range',
    $MODULE_RECORD_AAAA               => 'record:aaaa',
    $MODULE_RECORD_A                  => 'record:a',
    $MODULE_RECORD_CNAME              => 'record:cname',
    $MODULE_RECORD_HOST_IPV4ADDR      => 'record:host_ipv4addr',
    $MODULE_RECORD_HOST_IPV6ADDR      => 'record:host_ipv6addr',
    $MODULE_RECORD_HOST               => 'record:host',
    $MODULE_RECORD_MX                 => 'record:mx',
    $MODULE_RECORD_PTR                => 'record:ptr',
    $MODULE_RECORD_SRV                => 'record:srv',
    $MODULE_RECORD_TXT                => 'record:txt',
    $MODULE_RESTARTSERVICESTATUS      => 'restartservicestatus',
    $MODULE_SCHEDULEDTASK             => 'scheduledtask',
    $MODULE_SEARCH                    => 'search',
    $MODULE_VIEW                      => 'view',
    $MODULE_ZONE_AUTH                 => 'zone_auth',
    $MODULE_ZONE_DELEGATED            => 'zone_delegated',
    $MODULE_ZONE_FORWARD              => 'zone_forward',
    $MODULE_ZONE_STUB                 => 'zone_stub',
    $PERL_MODULE_FIXEDADDRESS         => 'fixedaddress',
    $PERL_MODULE_GRID                 => 'grid',
    $PERL_MODULE_IPV4ADDRESS          => 'ipv4address',
    $PERL_MODULE_IPV6ADDRESS          => 'ipv6address',
    $PERL_MODULE_IPV6FIXEDADDRESS     => 'ipv6fixedaddress',
    $PERL_MODULE_IPV6NETWORKCONTAINER => 'ipv6networkcontainer',
    $PERL_MODULE_IPV6NETWORK          => 'ipv6network',
    $PERL_MODULE_IPV6RANGE            => 'ipv6range',
    $PERL_MODULE_LEASE                => 'lease',
    $PERL_MODULE_MACFILTERADDRESS     => 'macfilteraddress',
    $PERL_MODULE_MEMBER               => 'member',
    $PERL_MODULE_NAMEDACL             => 'namedacl',
    $PERL_MODULE_NETWORKCONTAINER     => 'networkcontainer',
    $PERL_MODULE_NETWORK              => 'network',
    $PERL_MODULE_NETWORKVIEW          => 'networkview',
    $PERL_MODULE_RANGE                => 'range',
    $PERL_MODULE_RECORD_AAAA          => 'record_aaaa',
    $PERL_MODULE_RECORD_A             => 'record_a',
    $PERL_MODULE_RECORD_CNAME         => 'record_cname',
    $PERL_MODULE_RECORD_HOST_IPV4ADDR => 'record_host_ipv4addr',
    $PERL_MODULE_RECORD_HOST_IPV6ADDR => 'record_host_ipv6addr',
    $PERL_MODULE_RECORD_HOST          => 'record_host',
    $PERL_MODULE_RECORD_MX            => 'record_mx',
    $PERL_MODULE_RECORD_PTR           => 'record_ptr',
    $PERL_MODULE_RECORD_SRV           => 'record_srv',
    $PERL_MODULE_RECORD_TXT           => 'record_txt',
    $PERL_MODULE_RESTARTSERVICESTATUS => 'restartservicestatus',
    $PERL_MODULE_SCHEDULEDTASK        => 'scheduledtask',
    $PERL_MODULE_SEARCH               => 'search',
    $PERL_MODULE_VIEW                 => 'view',
    $PERL_MODULE_ZONE_AUTH            => 'zone_auth',
    $PERL_MODULE_ZONE_DELEGATED       => 'zone_delegated',
    $PERL_MODULE_ZONE_FORWARD         => 'zone_forward',
    $PERL_MODULE_ZONE_STUB            => 'zone_stub',
);

Readonly::Hash our %_NAME_MODULE_OBJ => (
    'fixedaddress'         => $MODULE_FIXEDADDRESS,
    'grid'                 => $MODULE_GRID,
    'ipv4address'          => $MODULE_IPV4ADDRESS,
    'ipv6address'          => $MODULE_IPV6ADDRESS,
    'ipv6fixedaddress'     => $MODULE_IPV6FIXEDADDRESS,
    'ipv6networkcontainer' => $MODULE_IPV6NETWORKCONTAINER,
    'ipv6network'          => $MODULE_IPV6NETWORK,
    'ipv6range'            => $MODULE_IPV6RANGE,
    'lease'                => $MODULE_LEASE,
    'macfilteraddress'     => $MODULE_MACFILTERADDRESS,
    'member'               => $MODULE_MEMBER,
    'namedacl'             => $MODULE_NAMEDACL,
    'networkcontainer'     => $MODULE_NETWORKCONTAINER,
    'network'              => $MODULE_NETWORK,
    'networkview'          => $MODULE_NETWORKVIEW,
    'range'                => $MODULE_RANGE,
    'record:a'             => $MODULE_RECORD_A,
    'record:aaaa'          => $MODULE_RECORD_AAAA,
    'record:cname'         => $MODULE_RECORD_CNAME,
    'record:host'          => $MODULE_RECORD_HOST,
    'record:host_ipv4addr' => $MODULE_RECORD_HOST_IPV4ADDR,
    'record:host_ipv6addr' => $MODULE_RECORD_HOST_IPV6ADDR,
    'record:mx'            => $MODULE_RECORD_MX,
    'record:ptr'           => $MODULE_RECORD_PTR,
    'record:srv'           => $MODULE_RECORD_SRV,
    'record:txt'           => $MODULE_RECORD_TXT,
    'restartservicestatus' => $MODULE_RESTARTSERVICESTATUS,
    'scheduledtask'        => $MODULE_SCHEDULEDTASK,
    'search'               => $MODULE_SEARCH,
    'view'                 => $MODULE_VIEW,
    'zone_auth'            => $MODULE_ZONE_AUTH,
    'zone_delegated'       => $MODULE_ZONE_DELEGATED,
    'zone_forward'         => $MODULE_ZONE_FORWARD,
    'zone_stub'            => $MODULE_ZONE_STUB,
);

Readonly our $EVAL_NEW_STRUCT_CODE => '
    defined $parm_ref || LOG_FATAL "parameters are required";
    ref($parm_ref) eq "HASH" || LOG_FATAL "bad parameter ref";
    $parm_ref->{$IB_STRUCT_FIELDS} = \%_FIELDS;
    $parm_ref->{$IB_STRUCT_TYPES}  = \%_FIELD_TYPES;
    my $self = $class->SUPER::new( $parm_ref );
    bless $self, $class;
';

my $_LOGGING_LEVEL = $_LOG_FATAL;
my $_SUB_LEVEL     = 0;

#  $FIELD_NAMES
# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $DEBUG
  $EVAL_NEW_STRUCT_CODE
  LOG_ENTER_SUB
  LOG_EXIT_SUB
  LOG_URL
  SET_LOGGING
  LOG_DEBUG4
  LOG_DEBUG3
  LOG_DEBUG2
  LOG_DEBUG1
  LOG_DEBUG0
  LOG_INFO
  LOG_WARN
  LOG_ERROR
  LOG_FATAL
  $LOG_FATAL
  $LOG_ERROR
  $LOG_WARN
  $LOG_INFO
  $LOG_DEBUG0
  $LOG_DEBUG1
  $LOG_DEBUG2
  $LOG_DEBUG3
  $LOG_DEBUG4
  URL_PARM_EXISTS;
  URL_FIELD_EXISTS
  URL_NAME_FIELD_EXISTS
  URL_MODULE_EXISTS
  URL_REF_MODULE_EXISTS
  URL_NAME_MODULE_EXISTS
  URL_SEARCH_EXISTS
  URL_PARM_NAME
  URL_FIELD_NAME
  URL_FIELD_TYPE
  URL_NAME_FIELD
  URL_MODULE_NAME
  URL_REF_MODULE_NAME
  URL_NAME_MODULE
  URL_SEARCH_NAME
  VERIFY_TIMESTAMP
  MYNAME
  MYLINE
  MYNAMELINE
  PRINT_MYNAME
  PRINT_MYLINE
  PRINT_MYNAMELINE
  $_IB_VERSION
  $_IB_REF
  $PERL_MODULE_IBCONSTS
  $PERL_MODULE_IBLWP
  $PERL_MODULE_IBRECORD
  $PERL_MODULE_IBWAPI
  $PERL_MODULE_JSON_BOOLEAN
  $PERL_MODULE_EXTATTR
  $PERL_MODULE_FIXEDADDRESS
  $PERL_MODULE_GRID
  $PERL_MODULE_IPV4ADDRESS
  $PERL_MODULE_IPV6ADDRESS
  $PERL_MODULE_IPV6FIXEDADDRESS
  $PERL_MODULE_IPV6NETWORKCONTAINER
  $PERL_MODULE_IPV6NETWORK
  $PERL_MODULE_IPV6RANGE
  $PERL_MODULE_LEASE
  $PERL_MODULE_MACFILTERADDRESS
  $PERL_MODULE_MEMBER
  $PERL_MODULE_NAMEDACL
  $PERL_MODULE_NETWORKCONTAINER
  $PERL_MODULE_NETWORK
  $PERL_MODULE_NETWORKVIEW
  $PERL_MODULE_RANGE
  $PERL_MODULE_RECORD_AAAA
  $PERL_MODULE_RECORD_A
  $PERL_MODULE_RECORD_CNAME
  $PERL_MODULE_RECORD_HOST_IPV4ADDR
  $PERL_MODULE_RECORD_HOST_IPV6ADDR
  $PERL_MODULE_RECORD_HOST
  $PERL_MODULE_RECORD_MX
  $PERL_MODULE_RECORD_PTR
  $PERL_MODULE_RECORD_SRV
  $PERL_MODULE_RECORD_TXT
  $PERL_MODULE_RESTARTSERVICESTATUS
  $PERL_MODULE_SCHEDULEDTASK
  $PERL_MODULE_SEARCH
  $PERL_MODULE_VIEW
  $PERL_MODULE_ZONE_AUTH
  $PERL_MODULE_ZONE_DELEGATED
  $PERL_MODULE_ZONE_FORWARD
  $PERL_MODULE_ZONE_STUB
  $PERL_MODULE_FIXEDADDRESS_FILE
  $PERL_MODULE_GRID_FILE
  $PERL_MODULE_IPV_FILE4ADDRESS
  $PERL_MODULE_IPV_FILE6ADDRESS
  $PERL_MODULE_IPV_FILE6FIXEDADDRESS
  $PERL_MODULE_IPV_FILE6NETWORKCONTAINER
  $PERL_MODULE_IPV_FILE6NETWORK
  $PERL_MODULE_IPV_FILE6RANGE
  $PERL_MODULE_LEASE_FILE
  $PERL_MODULE_MACFILTERADDRESS_FILE
  $PERL_MODULE_MEMBER_FILE
  $PERL_MODULE_NAMEDACL_FILE
  $PERL_MODULE_NETWORKCONTAINER_FILE
  $PERL_MODULE_NETWORK_FILE
  $PERL_MODULE_NETWORKVIEW_FILE
  $PERL_MODULE_RANGE_FILE
  $PERL_MODULE_RECORD_AAAA_FILE
  $PERL_MODULE_RECORD_A_FILE
  $PERL_MODULE_RECORD_CNAME_FILE
  $PERL_MODULE_RECORD_HOST_IPV4ADDR_FILE
  $PERL_MODULE_RECORD_HOST_IPV6ADDR_FILE
  $PERL_MODULE_RECORD_HOST_FILE
  $PERL_MODULE_RECORD_MX_FILE
  $PERL_MODULE_RECORD_PTR_FILE
  $PERL_MODULE_RECORD_SRV_FILE
  $PERL_MODULE_RECORD_TXT_FILE
  $PERL_MODULE_RESTARTSERVICESTATUS_FILE
  $PERL_MODULE_SCHEDULEDTASK_FILE
  $PERL_MODULE_SEARCH_FILE
  $PERL_MODULE_VIEW_FILE
  $PERL_MODULE_ZONE_AUTH_FILE
  $PERL_MODULE_ZONE_DELEGATED_FILE
  $PERL_MODULE_ZONE_FORWARD_FILE
  $PERL_MODULE_ZONE_STUB_FILE
  %PERL_MODULE_FILE_NAMES
  $IB_BASE_FIELDS
  $IB_CRED
  $IB_MAX_RESULTS
  $IB_FIELDS
  $IB_EMPTY_FIELD
  $IB_TRUE
  $IB_FALSE
  $IB_STRUCT_FIELDS
  $IB_STRUCT_TYPES
  $IB_RETURN_FIELDS
  $IB_RETURN_FIELDS_PLUS
  $IB_RETURN_TYPE
  $IB_READONLY_FIELDS
  $IB_SEARCHABLE_FIELDS
  $IB_SEARCHONLY_FIELDS
  $IB_USERNAME
  $IB_PASSWORD
  $IB_HOSTNAME
  $BINDING_STATE_ABANDONDED
  $BINDING_STATE_ACTIVE
  $BINDING_STATE_BACKUP
  $BINDING_STATE_DECLINED
  $BINDING_STATE_EXPIRED
  $BINDING_STATE_FREE
  $BINDING_STATE_OFFERED
  $BINDING_STATE_RELEASED
  $BINDING_STATE_RESET
  $BINDING_STATE_STATIC
  $FIELD_REF
  $FIELD_ACCESS_LIST
  $FIELD_ADDRESS
  $FIELD_ADDRESS_TYPE
  $FIELD_AGENT_CIRCUIT_ID
  $FIELD_AGENT_REMOTE_ID
  $FIELD_ALIASES
  $FIELD_ALLOW_ACTIVE_DIR
  $FIELD_ALLOW_GSS_TSIG_FOR_UNDERSCORE_ZONE
  $FIELD_ALLOW_GSS_TSIG_ZONE_UPDATES
  $FIELD_ALLOW_QUERY
  $FIELD_ALLOW_TRANSFER
  $FIELD_ALLOW_UPDATE
  $FIELD_ALLOW_UPDATE_FORWARDING
  $FIELD_ALWAYS_UPDATE_DNS
  $FIELD_APPROVAL_STATUS
  $FIELD_APPROVER
  $FIELD_APPROVER_COMMENT
  $FIELD_AUTHENTICATION_TIME
  $FIELD_AUTHORITY
  $FIELD_AUTO_CREATE_REVERSEZONE
  $FIELD_AUTOMATIC_RESTART
  $FIELD_BILLING_CLASS
  $FIELD_BINDING_STATE
  $FIELD_BLACKLIST_ACTION
  $FIELD_BLACKLIST_LOG_QUERY
  $FIELD_BLACKLIST_REDIRECT_ADDRESSES
  $FIELD_BLACKLIST_REDIRECT_TTL
  $FIELD_BLACKLIST_RULESETS
  $FIELD_BOOTFILE
  $FIELD_BOOTSERVER
  $FIELD_CANONICAL
  $FIELD_CHANGED_OBJECTS
  $FIELD_CLIENT_HOSTNAME
  $FIELD_CLIENT_IDENTIFIER_PREPEND_ZERO
  $FIELD_CLTT
  $FIELD_COMMENT
  $FIELD_CONFIGURE_FOR_DHCP
  $FIELD_CONFIGURE_FOR_DNS
  $FIELD_CONTAINS_ADDRESS
  $FIELD_COPY_XFER_TO_NOTIFY
  $FIELD_CREATE_PTR_FOR_BULK_HOSTS
  $FIELD_CREATE_PTR_FOR_HOSTS
  $FIELD_CREATE_UNDERSCORE_ZONES
  $FIELD_CUSTOM_ROOT_NAME_SERVERS
  $FIELD_DDNS_DOMAINNAME
  $FIELD_DDNS_ENABLE_OPTION_FQDN
  $FIELD_DDNS_GENERATE_HOSTNAME
  $FIELD_DDNS_HOSTNAME
  $FIELD_DDNS_SERVER_ALWAYS_UPDATES
  $FIELD_DDNS_TTL
  $FIELD_DDNS_UPDATE_FIXED_ADDRESSES
  $FIELD_DDNS_USER_OPTION81
  $FIELD_DELEGATED_TTL
  $FIELD_DELEGATE_TO
  $FIELD_DENY_ALL_CLIENTS
  $FIELD_DENY_BOOTP
  $FIELD_DHCP_CLIENT_IDENTIFIER
  $FIELD_DHCP_STATUS
  $FIELD_DISABLE
  $FIELD_DISABLE_FORWARDING
  $FIELD_DISCOVERED_DATA
  $FIELD_DISPLAY_DOMAIN
  $FIELD_DNS64_ENABLED
  $FIELD_DNS64_GROUPS
  $FIELD_DNS_ALIASES
  $FIELD_DNS_CANONICAL
  $FIELD_DNS_FQDN
  $FIELD_DNS_MAIL_EXCHANGER
  $FIELD_DNS_NAME
  $FIELD_DNS_PTRDNAME
  $FIELD_DNSSEC_ENABLED
  $FIELD_DNSSEC_EXPIRED_SIGNATURES_ENABLED
  $FIELD_DNSSEC_KEY_PARAMS
  $FIELD_DNSSEC_TRUSTED_KEYS
  $FIELD_DNSSEC_VALIDATION_ENABLED
  $FIELD_DNS_SOA_EMAIL
  $FIELD_DNS_SOA_MNAME
  $FIELD_DNS_STATUS
  $FIELD_DNS_TARGET
  $FIELD_DO_HOST_ABSTRACTION
  $FIELD_DOMAIN_NAME
  $FIELD_DOMAIN_NAME_SERVERS
  $FIELD_DUID
  $FIELD_EFFECTIVE_CHECK_NAMES_POLICY
  $FIELD_EFFECTIVE_RECORD_NAME_POLICY
  $FIELD_EMAIL_LIST
  $FIELD_ENABLE_BLACKLIST
  $FIELD_ENABLE_DDNS
  $FIELD_ENABLE_DHCP_THRESHOLDS
  $FIELD_ENABLE_EMAIL_WARNINGS
  $FIELD_ENABLE_IFMAP_PUBLISHING
  $FIELD_ENABLE_PXE_LEASE_TIME
  $FIELD_ENABLE_RFC2317_EXCLUSION
  $FIELD_ENABLE_SNMP_WARNINGS
  $FIELD_END_ADDR
  $FIELD_ENDS
  $FIELD_EXCLUDE
  $FIELD_EXECUTE_NOW
  $FIELD_EXECUTION_STATUS
  $FIELD_EXECUTION_TIME
  $FIELD_EXPIRATION_TIME
  $FIELD_EXPLODED_ACCESS_LIST
  $FIELD_EXTATTRS
  $EXTATTR_VALUE
  $FIELD_EXTERNAL_PRIMARIES
  $FIELD_EXTERNAL_SECONDARIES
  $FIELD_FAILOVER_ASSOCIATION
  $FIELD_FILTER
  $FIELD_FILTER_AAAA
  $FIELD_FILTER_AAAA_LIST
  $FIELD_FINGERPRINT
  $FIELD_FINGERPRINT_FILTER_RULES
  $FIELD_FORWARDERS
  $FIELD_FORWARDERS_ONLY
  $FIELD_FORWARDING_SERVERS
  $FIELD_FORWARD_ONLY
  $FIELD_FORWARD_TO
  $FIELD_FQDN
  $FIELD_GRID_PRIMARY
  $FIELD_GRID_PRIMARY_SHARED_WITH_MS_PARENT_D
  $FIELD_GRID_SECONDARIES
  $FIELD_GUEST_CUSTOM_FIELD1
  $FIELD_GUEST_CUSTOM_FIELD2
  $FIELD_GUEST_CUSTOM_FIELD3
  $FIELD_GUEST_CUSTOM_FIELD4
  $FIELD_GUEST_EMAIL
  $FIELD_GUEST_FIRST_NAME
  $FIELD_GUEST_LAST_NAME
  $FIELD_GUEST_MIDDLE_NAME
  $FIELD_GUEST_PHONE
  $FIELD_HARDWARE
  $FIELD_HIGH_WATER_MARK
  $FIELD_HIGH_WATER_MARK_RESET
  $FIELD_HOST
  $FIELD_HOST_NAME
  $FIELD_IGNORE_CLIENT_REQUESTED_OPTIONS
  $FIELD_IGNORE_DHCP_OPTION_LIST_REQUEST
  $FIELD_IMPORT_FROM
  $FIELD_IP_ADDRESS
  $FIELD_IPV4ADDR
  $FIELD_IPV4ADDRS
  $FIELD_IPV4_ADDRESS
  $FIELD_IPV6ADDR
  $FIELD_IPV6ADDRS
  $FIELD_IPV6PREFIX
  $FIELD_IPV6PREFIX_BITS
  $FIELD_IPV6_ADDRESS
  $FIELD_IPV6_DUID
  $FIELD_IPV6_END_PREFIX
  $FIELD_IPV6_IAID
  $FIELD_IPV6_PREFERRED_LIFETIME
  $FIELD_IPV6_PREFIX
  $FIELD_IPV6_PREFIX_BITS
  $FIELD_IPV6_START_PREFIX
  $FIELD_IS_CONFLICT
  $FIELD_IS_DEFAULT
  $FIELD_IS_DNSSEC_ENABLED
  $FIELD_IS_DNSSEC_SIGNED
  $FIELD_IS_REGISTERED_USER
  $FIELD_IS_SPLIT_SCOPE
  $FIELD_KNOWN_CLIENTS
  $FIELD_LAME_TTL
  $FIELD_LAST_QUERIED
  $FIELD_LEASE_SCAVENGE_TIME
  $FIELD_LEASE_STATE
  $FIELD_LOCKED
  $FIELD_LOCKED_BY
  $FIELD_LOGIC_FILTER_RULES
  $FIELD_LOW_WATER_MARK
  $FIELD_LOW_WATER_MARK_RESET
  $FIELD_MAC
  $FIELD_MAC_ADDRESS
  $FIELD_MAC_FILTER_RULES
  $FIELD_MAIL_EXCHANGER
  $FIELD_MASK_PREFIX
  $FIELD_MATCH_CLIENT
  $FIELD_MATCH_CLIENTS
  $FIELD_MATCH_DESTINATIONS
  $FIELD_MEMBER
  $FIELD_MEMBERS
  $FIELD_MS_AD_INTEGRATED
  $FIELD_MS_ALLOW_TRANSFER
  $FIELD_MS_ALLOW_TRANSFER_MODE
  $FIELD_MS_DDNS_MODE
  $FIELD_MS_MANAGED
  $FIELD_MS_OPTIONS
  $FIELD_MS_PRIMARIES
  $FIELD_MS_READ_ONLY
  $FIELD_MS_SECONDARIES
  $FIELD_MS_SERVER
  $FIELD_MS_SYNC_MASTER_NAME
  $FIELD_NAC_FILTER_RULES
  $FIELD_NAME
  $FIELD_NAMES
  $FIELD_NETMASK
  $FIELD_NETWORK
  $FIELD_NETWORK_ASSOCIATIONS
  $FIELD_NETWORK_CONTAINER
  $FIELD_NETWORK_VIEW
  $FIELD_NEVER_ENDS
  $FIELD_NEVER_EXPIRES
  $FIELD_NEVER_STARTS
  $FIELD_NEXT_BINDING_STATE
  $FIELD_NEXTSERVER
  $FIELD_NOTIFY_DELAY
  $FIELD_NS_GROUP
  $FIELD_NXDOMAIN_LOG_QUERY
  $FIELD_NXDOMAIN_REDIRECT
  $FIELD_NXDOMAIN_REDIRECT_ADDRESSES
  $FIELD_NXDOMAIN_REDIRECT_TTL
  $FIELD_NXDOMAIN_RULESETS
  $FIELD_OBJECTS
  $FIELD_ON_COMMIT
  $FIELD_ON_EXPIRY
  $FIELD_ON_RELEASE
  $FIELD_OPTION
  $FIELD_OPTION_FILTER_RULES
  $FIELD_OPTIONS
  $FIELD_PARENT
  $FIELD_PORT
  $FIELD_PREFERENCE
  $FIELD_PREFERRED_LIFETIME
  $FIELD_PREFIX
  $FIELD_PRIMARY_TYPE
  $FIELD_PRIORITY
  $FIELD_PROTOCOL
  $FIELD_PTRDNAME
  $FIELD_PXE_LEASE_TIME
  $FIELD_RECORD_NAME_POLICY
  $FIELD_RECORDS_MONITORED
  $FIELD_RECURSION
  $FIELD_RECYCLE_LEASES
  $FIELD_RELAY_AGENT_FILTER_RULES
  $FIELD_REPORTING_STATUS
  $FIELD_RESERVED_FOR_INFOBLOX
  $FIELD_ROOT_NAME_SERVER_TYPE
  $FIELD_RR_NOT_QUERIED_ENABLED_TIME
  $FIELD_RRSET_ORDER
  $FIELD_SCHEDULED_TIME
  $FIELD_SERVED_BY
  $FIELD_SERVER_ASSOCIATION_TYPE
  $FIELD_SERVER_HOST_NAME
  $FIELD_SET_SOA_SERIAL_NUMBER
  $FIELD_SHARED_NETWORK_NAME
  $FIELD_SOA_DEFAULT_TTL
  $FIELD_SOA_EMAIL
  $FIELD_SOA_EXPIRE
  $FIELD_SOA_MNAME
  $FIELD_SOA_NEGATIVE_TTL
  $FIELD_SOA_REFRESH
  $FIELD_SOA_RETRY
  $FIELD_SOA_SERIAL_NUMBER
  $FIELD_SORTLIST
  $FIELD_SPLIT_MEMBER
  $FIELD_SPLIT_SCOPE_EXCLUSION_PERCENT
  $FIELD_SRGS
  $FIELD_START_ADDR
  $FIELD_STARTS
  $FIELD_STATUS
  $FIELD_STUB_FROM
  $FIELD_STUB_MEMBERS
  $FIELD_STUB_MSSERVERS
  $FIELD_SUBMITTER
  $FIELD_SUBMITTER_COMMENT
  $FIELD_SUBMIT_TIME
  $FIELD_TARGET
  $FIELD_TASK_ID
  $FIELD_TEMPLATE
  $FIELD_TEXT
  $FIELD_TICKET_NUMBER
  $FIELD_TSFP
  $FIELD_TSTP
  $FIELD_TTL
  $FIELD_TYPES
  $FIELD_UID
  $FIELD_UNKNOWN_CLIENTS
  $FIELD_UPDATE_DNS_ON_LEASE_RENEWAL
  $FIELD_UPDATE_FORWARDING
  $FIELD_USAGE
  $FIELD_USE_ALLOW_ACTIVE_DIR
  $FIELD_USE_ALLOW_QUERY
  $FIELD_USE_ALLOW_TRANSFER
  $FIELD_USE_ALLOW_UPDATE
  $FIELD_USE_ALLOW_UPDATE_FORWARDING
  $FIELD_USE_AUTHORITY
  $FIELD_USE_BLACKLIST
  $FIELD_USE_BOOTFILE
  $FIELD_USE_BOOTSERVER
  $FIELD_USE_CHECK_NAMES_POLICY
  $FIELD_USE_COPY_XFER_TO_NOTIFY
  $FIELD_USE_DDNS_DOMAINNAME
  $FIELD_USE_DDNS_ENABLE_OPTION_FQDN
  $FIELD_USE_DDNS_GENERATE_HOSTNAME
  $FIELD_USE_DDNS_TTL
  $FIELD_USE_DDNS_UPDATE_FIXED_ADDRESSES
  $FIELD_USE_DDNS_USE_OPTION81
  $FIELD_USE_DELEGATED_TTL
  $FIELD_USE_DENY_BOOTP
  $FIELD_USE_DNS64
  $FIELD_USE_DNSSEC
  $FIELD_USE_DNSSEC_KEY_PARAMS
  $FIELD_USE_DOMAIN_NAME
  $FIELD_USE_DOMAIN_NAME_SERVERS
  $FIELD_USE_EMAIL_LIST
  $FIELD_USE_ENABLE_DDNS
  $FIELD_USE_ENABLE_DHCP_THRESHOLDS
  $FIELD_USE_ENABLE_IFMAP_PUBLISHING
  $FIELD_USE_EXTERNAL_PRIMARY
  $FIELD_USE_FILTER_AAAA
  $FIELD_USE_FOR_EA_INHERITANCE
  $FIELD_USE_FORWARDERS
  $FIELD_USE_GRID_ZONE_TIMER
  $FIELD_USE_IGNORE_CLIENT_REQUESTED_OPTIONS
  $FIELD_USE_IGNORE_DHCP_OPTION_LIST_REQUEST
  $FIELD_USE_IMPORT_FROM
  $FIELD_USE_KNOWN_CLIENTS
  $FIELD_USE_LAME_TTL
  $FIELD_USE_LEASE_SCAVENGE_TIME
  $FIELD_USE_NEXTSERVER
  $FIELD_USE_NOTIFY_DELAY
  $FIELD_USE_NXDOMAIN_REDIRECT
  $FIELD_USE_OPTIONS
  $FIELD_USE_PREFERRED_LIFETIME
  $FIELD_USE_PXE_LEASE_TIME
  $FIELD_USE_RECORD_NAME_POLICY
  $FIELD_USE_RECURSION
  $FIELD_USE_RECYCLE_LEASES
  $FIELD_USERNAME
  $FIELD_USE_ROOT_NAME_SERVER
  $FIELD_USE_SOA_EMAIL
  $FIELD_USE_SOA_MNAME
  $FIELD_USE_SORTLIST
  $FIELD_USE_TTL
  $FIELD_USE_UNKNOWN_CLIENTS
  $FIELD_USE_UPDATE_DNS_ON_LEASE_RENEWAL
  $FIELD_USE_VALID_LIFETIME
  $FIELD_USE_ZONE_ASSOCIATIONS
  $FIELD_USING_SRG_ASSOCIATIONS
  $FIELD_VALID_LIFETIME
  $FIELD_VARIABLE
  $FIELD_VIEW
  $FIELD_WEIGHT
  $FIELD_ZONE
  $FIELD_ZONE_ASSOCIATIONS
  $FIELD_ZONE_FORMAT
  $FIELD_ZONE_NOT_QUERIED_ENABLED_TIME
  $SEARCH_PARM_CASE_INSENSATIVE
  $SEARCH_PARM_EQUAL
  $SEARCH_PARM_GT
  $SEARCH_PARM_NEGATIVE
  $SEARCH_PARM_LT
  $SEARCH_PARM_REGEX
  $TYPE_BOOL
  $TYPE_EXTATTRS
  $TYPE_INT
  $TYPE_MEMBERS
  $TYPE_MS_OPTIONS
  $TYPE_MS_SERVER
  $TYPE_OPTIONS
  $TYPE_STRING
  $TYPE_STRING_ARRAY
  $TYPE_STRUCT_ADDRESSAC
  $TYPE_STRUCT_CHANGEDOBJECT
  $TYPE_STRUCT_DHCPMEMBER
  $TYPE_STRUCT_DHCPOPTION
  $TYPE_STRUCT_DISCOVERYDATA
  $TYPE_STRUCT_DNSSECKEYPARAMS
  $TYPE_STRUCT_DNSSECTRUSTEDKEY
  $TYPE_STRUCT_EXCLUSIONRANGE
  $TYPE_STRUCT_EXTSERVER
  $TYPE_STRUCT_FILTERRULE
  $TYPE_STRUCT_FORWARDINGMEMBERSERVER
  $TYPE_STRUCT_LOGICFILTERRULE
  $TYPE_STRUCT_MEMBERSERVER
  $TYPE_STRUCT_MSDHCPOPTION
  $TYPE_STRUCT_MSDHCPSERVER
  $TYPE_STRUCT_SORTLIST
  $TYPE_STRUCT_TSIGAC
  $TYPE_STRUCT_ZONEASSOCIATION
  $TYPE_TIMESTAMP
  $TYPE_UINT
  $TYPE_UNKNOWN
  $TYPE_ZONE_ASSOCIATIONS
);

# ------------------------------------------------------
sub URL_PARM_EXISTS {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;

    return defined $_PARM_NAME{$u};
}

# ------------------------------------------------------
sub URL_FIELD_EXISTS {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;

    return defined $_FIELD_NAME{$u};
}

# ------------------------------------------------------
sub URL_NAME_FIELD_EXISTS {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;

    return defined $_NAME_FIELD{$u};
}

# ------------------------------------------------------
sub URL_MODULE_EXISTS {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;

    return defined $_MODULE_OBJ_NAME{$u};
}

# ------------------------------------------------------
sub URL_NAME_MODULE_EXISTS {
    my ($u) = @_;

    defined $u || LOG_FATAL;
    $u ne '' || LOG_FATAL " " . @_;

    return defined $_NAME_MODULE_OBJ{$u};
}

# ------------------------------------------------------
sub URL_REF_MODULE_EXISTS {
    my ($u) = @_;
    my $name;

    defined $u || LOG_FATAL;
    $u ne '' || LOG_FATAL " " . @_;

    if ( defined( $name = ( split( /\//, $u ) )[0] ) ) {
        return URL_NAME_MODULE_EXISTS($name);
    }
    else {
        return 0;
    }
}

# ------------------------------------------------------
sub URL_SEARCH_EXISTS {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    return defined $_SEARCH_NAME{$u};
}

# ------------------------------------------------------
sub URL_PARM_NAME {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_PARM_NAME{$u} ) { confess; }

    return $_PARM_NAME{$u};

}

# ------------------------------------------------------
sub URL_FIELD_NAME {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_FIELD_NAME{$u} ) { confess; }
    if ( !defined $_FIELD_TYPE{$u} ) { confess; }

    return $_FIELD_NAME{$u};

}

# ------------------------------------------------------
sub URL_FIELD_TYPE {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_FIELD_NAME{$u} ) { confess "FIELD:$u"; }
    if ( !defined $_FIELD_TYPE{$u} ) { confess "FIELD:$u"; }

    return $_FIELD_TYPE{$u};

}

# ------------------------------------------------------
sub URL_NAME_FIELD {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_NAME_FIELD{$u} ) { confess "Field Name:'$u' Not found\n"; }

    return $_NAME_FIELD{$u};

}

# ------------------------------------------------------
sub URL_MODULE_NAME {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_MODULE_OBJ_NAME{$u} ) { confess MYNAMELINE . "No Module named: $u"; }

    return $_MODULE_OBJ_NAME{$u};
}

# ------------------------------------------------------
sub URL_REF_MODULE_NAME {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;

    # my $module = URL_MODULE_NAME( ( split( /\//, $u ) )[0] );
    my $module = ( split( /\//, $u ) )[0];

    # URL_NAME_MODULE_EXISTS( $module );

    return $module;
}

# ------------------------------------------------------
sub URL_NAME_MODULE {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_NAME_MODULE_OBJ{$u} ) { confess; }

    return $_NAME_MODULE_OBJ{$u};

}

# ------------------------------------------------------
sub URL_SEARCH_NAME {
    my ($u) = @_;

    ( !defined $u || $u eq '' || ref($u) ne '' ) && LOG_FATAL;
    if ( !defined $_SEARCH_NAME{$u} ) { confess; }

    return $_SEARCH_NAME{$u};

}

# ------------------------------------------------------
sub VERIFY_TIMESTAMP {
    my ($t) = @_;
    my $ret = 0;

    ( !defined $t || $t eq '' || ref($t) ne '' ) && LOG_FATAL;

    LOG_DEBUG2 "TIMESTAMP '$t'";

    $ret;

}

# ------------------------------------------------------
sub PRINT_MYNAME {
    my ($a) = @_;
    my $ret = '';

    $ret = ( ( caller(1) )[3] );
    $ret .= $a if ( defined $a );
    $ret;
}

# ------------------------------------------------------
sub PRINT_MYLINE {
    my ($a) = @_;
    my $ret = '';

    $ret = ( ( caller(1) )[2] );
    $ret .= $a if ( defined $a );
    $ret;
}

# ------------------------------------------------------
sub PRINT_MYNAMELINE {
    my ($a) = @_;
    my $ret = '';

    if ( defined caller(1) ) {
        $ret = ( ( ( caller(1) )[3] ) . ':' . ( ( caller(0) )[2] ) );
    }
    else {
        $ret = ( ( ( (caller)[1] ) . ':' . ( (caller)[2] ) ) );
    }

    $ret .= " $a" if ( defined $a );
    $ret;
}

# ------------------------------------------------------
sub MYNAME { ( ( caller(1) )[3] ) . ' ' }

# ------------------------------------------------------
sub MYLINE { ( ( caller(1) )[2] ) . ' ' }

# ------------------------------------------------------
sub MYNAMELINE {
    if ( defined caller(1) ) {
        ( ( ( caller(1) )[3] ) . ':' . ( ( caller(0) )[2] ) . " " );
    }
    else {
        ( ( (caller)[1] ) . ':' . ( (caller)[2] ) ) . " ";
    }
}

# ------------------------------------------------------
# ------------------------------------------------------
sub LOG_URL {
    if ( $_LOGGING_LEVEL >= $_LOG_URL_LEVEL ) { _LOG( $LOG_ENTER, @_ ); }
}

# ------------------------------------------------------
sub LOG_ENTER_SUB {
    if ( $_LOGGING_LEVEL >= $_LOG_SUB_ROUTINE_LEVEL ) { _LOG( $LOG_ENTER, @_ ); }
}

# ------------------------------------------------------
sub LOG_EXIT_SUB {
    if ( $_LOGGING_LEVEL >= $_LOG_SUB_ROUTINE_LEVEL ) { _LOG( $LOG_EXIT, @_ ); }
}

# ------------------------------------------------------
# DEBUG4 Used for Dumper output (Heavy Duty Debugging)
# ------------------------------------------------------
sub LOG_DEBUG4 {
    if ( $_LOGGING_LEVEL >= $_LOG_DEBUG4 ) { _LOG( $LOG_DEBUG4, @_ ); }
}

# ------------------------------------------------------
# DEBUG3 Logs all subroutines (Large amounts of output)
# ------------------------------------------------------
sub LOG_DEBUG3 {
    if ( $_LOGGING_LEVEL >= $_LOG_DEBUG3 ) { _LOG( $LOG_DEBUG3, @_ ); }
}

# ------------------------------------------------------
# DEBUG2
# ------------------------------------------------------
sub LOG_DEBUG2 {
    if ( $_LOGGING_LEVEL >= $_LOG_DEBUG2 ) { _LOG( $LOG_DEBUG2, @_ ); }
}

# ------------------------------------------------------
# DEBUG1
# ------------------------------------------------------
sub LOG_DEBUG1 {
    if ( $_LOGGING_LEVEL >= $_LOG_DEBUG1 ) { _LOG( $LOG_DEBUG1, @_ ); }
}

# ------------------------------------------------------
# DEBUG0
# ------------------------------------------------------
sub LOG_DEBUG0 {
    if ( $_LOGGING_LEVEL >= $_LOG_DEBUG0 ) { _LOG( $LOG_DEBUG0, @_ ); }
}

# ------------------------------------------------------
# INFO
# ------------------------------------------------------
sub LOG_INFO {
    if ( $_LOGGING_LEVEL >= $_LOG_INFO ) { _LOG( $LOG_INFO, @_ ); }
}

# ------------------------------------------------------
# WARNING
# ------------------------------------------------------
sub LOG_WARN {
    if ( $_LOGGING_LEVEL >= $_LOG_WARN ) { _LOG( $LOG_WARN, @_ ); }
}

# ------------------------------------------------------
# ERROR
# ------------------------------------------------------
sub LOG_ERROR {
    if ( $_LOGGING_LEVEL >= $_LOG_ERROR ) { _LOG( $LOG_ERROR, @_ ); }
}

# ------------------------------------------------------
# FATAL - Kills the program in its tracks
# ------------------------------------------------------
sub LOG_FATAL {
    _LOG( $LOG_FATAL, @_ );
    confess;
}

# ------------------------------------------------------
sub _LOG {
    my ( $level, $msg ) = @_;
    my $caller = '';
    my $spaces = '';

    defined $_LOG_LEVEL{$level} || confess "LEVEL NOT DEFINED: '$level'";

    if( $_SUB_LEVEL > 20 ) { confess; }

    if ( $_LOG_LEVEL{$level} <= $_LOGGING_LEVEL || !$_LOG_LEVEL{$level} ) {

        if ( $level eq $LOG_ENTER ) {
            $spaces = '>' x $_SUB_LEVEL++;
        }
        elsif ( $level eq $LOG_EXIT ) {
            $spaces = '<' x --$_SUB_LEVEL;
        }
        else {
            $spaces = ' ' x $_SUB_LEVEL;
        }
        $spaces .= '|';

        if ( defined caller(2) ) {
            if ( ( caller(2) )[3] eq '(eval)' ) {
                $caller = '{' . ( ( ( caller(3) )[3] ) . ':' . ( ( caller(2) )[2] ) ) . '}';
            }
            else {
                $caller = ( ( ( caller(2) )[3] ) . ':' . ( ( caller(1) )[2] ) );
            }
        }
        else {
            $caller = ( ( ( (caller)[1] ) . ':' . ( (caller)[2] ) ) );
        }

        # $msg = $spaces . ( ( caller(1) )[3] ) . ':' . ( ( caller(1) )[2] ) . ' ' . (( defined $msg ) ? $msg : '' );
        # $msg = $spaces . ( ( caller(2) )[3] ) . ':' . ( ( caller(2) )[2] ) . ' ' . (( defined $msg ) ? $msg : '' );
        # $msg = $spaces . ( ( caller(3) )[3] ) . ':' . ( ( caller(3) )[2] ) . ' ' . (( defined $msg ) ? $msg : '' );
    }

    print "$level " . $spaces . $caller . ' ' . ( ( defined $msg && $msg ne '' ) ? $msg : '' ) . "\n";
}

# ------------------------------------------------------
sub SET_LOGGING {
    my ($D) = @_;

    defined $_LOG_LEVEL{$D} || confess "LEVEL NOT DEFINED: '$D'";
    $_LOGGING_LEVEL = $_LOG_LEVEL{$D};

}

1;
