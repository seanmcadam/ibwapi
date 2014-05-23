#!/usr/bin/perl

package IBStruct;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------
sub _verify_field_exists;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $IB_STRUCT_FIELD => 'IB_STRUCT_FIELD';
Readonly our $IB_STRUCT_TYPE  => 'IB_STRUCT_TYPE';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $IB_STRUCT_FIELD
  $IB_STRUCT_TYPE
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    PRINT_MYNAMELINE if $DEBUG;

    $h{$IB_STRUCT_FIELD} = undef;
    $h{$IB_STRUCT_TYPE}  = undef;

    bless $self, $class;

    $self;
}

# ---------------------------
sub _verify_filed_exists {
    my ( $self, $f ) = @_;

    if ( !defined $f ) { confess; }

    if ( !defined $self->{$IB_STRUCT_FIELD}->{$f} ) { confess; }

    1;

}

1;
