#!/usr/bin/perl
@file_name = glob "*.XML";
open (W, '>debug.txt');
for my $filename (@file_name) {
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
	my $filename = shift;
	my $file_ref = shift;
	my @file_key = @$file_ref;
	my %voc_compare = ();
	my @compare = ();
	my @voc_done = ();
	my @delete = qw/the figs that with from and/;
	for my $line (@file_key){
		my $i = 0;
		$line =~ s/\d//g;
		while ($line =~ /\s/g){ $i++; }
		if($i > 3) { push @voc, split ' ', $line; }
	}
	for(@voc){
		$_ =~ s/\d//g;
		$_ =~ s/\W//g;
		$_ =~ s/^.{1,2}$//g;
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
				my $reg2 = $1;
				if($reg2 !~ /\d+/ && $reg2 !~ /^\w{1,2}?$/){ $keyword{$reg}++;print "$reg\n"; }
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
}
sort{$voc_compare{$b}<=>$voc_compare{$a}} keys %voc_compare;
for my $voc(keys %hash_voc) {
	print W "\" $voc \"content file: ";
	print W "$_," for (@{$hash_voc{$voc}->{'filename'}});
	print W "Show times: ";
	print W ${$hash_voc{$voc}->{'times'}},"\n";
}