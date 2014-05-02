#!/bin/user/perl-w
@in = qw/5 7 1 2 34 8 9 5 2/;
print "beforr sort \@in : \n";
print "@in";
print "\n";
open W, '>debug.txt';
@out = cs(@in);
print "After sort:\n";
print "$_ " for (@out);
sub cs {
	my @unsort = @_;
	my @AUX = ();
	my @sort = ();
	for(@unsort){ $AUX[$_]++; }
	for(0..$#AUX){ if($AUX[$_] == undef) { $AUX[$_] = 0; } }
	for my $i(1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (@unsort){
		my $reg = $AUX[$i] - 1;
		$sort[$reg] = $i;
		$AUX[$i]--;
	}
	return @sort;
}