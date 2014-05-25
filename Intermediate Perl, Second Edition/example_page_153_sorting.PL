#!usr/bin/perl
use v5.18.2;
my @castaways = qw(Gilligan Skipper Professor Ginger Mary Ann Thurston Lovey);
my @sort = map {
	($_->[0], $_->[1])
	} sort {
		$b->[1] <=> $a->[1];
	} map {
		[ $_, random(7) ]
} @castaways;
say 'sort:';
for(my $i=0;$i<$#sort;$i = $i+2){ say "$sort[$i]\($sort[$i+1]\)"; }

# my @name =                        # 閱讀方式：先 map [ $_, give() ], @castaways; 產生array1
	# map $_->[0],                  #           後將其sort,
	# sort { $b->[1] <=> $a->[1] }  #           最終再map成只有 $_->[0] 之形式
	# map [ $_, random() ],
	# @castaways;

sub random {
	my $maxnum = shift;
	my $amount = shift;
	my %mark;
	$amount = 1 if($amount == undef);
	$maxnum = 100 if($maxnum == undef);
	for(0..$amount-1){
		my $num = int ( rand $maxnum);
		while($mark{$num} == defined){ $num = int ( rand $maxnum); }
		$mark{$num}++;
	}
	my @out = map $_, keys %mark;
	return @out;
}