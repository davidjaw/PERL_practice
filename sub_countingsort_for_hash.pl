#!/bin/user/perl-w
%hash = (
	"a" =>1,
	"b" =>1,
	"c" =>2,
	"d" =>1,
	"e" =>1,
	"f" =>1,
	"g" =>1,
	"h" =>2,
	'aaa$a#b!'=>3,
);
@out = cs(\%hash);
print "After sort:\n";
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
		@{$hash{$num}} = sort (@{$hash{$num}});
		if ($i < 2){ $AUX[$num]++;  } else { $AUX[$num] += $i; }
	}
	for my $i (1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (keys %hash){
		for my $value (@{$hash{$i}}){
			my $reg = $AUX[$i] - 1;
			$sort[$reg] = $value;
			$AUX[$i]--;
			print "reg=$reg\n";
		}
	}
	# shift @sort;
	return reverse @sort;
}
