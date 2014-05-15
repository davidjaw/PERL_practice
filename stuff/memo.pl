#!/bin/usr/perl -w
print "Date: ";		chomp ($date = <>);
print "Type: ";		chomp ($type = <>);
print "R: ";		chomp ($r = <>);
print "D: ";		chomp ($d = <>);
print "nm: ";		chomp ($nm = <>);
print "Tox: ";		chomp ($tox = <>);
print "Lg: ";		chomp ($lg = <>);
print "meterial: ";	chomp ($meterial = <>);
print "SD doping:";	chomp($SD_doping = <>);
@old = glob "*.txt";
$i = 0;
for(@old){
	if($_ =~ /\d+\_(\d+)/){
		$i++;
	}
}
open W, ">$date\_$i.txt";
while(1){
	system("clear");	system("cls");
	print "Type: $type, R=$r, Tox=$tox, Lg=$lg, metetial=$meterial\n";
	print "\tD=$d, nm=$nm, SD doping=$SD_doping\n";
	print "Best and 2th Vt: ";
	chomp($vt = <>);	@vt = split ' ', $vt;
	print "Best and 2th sslope: ";
	chomp($sslope = <>);	@sslope = split ' ', $sslope;
	print "Best and 2th ro: ";
	chomp($ro = <>);	@ro = split ' ', $ro;
	print "output to $date\_$i.txt? ";	chomp($out = <>);
	if($out == 1){ 
		print W "Current type: $type, R=$r, D=$d, nm=$nm, Tox=$tox, Lg=$lg, metetial=$meterial, SD doping=$SD_doping\n";
		print W "Best Vt:$vt[0], $vt[1]\nBest sslope:$sslope[0], $sslope[1]\nBest ro:$ro[0], $ro[1]\n";
	}
	system("clear");	system("cls");
	print "Current type: $type, R=$r, D=$d, nm=$nm, Tox=$tox, Lg=$lg, metetial=$meterial, SD doping=$SD_doping\nPress Enter for old value.\n";
	print "New Type: ";			chomp ($ntype = <>);		if($ntype ne ''){ $type = $ntype; }
	print "New R: ";			chomp ($nr = <>);			if($nr ne ''){ $r = $nr; }
	print "New D: ";			chomp ($nd = <>);			if($nd ne ''){ $d = $nd; }
	print "New nm: ";			chomp ($nnm = <>);			if($nnm ne ''){ $nm = $nnm; }
	print "New Tox: ";			chomp ($ntox = <>);			if($ntox ne ''){ $tox = $ntox; }
	print "New Lg: ";			chomp ($nlg = <>);			if($nlg ne ''){ $lg = $nlg; }
	print "New meterial: ";		chomp ($nmeterial = <>);	if($nmeterial ne ''){ $meterial = $nmeterial; }
	print "New SD doping: ";	chomp ($nSD_doping = <>);	if($nSD_doping ne ''){ $SD_doping = $nSD_doping; }
}