# 有一分數序列：2/1，3/2，5/3，8/5，13/8，21/13…求出這個數列的前20項之和。
# 下一項的份母為上一項的份子；份子為上一項份母及份子之和
use v5.18.2;
my $total;
my $up = 2;
my $down = 1;
for(0..19){
	$total += $up / $down;
	$up = $up + $down;
	$down = $up - $down;
}
say $total;