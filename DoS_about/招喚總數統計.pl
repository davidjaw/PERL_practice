if(-e 'sum.txt'){ #open file
	open(FHD, ">>sum.txt") || die "$!\n";
} else {
	open (FHD, ">sum.txt") || die "$!\n";
}
while(1){ #entering 
	print " C=1 UC=2 R=3 SR=4\nenter:";
	$input = <>;
	if($input == 1){$in = 'C' ;}
	elsif($input == 2){$in = 'UC'; }
	elsif($input == 3){$in = 'R'; }
	elsif($input == 4){$in = 'SR'; }
	else { close (FHD); last;}
	print FHD "$in\t"; 
}
open(FHD, "sum.txt") || die "$!\n";
$string = <FHD>;
close(FHD);
while($string =~ /SR\s/g){ $SR++; } #load string from file and sum
while($string =~ /R\s/g){ $R++; }
while($string =~ /UC\s/g){ $UC++; }
while($string =~ /C\s/g){ $C++; }
$R = $R-$SR; #debug
$C = $C-$UC;
$sum  = $C + $UC + $R + $SR;
$C_s  = three (100 * $C / $sum	 ); #percentage 
$UC_s = three (100 *  $UC / $sum );
$R_s  = three (100 * $R / $sum	 );
$SR_s = three (100 *  $SR / $sum );
open (W, ">statistics.txt"); #output file
print W  " 羆 $sum Ω┷传い\n";
print W  " SRΩ计: $SR\t$SR_s\%\n";
print W  " R Ω计: $R\t$R_s\%\n";
print W  " UCΩ计: $UC\t$UC_s\%\n";
print W  " C Ω计: $C\t$C_s\%\n";
print " 羆 $sum Ω┷传い\n\n"; #print
print " SRΩ计: $SR\t$SR_s\%\n";
print " R Ω计: $R\t$R_s\%\n";
print " UCΩ计: $UC\t$UC_s\%\n";
print " C Ω计: $C\t$C_s\%\n\n";
print " 块statistics.txt\n ENTER瞒秨祘Α\n";
$end = <>;
sub three {
	my $in = shift;
	my $out=sprintf "%.3f",$in;
	return $out;
}