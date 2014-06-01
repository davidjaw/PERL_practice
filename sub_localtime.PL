use 5.18.2;
my ($day, $month, $date, $time, $year) = split ' ',localtime;
say "$year年$month月$date日 $time, 星期$day";
