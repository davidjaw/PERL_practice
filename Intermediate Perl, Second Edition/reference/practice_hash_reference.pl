@david_item = qw/lipton pen smarthead/;
%david = qw"name david age 21 gender boy face handsome ";
$david{item} = \@david_item;
print "Status:\n";
print "\t$_: $david{$_}\n" for (keys %david);
%dennis = qw/name dennis age 21 weight 126 face morron/;
@hash = \%david , \%dennis;
$hash_ref = \@hash;
print "\n",'$hash_ref->[0]{item}[0]: ',"$hash_ref->[0]{item}[0]\n";