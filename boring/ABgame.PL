#!usr/bin/perl
use v5.18.2;
say "Number guessing game.";
say "Enter 4 bits to guess.";
my $game;
my @answer = random(10,4);
while($game != 1){
BEGINNING:
	print 'Enter:';
	chomp(my $guess = <>);
	if($guess =~ /^(\d)(\d)(\d)(\d)$/){ 
		my $A; my $B; my $break;
		my @guess = split '', $guess;
		for my $outter(@guess){ for(@guess){ $break++ if( $outter == $_ ) } }
		say 'don\'t type the same number!' if $break > 4;
		goto BEGINNING if $break > 4;
		for(0..3){ $A++ if($guess[$_] == $answer[$_]); }
		for my $i(0..3){ for(0..3){ $B++ if($guess[$_] == $answer[$i] ); } }
		$B = 0 if $B == undef;
		$A = 0 if $A == undef;
		$B = $B - $A if $B > 0;
		say $A,"A",$B,"B" if $A < 4;
		say "Currect, answer is ",@answer if $A == 4;
		$game = 1 if $A == 4;
	} elsif ($guess eq 'cheat') { say @answer;
	} else { say 'wrong form!'; }
}
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