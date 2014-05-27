# 求1+2!+3!+…+20!的和
use v5.18.2;
my $total;
for(1..20){
	my $max_num = $_;
	my $num = $max_num;
	my $num_total;
	while($max_num > 0){
		my $total = 1;
		while($num > 0){
			$total = $total * $num;
			$num--;
		}
		$max_num--;
		$num = $max_num;
		$num_total += $total;
	}
	say $num_total;
	$total += $num_total;
}
say $total;