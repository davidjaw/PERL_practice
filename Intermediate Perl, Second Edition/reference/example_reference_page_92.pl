#!/usr/bin/perl -w
my %provisions = (
	'The Skipper' => [qw/bule_shirt hat jaket preserver sunscreen/],
	'The professor' => [qw/sunscreen water_bottle slide_rule batteries radio/],
	'Gilligan' => [qw/red_shirt hat lucky_socks water_bottle/],
);
my @packed_light = grep @{$provisions{$_}} < 5, keys %provisions;
print "packed_light:\n";
print "$_\n" for(@packed_light);
#outgroth practice
print $provisions{Gilligan}->[3],"\n"; 					# print $provisions->{Gilligan}[3];  <= $provisions is not hash reference
my $test->{'test'} = [ qw/1 2 3 4 5 6 7/ ];				# $test is a hash reference
my @greped_test = grep @{$test->{$_}} > 5, keys %$test; # In this grep, @{$test->{$_}} means how many values it content
print "@greped_test\n";

my @all_wet = grep {
	my @items = @{ $provisions{$_} };
	grep $_ eq 'water_bottle', @items;  # this output a boolean let outter grep knows.
} keys %provisions;
print "all_wet:\n";
print "$_\n" for(@all_wet);
print "\n";
my @remapped_list = map {
	[ $_ => $provisions{$_} ];			# '=>' can also change to ','
} keys %provisions;
print "remapped_list:\n";
print "@$_\n" for(@remapped_list);
print "\n";
my @person_item_pairs = map {
	my $person = $_;
	my @items = @{ $provisions{$person} };
	map [$person => $_], @items; 
} keys %provisions;
print "person_item_pairs:\n";
print "@$_\n" for(@person_item_pairs);
#outgroth pratice
my @a = qw/dannis david jason jerry/;
my @b = qw/water food game gf book/;
my @after_colleage = map{
	$reg = $_;
	map [$reg, $_], @b;
} @a;
print "@$_\n" for(@after_colleage);
