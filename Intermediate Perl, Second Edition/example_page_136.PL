#!/usr/bin/perl
use v5.18;
print 'Enter a pattern: ';
chomp(my $pattern = <>);

say "Enter some lines:";
while(<>){
	print "Mach: $_" if( eval { m/$pattern/ });
	die "There was a regex problem: $@\n" if($@);
}

# while will execute when STDIN, eval will detect error at $pattern.

