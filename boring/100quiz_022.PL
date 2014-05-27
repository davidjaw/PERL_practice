# 兩個乒乓球隊進行比賽，各出三人。甲隊為a,b,c三人，乙隊為x,y,z三人。已抽籤決定比賽名單。
# 有人向隊員打聽比賽的名單。a說他不和x比，c說他不和x,z比，請編程式找出三隊賽手的名單。
use v5.18.2;
my @team_a = qw/c a b/;
my @team_b = qw/x y z/;
my %fight;
for my $a(@team_a){
	for my $b(@team_b){
		push @{$fight{$a}}, $b;
	}
}
for (@{$fight{a}}){ $_ = undef if $_ eq 'x'; }
for (@{$fight{c}}){ $_ = undef if $_ eq 'x' || $_ eq 'z'; }
for my $k(sort keys %fight){ 
	for(@{$fight{$k}}){
		say "$k vs $_" if ($_ ne '');
	}	
}
my @done;

# this failed...