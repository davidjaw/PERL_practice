use v5.18.2;
package dav;

sub new {
    my $class = shift;
    my $self = {
        alph => shift,
        code => shift,
    };
    $self->{alph} = join("", ("a" .. "z"));
    $self->{code} = random(26);
    bless $self, $class;
    return $self;
}

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
sub cs_hash {
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
sub random {
	my ($maxnum, $amount) = @_;
	my %mark;
	$amount = 1 if($amount == undef);
	$maxnum = 100 if($maxnum == undef);
	for(0..$amount-1){
		my $num = int ( rand $maxnum);
		while($mark{$num} == defined){ $num = int ( rand $maxnum); }
		$mark{$num}++;
	}
	return map $_, keys %mark;
}
1;