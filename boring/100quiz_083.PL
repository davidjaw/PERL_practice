# 求0—7所能組成的八位奇數個數。
use v5.18.2;
my $total;
my $num = 10234567;
my @num = split '', $num;
while($num < 12345678){
	$total++ if($num[7] == 1 || $num[7] == 3 ||$num[7] == 5 ||$num[7] == 7 );
	@num = &add(@num);
	$num = join '', @num;
}
say $total;
sub add {
	my @in = @_;
	$in[7]++;
	if($in[7] == 8){ $in[7] = 0; $in[6]++; }
	if($in[6] == 8){ $in[6] = 0; $in[5]++; }
	if($in[5] == 8){ $in[5] = 0; $in[4]++; }
	if($in[4] == 8){ $in[4] = 0; $in[3]++; }
	if($in[3] == 8){ $in[3] = 0; $in[2]++; }
	if($in[2] == 8){ $in[2] = 0; $in[1]++; }
	if($in[1] == 8){ $in[1] = 0; $in[0]++; }
	return @in;
}