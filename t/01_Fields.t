#!/usr/bin/perl

use strict;
use warnings;
use IBConsts;
use Test::More tests => 1382 ;

ok( defined %IBConsts::_FIELD_NAME, "FIELD_NAME" );
ok( defined %IBConsts::_FIELD_TYPE, "FIELD_TYPE" );

foreach my $f (sort(keys(%IBConsts::_FIELD_NAME))){
	my $d = $IBConsts::_FIELD_NAME{$f};
	ok( defined $IBConsts::_NAME_FIELD{$d} && $IBConsts::_NAME_FIELD{$d} eq $f, "MISSING NAME_FIELD: $f -> $d" );
}

foreach my $f (sort(keys(%IBConsts::_NAME_FIELD))){
	my $d = $IBConsts::_NAME_FIELD{$f};
	ok( defined $IBConsts::_FIELD_NAME{$d} && $IBConsts::_FIELD_NAME{$d} eq $f, "MISSING NAME_FIELD: $f -> $d" );
}

foreach my $f (sort(keys(%IBConsts::_FIELD_NAME))){
	print $f . "\n";
	ok( defined $IBConsts::_FIELD_TYPE{$f}, "MISSING TYPE FIELD: $f" );
}

foreach my $f (sort(keys(%IBConsts::_FIELD_TYPE))){
	print $f . "\n";
	ok( defined $IBConsts::_FIELD_NAME{$f}, "MISSING NAME FIELD: $f" );
}

