#!/usr/bin/perl
while(1){
	my $hash = undef;
	$i=1;
	system("clear");
	system("cls");
	print "====================================\n";
	print "||============== MENU ============||\n";
	print "|| 1. output keywords             ||\n";
	print "|| 2. enter to search             ||\n";
	print "====================================\n";
	print "Enter: ";
	chomp ($enter_MENU = <>);
	if($enter_MENU == 1){
		system("cls");
		&view;
		&print;
	} elsif($enter_MENU == 2) {

	} else {
		last;
	}
}
sub view{
	@file_name = glob "*.XML";
	open W, '>output.txt';
	open W2, '>shown_times.txt';
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
	close(W2);
}
sub grab {
	my $length_space = 0;
	my @voc = ();
	my %voc_compare = ();
	my @compare = ();
	my @voc_done = ();
	my %keyword = ();
	my $filename = shift;
	my $file_ref = shift;
	my @file_key = @$file_ref;
	my @delete = qw/used further user where case any between has have been other this said each least another one are may might also which not can for the figs that with from and/;
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
THREE:
	my $control = 0;
	my @ck = ();
	for(0..49){
		my $comparement = $compare[$_];
		for my $line(@$file_ref){
			if($length_space == 0 && $control < 10){
				while ($line =~ /$comparement/g){ 
					my $reg = $&;
					my $cheak = 0;
					$keyword{$reg}++; 
					for(@ck){ if($reg eq $_){ $cheak++; } }
					for(@delete){ if($reg eq $_){ $cheak++; } }
					push @ck, $reg;
					if($cheak == 0){ $control++; }
				}
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
				while ($line =~ /$comparement\s(\w+)\s(\w+)/g){
					my $reg = $&;
					unless($1 =~ /\d/ || $2 =~ /\d/){ $keyword{$reg}++; }
				}
			}
		}
	}
	$length_space++;
goto THREE unless($length_space == 3);
	@compare = sort{$keyword{$b}<=>$keyword{$a}} keys %keyword;
	# build database
	for my $i (0..149){
		my $voc = $compare[$i];
		push @{$hash->{$voc}{'filename'}}, $filename;
		print W2 "$voc\:\:";
		for (0..149){ 
			unless ($_ == $i ){ 
				# unless ($compare[$_] =~ /\s/){ 
					my $reg = $compare[$_]; $hash->{$voc}{'relate'}{$reg} ++; 
				# } 
			} 
		} #print W03 "$voc\:\:$compare[$_]\n";
	}
	$i++;
}
sub print {
print "print section\n";
	open ST, 'shown_times.txt'; 	my $ST = <ST>;	close (ST);  #@sort_keyword: all keyword
	unlink 'shown_times.txt';
	my @st = split '::', $ST;                                    #hash->{$voc}{'RL_sort'}	relate之keyword照順序排好
	#shown_times part                                            #hash->{$voc}{'filename'}	所含之檔名
	my @unsort_ST = ();                                          #hash->{$voc}{'ST'}		出現次數
	for(@st){ $hash->{$_}{'ST'} ++; }
	for my $voc (keys %$hash){
		my $reg = $hash->{$voc}{'ST'};
		push @unsort_ST, $voc; push @unsort_ST, $reg;
	}
	@sort_keyword = &cs(@unsort_ST);
	#relate part
	print "relate part\n";
	for my $voc (@sort_keyword){
		my @unsort_RL = ();
		my $reg_hashref = $hash->{$voc}{'relate'};
		for my $relate_voc (keys %$reg_hashref){
			push @unsort_RL, $relate_voc; push @unsort_RL, $hash->{$voc}{'relate'}->{$relate_voc};
		}
		$asdfasdf = 1;
		@{$hash->{$voc}{'RL_sort'}} = cs(@unsort_RL);
		$asdfasdf = 0;
		my $cheak = $hash->{$voc}{'RL_sort'};
	}
	print "sort\n";
	for my $voc (@sort_keyword){
		my $voc_st = $hash->{$voc}{'ST'};
		my @voc_RL = @{$hash->{$voc}{'RL_sort'}};
		my @contant = @{$hash->{$voc}{'filename'}};
		print W "$voc\n";
		print W "Shown times: $voc_st\nContant file:\n";
		print W "$_, " for(@contant);
		print W "\nRelate keyword:\n";
		print W "$_, " for(@voc_RL);
		print W "\n\n";
	}
	close(W);
}
sub cs {
open W3, '>debug.txt' if($asdfasdf ==1);
	my @in = @_;
	my %hash = undef;
	my @AUX = undef;
	my @sort = undef;
	for($i = 0; $i < $#in; $i = $i + 2){
		my $reg = $in[$i+1];
		push @{$hash{$reg}}, $in[$i];
print W3 "$reg / $i / $#in\n";
	}
	for my $num (keys %hash){
		if($num != undef){
			my $i = 0;
			for(@{$hash{$num}}){ $i++; }
			@{$hash{$num}} = sort (@{$hash{$num}});
			if ($i < 2){ $AUX[$num]++;  } else { $AUX[$num] += $i; }
		}
	}
	for my $i (1..$#AUX){ $AUX[$i] += $AUX[$i-1] ; }
	for my $i (keys %hash){
		for my $value (@{$hash{$i}}){
			my $reg = $AUX[$i] - 1;
			$sort[$reg] = $value;
			$AUX[$i]--;
# print W3 "reg=$reg\n";
		}
	}
	print W3 "$_\n" for(@sort);
	# shift @sort;  #don't know why have a undef value at sort[0]
	return reverse @sort;
close (W3) if ($asdfasdf==1);
}