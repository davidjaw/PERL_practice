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

# when you use '()', $& won't care if there's any word inside '()'
# and if you put ?: inside '()', the $1 won't be at here↓ but at  ↓
#												 qr/(?:\w+)?\s\d(\w+)/;
# output:
# 212fff
# second
# first
# dd