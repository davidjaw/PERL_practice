#!/usr/vin/perl
use v5.18;
our $state;
our $count = 1;
$state = sub {
	state $count;
	my $in = shift;
	$count += $in;
	say $count;
};

$state->(1);
$state->(1);
$state->(1);
say $count;

# say = print "\n";
# state = outside sub, it's value won't get undef, but can't use 
# output:
# 1
# 2
# 3
# 1