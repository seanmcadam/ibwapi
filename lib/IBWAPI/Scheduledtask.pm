#!/usr/bin/perl

package IBWAPI::Scheduledtask;
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
    $FIELD_APPROVAL_STATUS   => 1,
    $FIELD_APPROVER          => 1,
    $FIELD_APPROVER_COMMENT  => 1,
    $FIELD_AUTOMATIC_RESTART => 1,
    $FIELD_CHANGED_OBJECTS   => 1,
    $FIELD_EXECUTE_NOW       => 1,
    $FIELD_EXECUTION_STATUS  => 1,
    $FIELD_EXECUTION_TIME    => 1,
    $FIELD_SCHEDULED_TIME    => 1,
    $FIELD_SUBMIT_TIME       => 1,
    $FIELD_SUBMITTER         => 1,
    $FIELD_SUBMITTER_COMMENT => 1,
    $FIELD_TASK_ID           => 1,
    $FIELD_TICKET_NUMBER     => 1,
);

Readonly::Hash our %_BASE_FIELDS => (
    $FIELD_APPROVAL_STATUS  => 1,
    $FIELD_EXECUTION_STATUS => 1,
    $FIELD_TASK_ID          => 1,
);

Readonly::Hash our %_REQUIRED_FIELDS => (
);

Readonly::Hash our %_READONLY_FIELDS => (
    $FIELD_APPROVER         => 1,
    $FIELD_CHANGED_OBJECTS  => 1,
    $FIELD_EXECUTION_STATUS => 1,
    $FIELD_EXECUTION_TIME   => 1,
    $FIELD_SUBMIT_TIME      => 1,
    $FIELD_SUBMITTER        => 1,
    $FIELD_TASK_ID          => 1,
    $FIELD_TICKET_NUMBER    => 1,
);

Readonly::Hash our %_SEARCHABLE_FIELDS => (
    $FIELD_APPROVAL_STATUS => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_APPROVER => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_EXECUTION_STATUS => {
        $SEARCH_PARM_EQUAL => 1,
    },
    $FIELD_EXECUTION_TIME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
    },
    $FIELD_SCHEDULED_TIME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
    },
    $FIELD_SUBMIT_TIME => {
        $SEARCH_PARM_EQUAL => 1,
        $SEARCH_PARM_GT    => 1,
        $SEARCH_PARM_LT    => 1,
    },
    $FIELD_SUBMITTER => {
        $SEARCH_PARM_EQUAL            => 1,
        $SEARCH_PARM_CASE_INSENSATIVE => 1,
        $SEARCH_PARM_REGEX            => 1,
    },
    $FIELD_TASK_ID => {
        $SEARCH_PARM_EQUAL => 1,
    },
);

Readonly::Hash our %_SEARCHONLY_FIELDS => (
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
