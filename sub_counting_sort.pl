#!/bin/user/perl-w
@in = qw/100 154 99 4 4 4 845 55 12 334 4 7 5/;
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
	for my $i(1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (@unsort){
		my $reg = $AUX[$i] - 1;
		$sort[$reg] = $i;
		$AUX[$i]--;
	}
	return reverse @sort;
}