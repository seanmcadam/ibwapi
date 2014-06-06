#!/usr/bin/perl

package IBWAPI::Macfilteraddress;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;
use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly::Hash our %_FIELDS => (
    $FIELD_AUTHENTICATION_TIME   => 1,
    $FIELD_COMMENT               => 1,
    $FIELD_EXPIRATION_TIME       => 1,
    $FIELD_EXTATTRS              => 1,
    $FIELD_FILTER                => 1,
    $FIELD_GUEST_CUSTOM_FIELD1   => 1,
    $FIELD_GUEST_CUSTOM_FIELD2   => 1,
    $FIELD_GUEST_CUSTOM_FIELD3   => 1,
    $FIELD_GUEST_CUSTOM_FIELD4   => 1,
    $FIELD_GUEST_EMAIL           => 1,
    $FIELD_GUEST_FIRST_NAME      => 1,
    $FIELD_GUEST_LAST_NAME       => 1,
    $FIELD_GUEST_MIDDLE_NAME     => 1,
    $FIELD_GUEST_PHONE           => 1,
    $FIELD_IS_REGISTERED_USER    => 1,
    $FIELD_MAC                   => 1,
    $FIELD_NEVER_EXPIRES         => 1,
    $FIELD_RESERVED_FOR_INFOBLOX => 1,
    $FIELD_USERNAME              => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_AUTHENTICATION_TIME   => 1,
    $FIELD_COMMENT               => 1,
    $FIELD_EXPIRATION_TIME       => 1,
    $FIELD_FILTER                => 1,
    $FIELD_GUEST_CUSTOM_FIELD1   => 1,
    $FIELD_GUEST_CUSTOM_FIELD2   => 1,
    $FIELD_GUEST_CUSTOM_FIELD3   => 1,
    $FIELD_GUEST_CUSTOM_FIELD4   => 1,
    $FIELD_GUEST_EMAIL           => 1,
    $FIELD_GUEST_FIRST_NAME      => 1,
    $FIELD_GUEST_LAST_NAME       => 1,
    $FIELD_GUEST_MIDDLE_NAME     => 1,
    $FIELD_GUEST_PHONE           => 1,
    $FIELD_IS_REGISTERED_USER    => 1,
    $FIELD_MAC                   => 1,
    $FIELD_NEVER_EXPIRES         => 1,
    $FIELD_RESERVED_FOR_INFOBLOX => 1,
    $FIELD_USERNAME              => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_FILTER => 1,
    $FIELD_MAC    => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_IS_REGISTERED_USER => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_AUTHENTICATION_TIME => {
        $SEARCH_PARM_NEGATIVE => 1,
        $SEARCH_PARM_EQUAL    => 1,
        $SEARCH_PARM_GT       => 1,
        $SEARCH_PARM_LT       => 1,
    },
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_EXPIRATION_TIME => {
        $SEARCH_PARM_NEGATIVE => 1,
        $SEARCH_PARM_EQUAL    => 1,
        $SEARCH_PARM_GT       => 1,
        $SEARCH_PARM_LT       => 1,
    },
    $FIELD_FILTER => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_GUEST_CUSTOM_FIELD1 => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_CUSTOM_FIELD2 => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_CUSTOM_FIELD3 => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_CUSTOM_FIELD4 => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_EMAIL => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_FIRST_NAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_LAST_NAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_MIDDLE_NAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_GUEST_PHONE => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_MAC => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_NEVER_EXPIRES => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_RESERVED_FOR_INFOBLOX => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_USERNAME => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
);


1;
