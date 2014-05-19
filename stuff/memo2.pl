use Math::Complex;
system("cls");
print "Date: "; chomp ($date = <>);

my @oldss = glob "SSlope_*.txt";
$i = 0;
for(@oldss){ if($_ =~ /.+\_(\d+)/){ $i++; } }
open W2, ">SSlope_$i.txt";

@old = glob "$date*.txt";
$i = 0;
for(@old){ if($_ =~ /\d+\_(\d+)/){ $i++; } }
open W, ">$date\_$i.txt";

while(1){
MENU:
system("cls");
	print "1.Enter parameter.\n";
	print "2.count SS.\n";
	print "enter:";
	chomp($menu = <>);
	if($menu == 1){	 &parameter; 	}
	elsif($menu == 2){ &count; }
	else { close(W2); last;}
}

sub parameter{
	print "Type: ";		chomp ($type = <>);
	print "R: ";		chomp ($r = <>);
	print "Tox: ";		chomp ($tox = <>);
	print "Lg: ";		chomp ($lg = <>);
	print "D: ";		chomp ($d = <>);
	print "SD doping:";	chomp($SD_doping = <>);
	print "nm: ";		chomp ($nm = <>);
	print "meterial: ";	chomp ($meterial = <>);
	while(1){
		system("clear");	system("cls");
		print "Type: $type, R=$r, Tox=$tox, Lg=$lg, metetial=$meterial\n";
		print "\tD=$d, nm=$nm, SD doping=$SD_doping\n";
		print "Best and 2th Vt: ";
		chomp($vt = <>);	@vt = split ' ', $vt;
		print "Best and 2th sslope: ";
		chomp($sslope = <>);	@sslope = split ' ', $sslope;
		print "Ion and Ioff: ";
		chomp($Iin = <>);	@Iin = split ' ', $Iin;
		print "output to $date\_$i.txt? ";	chomp($out = <>);
		if($out == 1){ 
			print W "Current type: $type, R=$r, D=$d, nm=$nm, Tox=$tox, Lg=$lg, metetial=$meterial, SD doping=$SD_doping\n";
			print W "Best Vt:$vt[0], $vt[1]\nBest sslope:\nIon=$Iin[0], Ioff=$Iin[1]\n";
		}
		print "Exit?"; chomp($exit = <>); goto MENU if ($exit == 1);
		system("clear");	system("cls");
		print "Current type: $type, R=$r, D=$d, nm=$nm, Tox=$tox, Lg=$lg, metetial=$meterial, SD doping=$SD_doping\nPress Enter for old value.\n";
		print "New Type: ";			chomp ($ntype = <>);		if($ntype ne ''){ $type = $ntype; }
		print "New R: ";			chomp ($nr = <>);			if($nr ne ''){ $r = $nr; }
		print "New Tox: ";			chomp ($ntox = <>);			if($ntox ne ''){ $tox = $ntox; }
		print "New Lg: ";			chomp ($nlg = <>);			if($nlg ne ''){ $lg = $nlg; }
		print "New D: ";			chomp ($nd = <>);			if($nd ne ''){ $d = $nd; }
		print "New SD doping: ";	chomp ($nSD_doping = <>);	if($nSD_doping ne ''){ $SD_doping = $nSD_doping; }
		print "New nm: ";			chomp ($nnm = <>);			if($nnm ne ''){ $nm = $nnm; }
		print "New meterial: ";		chomp ($nmeterial = <>);	if($nmeterial ne ''){ $meterial = $nmeterial; }
	}
}
sub count{
	my $i = 1;
	my $idin = 1;
	my @final = ();
	my $total = 0;
	my @idin = ();
	print "Type & imfo:";
	chomp(my $enter = <>);
	print W2 "$enter\n";
	while($idin != ''){
		print "Id$i: ";chomp($idin = <>);
		push @idin, $idin if($idin ne '');
		$i++;
	}
	for(@idin){ $_ = logn($_,10); }
	for(1..$#idin){
		push @final, 50 / ($idin[$_] - $idin[$_-1]);
	}
	my $j = 0;
	for(@final){ $total += $_; $j++; }
	$total = $total / $j;
	print W2 "SSlope = $total\n";
}