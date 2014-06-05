
#!/usr/bin/perl

package IBWAPI::Record_Host;
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
    $FIELD_ALIASES           => 1,
    $FIELD_COMMENT           => 1,
    $FIELD_CONFIGURE_FOR_DNS => 1,
    $FIELD_DISABLE           => 1,
    $FIELD_DNS_ALIASES       => 1,
    $FIELD_DNS_NAME          => 1,
    $FIELD_EXTATTRS          => 1,
    $FIELD_IPV4ADDR          => 1,
    $FIELD_IPV6ADDR          => 1,
    $FIELD_NAME              => 1,
    $FIELD_RRSET_ORDER       => 1,
    $FIELD_TTL               => 1,
    $FIELD_USE_TTL           => 1,
    $FIELD_VIEW              => 1,
    $FIELD_ZONE              => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_IPV4ADDR => 1,
    $FIELD_IPV6ADDR => 1,
    $FIELD_NAME     => 1,
    $FIELD_VIEW     => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
    $FIELD_NAME => 1,
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_DNS_NAME => 1,
    $FIELD_ZONE     => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_COMMENT => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_NAME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_REGEX => 1,
    },
    $FIELD_VIEW => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_ZONE => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
    $FIELD_ALIASES  => 1,
    $FIELD_IPV4ADDR => 1,
    $FIELD_IPV6ADDR => 1,
    $FIELD_MAC      => 1,
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
