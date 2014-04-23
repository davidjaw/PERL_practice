#!/usr/bin/perl
$string = 'this assign is a string  yeah';
#this shows default $1, $2, $& in perl
if($string =~ /\s(\w+)\s(\w+)\s\w+/){ print "\$1: $1\n\$2: $2\n\$&: $&\n"; }
if($string =~ /\s(\w+\s\w+)\s(\w+)/){ print "\$1: $1\n\$2: $2\n\$&: $&\n"; }