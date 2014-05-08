#!/usr/bin/perl

package IBCred;
use FindBin;
use lib "$FindBin::Bin";

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------
sub URL;

# ---------------------------
# READONLY VARIABLES
# ---------------------------

Readonly our $_DEFAULT_USERID   => 'admin';
Readonly our $_DEFAULT_PASSWORD => 'password';
Readonly our $_DEFAULT_HOSTNAME => 'localhost';
Readonly our $_HTTPS => 'https://';
Readonly our $_JSON  => 'json';
Readonly our $_URI   => '/wapi/v1.2/';
Readonly our $_IB_USERID   => 'IB_USERID';
Readonly our $_IB_PASSWORD => 'IB_PASSWORD';
Readonly our $_IB_HOSTNAME => 'IB_HOSTNAME';
Readonly our $_IB_URL      => 'IB_URL';
Readonly our $IB_USERID    => $_IB_USERID;
Readonly our $IB_PASSWORD  => $_IB_PASSWORD;
Readonly our $IB_HOSTNAME  => $_IB_HOSTNAME;

Readonly::Hash our %_PARM_NAMES => (
    $IB_USERID   => $_IB_USERID,
    $IB_PASSWORD => $_IB_PASSWORD,
    $IB_HOSTNAME => $_IB_HOSTNAME,
);

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $IB_USERID
  $IB_PASSWORD
  $IB_HOSTNAME
);

# ---------------------------
# new()
# ---------------------------
sub new() {
    my ( $class, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    $h{$_IB_USERID}   = $_DEFAULT_USERID;
    $h{$_IB_PASSWORD} = $_DEFAULT_PASSWORD;
    $h{$_IB_HOSTNAME} = $_DEFAULT_HOSTNAME;

    if ( defined $parm_ref ) {
        if ( 'HASH' ne ref($parm_ref) ) { confess Dumper $parm_ref; }
        foreach my $p ( sort( keys(%$parm_ref) ) ) {
            if ( !defined $_PARM_NAMES{$p} ) { next; }
            $h{ $_PARM_NAMES{$p} } = $parm_ref->{$p};
        }
    }

    $h{$_IB_URL} = $_HTTPS
      . $h{$_IB_USERID} . ':'
      . $h{$_IB_PASSWORD} . '@'
      . $h{$_IB_HOSTNAME}
      . $_URI;

    bless $self, $class;

    $self;
}

# ----------------------------
sub URL {
    my ($self) = @_;
    $self->{$_IB_URL};
}

1;
