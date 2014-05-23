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
Readonly our $ALLOW                      => 'ALLOW';
Readonly our $DENY                       => 'DENY';
Readonly our $ANY                        => 'Any';
Readonly our $_DEFAULT_PERMISSION        => $ALLOW;

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

    my $self = $class->SUPER::new();

    PRINT_MYNAMELINE if $DEBUG;

    $self->{$IB_STRUCT_FIELD}            = \%_FIELDS;
    $self->{$IB_STRUCT_TYPE}             = \%_FIELD_TYPES;
    $self->{$FIELD_ADDRESSAC_ADDRESS}    = '';
    $self->{$FIELD_ADDRESSAC_PERMISSION} = $_DEFAULT_PERMISSION;

    if ( !defined $parm_ref ) { confess "parameters are required"; }
    if ( ref($parm_ref) ne 'HASH' ) { confess "bad parameter ref"; }
    if ( !defined $parm_ref->{$FIELD_ADDRESSAC_ADDRESS} )            { confess "Address is required"; }
    if ( !_VERIFY_ADDRESS( $parm_ref->{$FIELD_ADDRESSAC_ADDRESS} ) ) { confess "Address is required"; }

    $self->{$FIELD_ADDRESSAC_ADDRESS} = $parm_ref->{$FIELD_ADDRESSAC_ADDRESS};
    if ( defined $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} ) {
        if ( !( $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} eq $ALLOW
                || $parm_ref->{$FIELD_ADDRESSAC_PERMISSION} eq $DENY ) ) {
            confess "BAD Permission " . $parm_ref->{$FIELD_ADDRESSAC_PERMISSION};
        }

        $self->{$FIELD_ADDRESSAC_PERMISSION} = $parm_ref->{$FIELD_ADDRESSAC_PERMISSION};
    }

    bless $self, $class;

    $self;
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
