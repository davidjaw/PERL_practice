# 求一個n*n矩陣對角線元素之和
use v5.18.2;
my $total;
print 'Enter n:';
chomp(my $max = <>);
my @square = random(100, $max ** 2);
say 'square: ';
for my $ch_line(0..$max-1){
	my $cont;
	while($cont < $max){
		print "$square[$ch_line*$max+$cont]\t";
		$cont++;
	}
	say '';
}
my $x_p = 0;
for my $y (0..$max-1){
	for my $x (0..$max-1){
		$total += $square[$x+$y*$max] if($x == $x_p || $x == $max - $x_p - 1);
	}
	$x_p++;
}
say 'total = ',$total;

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