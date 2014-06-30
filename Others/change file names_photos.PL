use v5.18.2;

my @filenames = glob "*.jpg";
my $cont = 0;
for my $FN(@filenames){
	say "JPG Current: ",$cont+1," / ",$#filenames+1 if(($cont+1)%5 == 0);
	open R, "$FN";
	binmode R;
	my @file = <R>;
	close (R);
	open W, ">00$cont.jpg" if $cont < 10;
	open W, ">0$cont.jpg" if($cont < 100 && $cont > 9);
	open W, ">$cont.jpg" if($cont > 99);
	binmode W;
	print W $_ for(@file);
	unlink $FN;
	$cont++;
}
@filenames = glob "*.png";
$cont = 0;
for my $FN(@filenames){
	say "PNG Current: ",$cont+1," / ",$#filenames+1 if(( $cont+1) % 5 == 0);
	open R, "$FN";
	binmode R;
	my @file = <R>;
	close (R);
	open W, ">00$cont.png" if $cont < 10;
	open W, ">0$cont.png" if($cont < 100 && $cont > 9);
	open W, ">$cont.png" if($cont > 99);
	binmode W;
	print W $_ for(@file);
	unlink $FN;
	$cont++;
}
say 'Done! ';
$a = <>;