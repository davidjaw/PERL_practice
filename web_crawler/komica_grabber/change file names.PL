use v5.18.2;

my @filenames = glob "*.jpg";
my $cont = 0;
for my $FN(@filenames){
	open R, "$FN";
	binmode R;
	my @file = <R>;
	close (R);
	open W, ">jpg_00$cont.jpg" if $cont < 10;
	open W, ">jpg_0$cont.jpg" if($cont < 100 && $cont > 9);
	open W, ">jpg_$cont.jpg" if($cont > 99);
	binmode W;
	print W $_ for(@file);
	unlink $FN;
	$cont++;
	say "jpg Laft: $cont / ",$#filenames+1 if($cont %10 == 0);
}
@filenames = glob "*.png";
$cont = 0;
for my $FN(@filenames){
	open R, "$FN";
	binmode R;
	my @file = <R>;
	close (R);
	open W, ">png_00$cont.png" if $cont < 10;
	open W, ">png_0$cont.png" if($cont < 100 && $cont > 9);
	open W, ">png_$cont.png" if($cont > 99);
	binmode W;
	print W $_ for(@file);
	unlink $FN;
	$cont++;
	say "png Laft: $cont / ",$#filenames+1 if($cont %10 == 0);
}
say 'Done! press ENTER to exit!';