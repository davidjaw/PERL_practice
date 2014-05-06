#!/bin/usr/perl -w
print "Type: ";
chomp ($type = <>);
print "R: ";
chomp ($r = <>);
print "Tox: ";
chomp ($tox = <>);
print "Lg: ";
chomp ($lg = <>);
print "材質: ";
chomp ($meterial = <>);
open W, '>out.txt';
while(1){
	system("clear");
	system("cls");
	print "Current type: $type, R=$r, Tox=$tox, Lg=$lg, metetial=$meterial\n";
	print "Best and 2th Vt: ";
	chomp($vt = <>);
	@vt = split ' ', $vt;
	print "Best and 2th sslope: ";
	chomp($sslope = <>);
	@sslope = split ' ', $sslope;
	print "Best and 2th ro: ";
	chomp($ro = <>);
	@ro = split ' ', $ro;
	print "output to out.txt? ";
	chomp($out = <>);
	if($out == 1){ 
		print W "Current type: $type, R=$r, Tox=$tox, Lg=$lg, metetial=$meterial\n";
		print W "Best Vt:$vt[0], $vt[1]\nBest sslope:$sslope[0], $sslope[1]\nBest ro:$ro[0], $ro[1]\n";
	}
	system("clear");
	system("cls");
	print "Current type: $type, R=$r, Tox=$tox, Lg=$lg, metetial=$meterial\nEnter 1 for old value.\n";
	print "New Type: ";
	chomp ($ntype = <>);
	if($ntype ne ''){ $type = $ntype; }
	print "New R: ";
	chomp ($nr = <>);
	if($nr ne ''){ $r = $nr; }
	print "New Tox: ";
	chomp ($ntox = <>);
	if($ntox ne ''){ $tox = $ntox; }
	print "New Lg: ";
	chomp ($nlg = <>);
	if($nlg ne ''){ $lg = $nlg; }
	print "New 材質: ";
	chomp ($nmeterial = <>);
	if($nmeterial ne ''){ $meterial = $nmeterial; }
}