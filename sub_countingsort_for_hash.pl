#!/usr/bin/perl -w
use v5.18.2;
sub cs {
	my $in_ref = shift;
	my @in = %$in_ref;
	my %hash;
	my @AUX;
	my @sort;
	for(my $i = 0; $i < $#in; $i = $i + 2){
		push @{$hash{$in[$i+1]}}, $in[$i];
	}
	for my $num (keys %hash){
		my $i = @{$hash{$num}};
		@{$hash{$num}} = sort (@{$hash{$num}});
		if ($i < 2){ $AUX[$num]++;  } else { $AUX[$num] += $i; }
	}
	for my $i (1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (keys %hash){
		for my $value (@{$hash{$i}}){
			$sort[$AUX[$i]-1] = $value;
			$AUX[$i]--;
		}
	}
	return reverse @sort;
}
