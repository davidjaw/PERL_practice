#!/usr/vin/perl
use v5.18.2;
my $pattern = qr/(?:\w+)?\s\d(\w+)/;
my @input = (
	"31313a 2212fff",
	" 2second",
	"aaaba 1first",
	"aaaa 2dd",
);
for(@input){ say $1 if($_ =~ $pattern); }
