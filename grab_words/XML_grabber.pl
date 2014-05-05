#!/usr/bin/perl -w
while(1){
	$i = 1;
	system("cls");
	print "====================================\n";
	print "||============== MENU ============||\n";
	print "|| 1. view keywords               ||\n";
	print "|| 2. enter to search             ||\n";
	print "====================================\n";
	print "Enter: ";
	chomp ($enter_MENU = <>);
	if($enter_MENU == 1){
		system("cls");
		print "====================================\n";
		print "||====== KEYWORD MENU ============||\n";
		print "|| 0. KEYWORD                     ||\n";
		print "|| 1. KEYWORD KEYWORD             ||\n";
		print "|| 2. KEYWORD KEYWORD KEYWORD     ||\n";
		print "====================================\n";
		print "Enter: ";
		$length_space = <>;
		&view;
		&print;
	} elsif($enter_MENU == 2) {
		
	} else {
		last;
	}
}
sub view{
	@file_name = glob "*.XML";
	open (W, '>output.txt');
	for my $filename (@file_name) {
		open (F, "$filename") || die "$!\n";
		my @infile = <F>;
		close (F);
		@file = map {
			chop $_;
			chomp $_;
			$_ =~ s/\<.{1,300}?\>//g; 	#去標籤
			$_ =~ s/^\d+$//g;         	#delete all num
			$_ =~ s/^\w+$//g;    		#delete 純單字行
			$_ = lc $_;
			if ($_ ne '') { $_; } else { (); }
		} @infile;
		grab($filename, \@file);
	}
}
sub grab {
	my @voc = ();
	my %voc_compare = ();
	my @compare = ();
	my @voc_done = ();
	my %keyword = ();
	my $filename = shift;
	my $file_ref = shift;
	my @file_key = @$file_ref;
	my @delete = qw/for the figs that with from and/;
	print "loading file: $filename .....  $i / ",$#file_name+1,"\n";
	@voc_done = map {                                                # @voc = map {
		$_ =~ s/\W//g;                                               # my $i = 0;
		$_ =~ s/^.{1,2}$//g;   #1-2個長度之單字刪除                  # $_ =~ s/\d//g;
		if($_ ne ''){ $_; } else { (); }                             # while ($_ =~ /\s/g){ $i++; }
	} map {                                                          # if($i > 3) { $_; } else { (); }
		my $i = 0;                                                   # } @file_key;
		$_ =~ s/\d//g;	#數字刪除
		while ($_ =~ /\s/g){ $i++; }		#該行空白大於三個再存入voc中
		if($i > 3) { split ' ', $_; } else { (); }
	} @file_key;
	for(@voc_done){ $voc_compare{$_}++; }
	for(@delete){ delete $voc_compare{$_}; }
	@compare = sort{$voc_compare{$b}<=>$voc_compare{$a}} keys %voc_compare;
	#search keyword
	for(0..49){
		my $comparement = $compare[$_];
		for my $line(@$file_ref){
			if($length_space == 0){
				while ($line =~ /$comparement/g){ $keyword{$&}++; }
			}
			elsif ($length_space == 1){
				while ($line =~ /$comparement\s(\w+)/g){
					my $reg = $&;
					my $reg2 = $1;	#'$1'是比對式子中第一個被()起來的地方
					my $cheak = 0;
					if($reg2 !~ /\d+/ && $reg2 !~ /^\w{1,2}?$/){
						#$1不為純數字及1-2長度的單字時檢查是否為@delete中的要刪除字元
						for my $del(@delete){ if($reg2 eq $del){ $cheak++; }  }
						$keyword{$reg}++ if ($cheak == 0);
					}
				}
			}
			elsif ($length_space == 2){
				while ($line =~ /$comparement\s\w+\s\w+/g){
					my $reg = $&;
					$keyword{$reg}++;
				}
			}
		}
	}
	@compare = sort{$keyword{$b}<=>$keyword{$a}} keys %keyword;
	# build database                                              #database form:
	for(0..49){                                                  # $hash_voc{$voc} = {
		my $voc = $compare[$_];                                  	# "filename" => [],
		push @{$hash_voc{$voc}->{'filename'}}, $filename;        	# "times" => [],
		${hash_voc{$voc}->{'times'}}++;                            # };
	}
	$i++;
}
sub print {
	my $temp = ();
	my %hash_print = ();
	my @compare = ();
	for my $voc(keys %hash_voc) {
		$temp = "\-\-\-\-$voc\ncontent file: ";
		for (@{$hash_voc{$voc}->{'filename'}}){ $temp = "$temp$_,"; }
		$temp = substr ($temp, 0,-1);
		$temp = "$temp\nShow times: ";
		$hash_print{$temp} = ${hash_voc{$voc}->{'times'}};
	}
	@compare = sort{$hash_print{$b}<=>$hash_print{$a}} keys %hash_print;
	print W "$_$hash_print{$_}\n" for (@compare);
	print "Output complete! View ./output.txt ! \nPress ENTER to continue....";
	my $a = <>;
	
	@{$hash_voc{$voc}->{'filename'}} = qw//;
	# %{$hash_voc{$voc}} = ();
	# $hash_voc{$voc} = ();
}