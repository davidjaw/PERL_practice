use v5.18.2;
sub prime{
	my $max = shift;
	my $prime_chk = sub {
		my $num = shift;
		my $cheak = 0;
		for(2..$num-1){ $cheak++ if($num % $_ == 0); }
		return 1 if $cheak == 0;
	};
	my @prime;
	for(1..$max){ push @prime, $_ if( $prime_chk->($_) ) }
	return @prime;
}