# 求1+2!+3!+…+20!的和
use v5.18.2;
my $total;
my @num;
say 'Enter max: ';
chomp(my $max = <>);
for(1..$max){ $num[$_] = $_; }
for my $num(1..$max){
	my $total_num = 1;
	while($num > 1){
		$total_num = $total_num * $num;
		$num--;
	}
	$total += $total_num;
}
say $total;