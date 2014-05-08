#!/usr/bin/perl

package IBRecord;
use FindBin;
use lib "$FindBin::Bin";
use IBFields;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use JSON;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
);

# ---------------------------
# new()
# ---------------------------
sub new() {
    my ( $class, $json ) = @_;
    my $self = \%h;


    bless $self, $class;

    $self;
}


1;
