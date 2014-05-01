#!/usr/bin/perl
@file_name = glob "*.XML";
open (W, '>output.txt');
for my $filename (@file_name) {
	my @file = ();
	open (F, "$filename") || die "$!\n";
	my @infile = <F>;
	close (F);
	for my $line (@infile){
		chop $line;
		chomp $line;
		$line =~ s/\<.{1,300}?\>//g; 	#去標籤
		$line =~ s/^\d+$//g;         	#delete all num
		$line =~ s/^\w+$//g;    		#delete 純單字行
		$line = lc $line;
		if ($line ne '') { push @file, $line; }
	}
	grab($filename, \@file);
}

sub grab {
#database form:
	# $hash_voc{$voc} = {
		# "filename" => [],
		# "times" => [],
	# };
	my @voc = ();
	my %voc_compare = ();
	my @compare = ();
	my @voc_done = ();
	my %keyword = ();
	my $filename = shift;
	my $file_ref = shift;
	my @file_key = @$file_ref;
	my @delete = qw/for the figs that with from and/;
	print "loading file: $filename .....  $i / $#file_name\n";
	for my $line (@file_key){
		my $i = 0;
		$line =~ s/\d//g;	#數字刪除
		while ($line =~ /\s/g){ $i++; }		#該行空白大於三個再存入voc中
		if($i > 3) { push @voc, split ' ', $line; }
	}
	for(@voc){
		$_ =~ s/\d//g;         #數字刪除
		$_ =~ s/\W//g;         #非文字刪除
		$_ =~ s/^.{1,2}$//g;   #1-2個長度之單字刪除
		if($_ ne ''){ push @voc_done, $_; } 
	}
	for(@voc_done) { $voc_compare{$_}++; }
	for(@delete){ delete $voc_compare{$_}; }
	@compare = sort{$voc_compare{$b}<=>$voc_compare{$a}} keys %voc_compare;
	#search keyword
	for(0..49){
		my $comparement = $compare[$_];
		for my $line(@$file_ref){
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
	}
	@compare = sort{$keyword{$b}<=>$keyword{$a}} keys %keyword;
	#build database
	for(0..49){
		my $voc = $compare[$_];
		push @{$hash_voc{$voc}->{'filename'}}, $filename;
		${$hash_voc{$voc}->{'times'}}++;
	}
	$i++;
}
print "Building.....\n";
for my $voc(keys %hash_voc) {
	$temp = "\-\-\-\-$voc\ncontent file: ";
	for (@{$hash_voc{$voc}->{'filename'}}){ $temp = "$temp$_,"; }
	$temp = substr ($temp, 0,-1);
	$temp = "$temp\nShow times: ";
	$hash_print{$temp} = ${$hash_voc{$voc}->{'times'}};
}
@compare = sort{$hash_print{$b}<=>$hash_print{$a}} keys %hash_print;
print W "$_$hash_print{$_}\n" for (@compare);
