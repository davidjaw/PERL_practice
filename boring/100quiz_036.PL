# 求n之內的素數(質數)
use v5.18.2;
my @prime;
print 'Enter n:';
chomp(my $max = <>);
for(1..$max){ push @prime, $_ if( prime_chk($_) ) }
say "@prime";

sub prime_chk {
	my $num = shift;
	my $cheak = 0;
	for(2..$num-1){ $cheak++ if($num % $_ == 0); }
	return 1 if $cheak == 0;
}