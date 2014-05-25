#!usr/bin/perl
use v5.18.2;
sub random {
	my $maxnum = shift;
	my $amount = shift;
	my %mark;
	$amount = 1 if($amount == undef);
	$maxnum = 100 if($maxnum == undef);
	for(0..$amount-1){
		my $num = int ( rand $maxnum);
		while($mark{$num} == defined){ $num = int ( rand $maxnum); }
		$mark{$num}++;
	}
	my @out = map $_, keys %mark;
	return @out;
}