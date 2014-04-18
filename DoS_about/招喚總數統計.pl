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
print W  " �`�@ $sum �����۴����G\n";
print W  " SR����: $SR\t$SR_s\%\n";
print W  " R ����: $R\t$R_s\%\n";
print W  " UC����: $UC\t$UC_s\%\n";
print W  " C ����: $C\t$C_s\%\n";
print " �`�@ $sum �����۴����G\n\n"; #print
print " SR����: $SR\t$SR_s\%\n";
print " R ����: $R\t$R_s\%\n";
print " UC����: $UC\t$UC_s\%\n";
print " C ����: $C\t$C_s\%\n\n";
print " ��X�w�s��statistics.txt\n ��ENTER���}�{��\n";
$end = <>;
sub three {
	my $in = shift;
	my $out=sprintf "%.3f",$in;
	return $out;
}