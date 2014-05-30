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
sub get_field;
sub _verify_field_exists;

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $IBS_FIELD => 'IBS_FIELD';
Readonly our $IBS_TYPE  => 'IBS_TYPE';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $IBS_FIELD
  $IBS_TYPE
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    PRINT_MYNAMELINE if $DEBUG;

    defined $parm_ref->{$IB_STRUCT_FIELDS} || LOG_FATAL;
    defined $parm_ref->{$IB_STRUCT_TYPES}  || LOG_FATAL;

# ???

    $h{$IBS_FIELD} = undef;
    $h{$IBS_TYPE}  = undef;

    bless $self, $class;

    $self;
}

# ---------------------------
sub _verify_field_exists {
    my ( $self, $f ) = @_;

    if ( !defined $f ) { confess; }

    if ( !defined $self->{$IBS_FIELD}->{$f} ) { confess; }

    1;

}

1;
