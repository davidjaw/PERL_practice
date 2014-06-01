use 5.18.2;
use Time::Elapse;
Time::Elapse->lapse(my $start);
for(0..555){ my $a = 1;}
say $start;

Time::Elapse->lapse(my $start);
for(0..555){ my $a = 1;}
for(0..555){ my $a = 1;}
for(0..555){ my $a = 1;}
say $start;
