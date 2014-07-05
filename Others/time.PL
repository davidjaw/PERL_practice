use v5.18.2;
use Time::HiRes ('sleep');
	my @left;
	my @right;
	my @out;

	for my $i (0..38){
		$left[$i] .= '+' for(0..$i);
		$left[$i] .= ' ' for(0..37-$i);
		$right[$i] .= ' ' for(0..37-$i);
		$right[$i] = $right[$i].'+' for(0..$i);
		$out[$i] = $left[$i].$right[$i];
	}

for(0..100){
	push @out, reverse @out;
	for(@out){
		say $_;
		sleep(0.02);
	}
	
}