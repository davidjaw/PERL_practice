#!/bin/usr/perl -w
my %provisions = (
	'The Skipper' => [qw/bule_shirt hat jaket preserver sunscreen/],
	'The professor' => [qw/sunscreen water_bottle slide_rule batteries radio/],
	'The Skipper' => [qw/red_shirt hat lucky_socks water_bottle/],
);

my @packed_light = grep @{$provisions{$_}}, keys %provisions;