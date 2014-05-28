# 一個偶數總能表示為兩個素數之和。編寫一個程序，要求用戶輸入任何一個偶數，及輸出所有可以加總到該偶數的兩個質數的可能
use v5.18.2;
print 'Enter a Even: ';
chomp (my $even = <>);
die "Don\'t enter Odd number!\n" unless $even % 2 == 0;
my @out;
my @prime = prime($even);
for my $outter(@prime){
	for(@prime){
		if($outter != $_){
			my $sum = $outter + $_;
			push @out, ($_, $outter) if($sum == $even);
		}
	}
}
for(my $i = 0; $i < $#out/2; $i = $i + 2){ # 因為@out裡面成對，所以用$i < $#out/2
	say "$out[$i] + $out[$i+1] = $even";
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