#this program is only for practicing.
if(-e "vocabulary.txt"){ &reload }
 else {
	open(FHD, ">vocabulary.txt") || die "$!\n";
	print FHD "example<mean>example<ex>example";
	close (FHD);
}
if($pause==543){
	MENU:  #mark MENU
	$MEselect = 0;
	}
while(1){
	system("clear");
	system("cls");
	print "===================================\n";
	print "1.View & Edit vocabulary.txt \n";
	print "2.ramdom Voc & Meaning & Example\n";
	print "3.manual entering Vocabulary.\n";
	print "4.Enter Vocabulary by file\n";
	print "===================================\n";
	print "What do you want? Enter:";
	chomp ($subchoose=<>);
	if ($subchoose == 2){ &random; }
	elsif($subchoose==3){ &manual_enter;}
	elsif($subchoose==1){ &edit;}
	else {print "Press enter to end program.\n";
		$pause=<>;
		last;	}
}
sub reload {
	open(view, "vocabulary.txt") || die "$!\n";
	@file=<view>;
	close (view);
	@file_reg=@file;
	for(@file_reg){
		$_ =~ s/\<\w+\>/\:\:\:/g;
		chomp $_;
		if ($_ != /\S+/){ @voc_reg=(@voc_reg,(split ':::',$_)); }
	}
	$count=($#voc_reg+1)/3-1;
	#($#voc_reg+1)/3-1   care the '-1'
	for(0..$count){
		$voc[$_]=shift @voc_reg;
		$hash_mean{$voc[$_]}=shift @voc_reg;
		$hash_ex{$voc[$_]}=shift @voc_reg;
	}
}
sub edit{
	&reload;
	print "================Edit Mode==============\n";
	print "1.View all vocabulary \n";
	print "2.Edit vocabulary (edit by number)\n";
	print "3.Edit vocabulary(edit by enter)\n";
	print "=======================================\n";
	print "Enter:";
	chomp ($Eenter=<>);
	if($Eenter==1){
		for(0..$#voc){
			print "[$_] $voc[$_] \n";
			print "meaning: $hash_mean{$voc[$_]} \n";
			print "example: $hash_ex{$voc[$_]} \n\n";
		}
	}elsif ($Eenter == 2){
		print "\n";
		print "[$_] Voc: $voc[$_]\n"for(0..$#voc);
		print "\nWhich vocabulary do you want to view/edit? \n";
		print "Enter number:";
		chomp ($Eedit_num=<>);
		system("clear");
		system("cls");
		print "[$Eedit_num]\t$voc[$Eedit_num] \n";
		print "meaning: $hash_mean{$voc[$Eedit_num]}\n";
		print "example: $hash_ex{$voc[$Eedit_num]}\n";
		print "\nnotice: if change all, enter form as'Voc::mean::example'\n";
		print "1:Vocabulary, 2:meaning, 3:example, 4:all\n";
		print "Enter:";
		chomp($Eedit_VME=<>);
		if($Eedit_VME==1){
			print "change vocabulary to:";
			chomp($Ech=<>);
			$voc[$Eedit_num]=$Ech;
			print "now is $voc[$Eedit_num]!\n";
		} elsif ($Eedit_VME==2){
			print "change meaning to:";
			chomp($Ech=<>);
			$hash_mean{$voc[$Eedit_num]}=$Ech;
			print "now is $hash_mean{$voc[$Eedit_num]}!\n";
		} elsif ($Eedit_VME==3){
			print "change example to:";
			chomp($Ech=<>);
			$hash_ex{$voc[$Eedit_num]}=$Ech;
			print "now is $hash_ex{$voc[$Eedit_num]}!\n";
		} elsif ($Eedit_VME==4){
			print "Enter:";
			chomp ($Evoc_enter=<>);
			if($Evoc_enter =~ /\w+\:\:.+\:\:.+/){
				@Evoc=split '::',$Evoc_enter;
				$voc[$Eedit_num]=$Evoc[0];
				$hash_mean{$voc[$Eedit_num]}=$Evoc[1];
				$hash_ex{$voc[$Eedit_num]}=$Evoc[2];
			} else {print "wrong form!\n" }
		}
	} elsif ($Eenter == 3) {
		print "Enter vocabulary:";
		
	}
	print "Press enter to MENU...\n";
	$pause=<>;
	goto MENU;
}
sub random {
	&reload;
	%repeat=();
	system("clear");
	system("cls");
	for(0..$#voc){
		$RV=int( $#voc ); #randomvocab
		while($repeat{$RV}>0){$RV=int( rand $#voc );}
		$repeat{$RV}++;
		print "Vocabulary: $voc[$RV]";
		$pause=<>;
		print "Meaning: $hash_mean{$voc[$RV]}\n";
		print "Example: $hash_ex{$voc[$RV]}\n";
		$pause=<>;
	}
	print "End of Vocabulary.\n";
	print "Press enter to menu:\n";
	$pause=<>;
	goto MENU;
}

sub manual_enter {
	if($MEselect == 0){
		system(clear);
		system(cls);
		print "================Enter Mode=============\n";
		print "1.Step mode\n";
		print "2.One line mode\n";
		print "=======================================\n";
		print "Selection:";
		chomp ($MEselect=<>);
	}
	if ($MEselect == 1){
		print "Please enter a vocabulary:";
		chomp ($MEvoc=<>);
		for(0..$#voc){
			if( $voc[$_] =~ /$MEvoc/ && length($voc[$_]) == length ($MEvoc)){
				print "vocabulary:$MEvoc is already in file!\n";
				print "Please cheak vocabulary.txt!\n";
				$break_trigger=1;
			}  		
		}
		if($break_trigger==1){ last; } 
		print "Please enter its meaning:";
		chomp ($MEmean=<>);
		print "Please enter a exaple:";
		chomp ($MEex=<>);
		print "Add vocabulary:$MEvoc, meaning:$MEmean, example:$MEex\n";
		print "1 for Confirn :";
		chomp ($confirm=<>);
		if($confirm == 1){ 
			open (W,(">>vocabulary.txt")) || die"$!\n";
			print W "\n$MEvoc\<mean\>$MEmean\<ex\>$MEex";
			close(W);
		}
		print "Continue adding?";
		chomp ($ME_continue=<>);
		if($ME_continue == 1){ &manual_enter;}
		else { goto MENU; }
	} elsif ($MEselect == 2) {
		print "Please enter as form:\n";
		print "vocab::meaning::sentence\n";
		print "Enter:";
		chomp ($MEenter=<>);
		if($MEenter =~ /\w+\:\:.+\:\:.*/){
			@MEarray = split '::',$MEenter;
			for(0..$#voc){
				if($voc[$_] =~ /$MEarray[0]/) {
					print "$MEarray[0] is already in file!\n";
					print "Press enter to continue:";
					$pause=<>;
					goto MENU;
				}
			}
			open (W2,(">>vocabulary.txt")) || die"$!\n";
			print W2 "\n$MEarray[0]\<mean\>$MEarray[1]\<ex\>$MEarray[2]";
			close(W2);
		} else {
			print "wrong form!\nPress enter to continue...";
			$pause=<>;
			goto MENU;
		}
		print "Continue adding? :";
		chomp ($ME_continue=<>);
		if($ME_continue == 1){ &manual_enter;}
		else { goto MENU; }
	}
}
