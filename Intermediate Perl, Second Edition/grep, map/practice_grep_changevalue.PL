#!usr/bin/perl -w
@in = qw/qaz wsx edc rfv tgb yhn ujm ik ol p/;
@out = grep {
	$_ =~ s/\w/3/g;
	$_ = $_.'change!'."\n";
	$_ =~ /\d/;
} @in;
print "@out";

#this practice shows that grep can also change array's value.
# output:
# 333change!
#  333change!
#  333change!
#  333change!
#  333change!
#  333change!
#  333change!
#  33change!
#  33change!
#  3change!