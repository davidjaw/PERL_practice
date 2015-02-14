#!/usr/bin/perl
# 題目：比對出兩字串最長的共同子字串
use v5.18.2;

my $str1 = 'bdeabccaac';
my $str2 = 'babdeabcabccfeavabcca';
say &getCommonStr( $str2, $str1 );

sub getCommonStr {
  my ($min, $max) = @_;
  my $outStrRef;
  ($min, $max) = ($max, $min) if length $max < length $min;
  my $len = length $min;
  for my $base(0..$len-1){
    for my $current ( 1..$len - $base ){
      my $cutStr = substr $min, $base, $current;
      if( $max =~ /$cutStr/ && $outStrRef->{outStrLength} < length $cutStr ){
        $outStrRef->{outStrLength} = length $cutStr;
        $outStrRef->{outStr} = $cutStr;
      }
    }
  }
  return $outStrRef->{outStr};
}
