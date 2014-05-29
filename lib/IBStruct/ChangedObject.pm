#!/usr/bin/perl

package IBStruct::ChangedObject;
use FindBin;
use lib "$FindBin::Bin/..";
use IBConsts;

use base qw( Exporter );

use Carp;
use warnings;
use Data::Dumper;
use Readonly;
use strict;

#
# READONLY OBJECT, no Updates
#

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $FIELD_CHANGEDOBJECT_ACTION      => 'FIELD_CHANGEDOBJECT_ACTION';
Readonly our $FIELD_CHANGEDOBJECT_NAME        => 'FIELD_CHANGEDOBJECT_NAME';
Readonly our $FIELD_CHANGEDOBJECT_OBJECT_TYPE => 'FIELD_CHANGEDOBJECT_OBJECT_TYPE';
Readonly our $FIELD_CHANGEDOBJECT_PROPERTIES  => 'FIELD_CHANGEDOBJECT_PROPERTIES';
Readonly our $FIELD_CHANGEDOBJECT_TYPE        => 'FIELD_CHANGEDOBJECT_TYPE';

# ---------------------------
# EXPORTS
# ---------------------------
our @EXPORT = qw (
  $FIELD_CHANGEDOBJECT_ACTION
  $FIELD_CHANGEDOBJECT_NAME
  $FIELD_CHANGEDOBJECT_OBJECT_TYPE
  $FIELD_CHANGEDOBJECT_PROPERTIES
  $FIELD_CHANGEDOBJECT_TYPE
);

# ---------------------------
# new()
# ---------------------------
sub new {
    my ( $class, $parm_ref ) = @_;
    my $self;
    if ( !defined $parm_ref ) { LOG_FATAL(PRINT_MYNAMELINE); }
    eval $EVAL_NEW_STRUCT_CODE;
    if ($@) { LOG_FATAL(PRINT_MYNAMELINE); }
    $self;
}

1;
