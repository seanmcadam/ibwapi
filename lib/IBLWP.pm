#!/usr/bin/perl

package IBLWP;
use FindBin;
use lib "$FindBin::Bin";
use IBConsts;
use Data::Dumper;
use Carp;
use JSON;
use LWP;
use LWP::UserAgent;
use HTTP::Request;
use Readonly;
use strict;

# ---------------------------
# PROTOTYPES
# ---------------------------

# ---------------------------
# READONLY VARIABLES
# ---------------------------
Readonly our $_CONTENT  => '_CONTENT';
Readonly our $_ERROR    => '_ERROR';
Readonly our $_JSON_OBJ   => '_JSON_OBJ';
Readonly our $_RESULT_OBJ   => '_RESULT_OBJ';
Readonly our $_REQUEST_OBJ  => '_REQUEST_OBJ';
Readonly our $_UA       => '_UA';
Readonly our $_UA_AGENT => 'IBWAPI/$IB_VERSION ';

# ---------------------------
# EXPORTS
# ---------------------------

# ---------------------------
# new()
# ---------------------------
sub new() {
    my ( $class, $parm_ref ) = @_;
    my %h;
    my $self = \%h;

    if ( !defined( $h{$_JSON_OBJ} = JSON->new() ))  { confess; }
    if ( !defined( $h{$_UA} = LWP::UserAgent->new() )) { confess; }
    $h{$_UA}->agent($_UA_AGENT);
    $h{$_RESULT_OBJ}  = undef;
    $h{$_REQUEST_OBJ} = undef;
    $h{$_CONTENT} = undef;
    $h{$_ERROR}   = undef;

    bless $self, $class;
    $self;
}

# ---------------------------
# get()
# ---------------------------
sub get {
    my ( $self, $url ) = @_;

    $self->{$_CONTENT} = undef;
    $self->{$_ERROR}   = undef;
    $self->{$_REQUEST_OBJ} = HTTP::Request->new( GET => $url );

    $self->{$_RESULT_OBJ} = $self->{$_UA}->request( $self->{_REQUEST_OBJ} );

    if ( $self->{$_RESULT_OBJ}->is_success ) {
        $self->{$_CONTENT} = decode_json( $self->{$_RESULT_OBJ}->content );
        return 1;
    }
    else {
        $self->{$_CONTENT} = decode_json( $self->{$_RESULT_OBJ}->content );
        $self->{$_ERROR} = $self->{$_RESULT_OBJ}->status_line;
        return 0;
    }
}

# ---------------------------
# get_content()
# ---------------------------
sub get_content {
    my ($self) = @_;
    if ( defined $self->{$_CONTENT} ) {
        return $self->{$_CONTENT};
    }

    confess "No Content defined\n";

}

# ---------------------------
# get_error()
# ---------------------------
sub get_error {
    my ($self) = @_;
    if ( defined $self->{$_ERROR} ) {
        return $self->{$_ERROR};
    }

    confess "No ERROR defined\n";

}

1;

