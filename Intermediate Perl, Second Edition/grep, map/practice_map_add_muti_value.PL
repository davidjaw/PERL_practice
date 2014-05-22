#!/usr/vin/perl -w
my $hash->{a}{'ST'} = 7;
$hash->{b}{'ST'} = 3;
$hash->{c}{'ST'} = 2;

@unsort_ST = map {
	my $reg = $hash->{$_}{'ST'};
	($_, $reg);
} keys %$hash;
print "$_\n" for(@unsort_ST);

#output(keys random):
# b
# 3
# c
# 2
# a
# 7