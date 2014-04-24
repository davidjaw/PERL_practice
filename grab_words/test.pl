#!/usr/bin/perl
${$voc{'keyword'}}{'times'}++;
print $voc{'keyword'}->{'times'},"\n";
$voc{'keyword'}->{'time2'}++;
print ${$voc{'keyword'}}{'time2'};