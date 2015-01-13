#!/usr/bin/perl -w
use v5.18.2;
sub cs {
	my $in_ref = shift;
	my @in = %$in_ref;
	my ($hash, @C, @sort);
	for(my $i = 0; $i < $#in; $i = $i + 2){
		push @{$hash->{$in[$i+1]}}, $in[$i];
	}
	for my $num (keys %$hash){
		my $i = @{$hash->{$num}};
		if ($i < 2){ $C[$num]++;  } else { $C[$num] = $i; }
	}
	for my $i (1..$#C){ $C[$i] += $C[$i-1] ; }
	for my $num (keys %$hash){
		for my $value (@{$hash->{$num}}){
			$sort[$C[$num]-1] = $value;
			$C[$num]--;
		}
	}
	return @sort;
}
