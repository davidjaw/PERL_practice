#!/bin/user/perl-w
%hash = (
	"a" => 57,
	"b" => 45,
	"c" => 95,
	"d" => 555,
	"e" => 54,
	"f" => 55,
	"g" => 51,
	"h" => 15,
);
@out = cs(\%hash);
print "\nAfter sort:\n";
print "$_ " for (@out);

sub cs {
	my $in_ref = shift;
	my @in = %$in_ref;
	my %hash = ();
	my @AUX = ();
	for($i = 0; $i < $#in; $i = $i + 2){
		my $reg = $in[$i+1];
		push @{$hash{$reg}}, $in[$i];
	}
	for my $num (keys %hash){ 
		my $i = 0;
		for(@{$hash{$num}}){ $i++; }
		if ($i != 2){ $AUX[$num]++;  } else { $AUX[$num] = $AUX[$num] + 2; }
	}
	for my $i (1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (keys %hash){
		for my $value (@{$hash{$i}}){
			my $reg = $AUX[$i] - 1;
			$sort[$reg] = $value;
		print "\nreg=$reg value=$value i=$i";
			$AUX[$i]--;
		}
	}
	return reverse @sort;
}
