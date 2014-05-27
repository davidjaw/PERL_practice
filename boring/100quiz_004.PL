use v5.18.2;
# 輸入某年某月某日，判斷這一天是這一年的第幾天？
my %year = (
	B => 31,
	M => 30,
	T => 28,
);
my @month = qw/B T B M B M B B M B M B/;
say 'Enter date: mounth/date';
print 'Enter: ';
chomp( my $date = <> );
if($date =~ /^(\d+)\/(\d+)$/){
	my $mth = $1;
	my $day = $2;
	my $total += $day;
	while($mth > 1){
		$total += $year{$month[$mth-2]};
		$mth --;
	}
	say $total;
} else { say 'Wrong input!'; }
