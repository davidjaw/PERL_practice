#!/usr/vin/perl
use v5.18.2;
my @patterns = (
	qr/(?:Willie )?Gilligan/,
	qr/Mary Ann/,
	qr/Ginger/,
	qr/(?:The )?Professor/,
	qr/Skipper/,
	qr/Mrs?. Howell/,
);

my $name = 'Ginger';
say "Match $&!" if $name ~~ @patterns;
