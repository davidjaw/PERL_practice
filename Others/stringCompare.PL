#!/usr/bin/perl
# 題目：比對出兩字串最長的共同子字串
use v5.18.2;

my $str1 = 'bdeabccaac';
my $str2 = 'babdeabcabccfeavabcca';
my $agent;
my @splitStr1 = split '', $str1;
# 創建矩陣
for my $outWd( @splitStr1 ) {
  my $num = 0;
  for my $inWd ( split '', $str2 ){
    $agent->{$outWd}[$num] = ( $outWd eq $inWd ) ? 1 : 0;
    $num++;
  }
}
# 遞迴比對
for my $strNum ( 0..$#splitStr1 ){
  for my $num ( 0..$#{$agent->{$splitStr1[$strNum]}} ){
    next if $agent->{$splitStr1[$strNum]}[$num] == 0;
    my $search = &search( $strNum, $num );
    if( $search > $agent->{outLength}){
      $agent->{outLength} = $search;
      $agent->{outString} = substr $str1, $strNum, $search;
    }
  }
}
say $agent->{outString};

sub search {
  my ($strNum, $num) = @_;
  my $outNum;
  if ($agent->{$splitStr1[$strNum]}[$num] == 1) {
    $outNum = &search( $strNum + 1, $num + 1 );
    $outNum++;
  }
  else {
    return $outNum ;
  }
  return $outNum;
}
