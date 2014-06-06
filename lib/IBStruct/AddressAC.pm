#!/usr/bin/perl

package IBStruct::AddressAC;
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
Readonly our $FIELD_ADDRESSAC_ADDRESS    => 'FIELD_ADDRESSAC_ADDRESS';
Readonly our $FIELD_ADDRESSAC_PERMISSION => 'FIELD_ADDRESSAC_PERMISSION';
Readonly our $FIELD_ADDRESSAC_ALLOW      => 'ALLOW';
Readonly our $FIELD_ADDRESSAC_DENY       => 'DENY';
Readonly our $ANY                        => 'Any';
Readonly our $_DEFAULT_PERMISSION        => $FIELD_ADDRESSAC_ALLOW;

Readonly our %_FIELDS => (
    $FIELD_ADDRESSAC_ADDRESS    => $FIELD_ADDRESSAC_ADDRESS,
    $FIELD_ADDRESSAC_PERMISSION => $FIELD_ADDRESSAC_PERMISSION,
);
Readonly our %_FIELD_TYPES => (
    $FIELD_ADDRESSAC_ADDRESS    => $TYPE_STRING,
    $FIELD_ADDRESSAC_PERMISSION => $TYPE_STRING,
);

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $FIELD_ADDRESSAC_ADDRESS
  $FIELD_ADDRESSAC_PERMISSION
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

    $self->{$FIELD_ADDRESSAC_ADDRESS}    = '';
    $self->{$FIELD_ADDRESSAC_PERMISSION} = $_DEFAULT_PERMISSION;

    defined $parm_ref->{$FIELD_ADDRESSAC_ADDRESS} || LOG_FATAL;
    _VERIFY_ADDRESS( $parm_ref->{$FIELD_ADDRESSAC_ADDRESS} ) || LOG_FATAL;

    $self->{$FIELD_ADDRESSAC_ADDRESS} = $parm_ref->{$FIELD_ADDRESSAC_ADDRESS};
    if ( defined $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} ) {
        if ( !( $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} eq $FIELD_ADDRESSAC_ALLOW
                || $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} eq $FIELD_ADDRESSAC_DENY ) ) {
            LOG_FATAL "BAD Permission " . $parm_ref->{$FIELD_ADDRESSAC_PERMISSION};
        }

        $self->{$FIELD_ADDRESSAC_PERMISSION} = $parm_ref->{$FIELD_ADDRESSAC_PERMISSION};
    }

    LOG_EXIT_SUB;
    $self;
}

# ---------------------------
sub FIELD_ADDRESSAC_ADDRESS {
    my ( $self, $a ) = @_;

    if ( defined $a ) {
        _VERIFY_ADDRESS($a) || LOG_FATAL;
        $self->{$FIELD_ADDRESSAC_ADDRESS} = $a;
    }

    $self->{$FIELD_ADDRESSAC_ADDRESS};
}

# ---------------------------
sub FIELD_ADDRESSAC_PERMISSION {
    my ( $self, $p ) = @_;

    if ( defined $p ) {
        ( $p eq $FIELD_ADDRESSAC_ALLOW || $p eq $FIELD_ADDRESSAC_DENY ) || LOG_FATAL;
        $self->{$FIELD_ADDRESSAC_PERMISSION} = $p;
    }

    $self->{$FIELD_ADDRESSAC_PERMISSION};
}

# ---------------------------
sub _VERIFY_ADDRESS {
    my ($address) = @_;

    if ( ( $address eq $ANY )
        || $address =~ /(\d{1,3}\.){3}\d{1,3}/
      ) { return 1; }

    0;

}

1;
