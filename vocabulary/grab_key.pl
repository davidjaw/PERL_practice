#!/usr/bin/env perl
@XML_filename = glob "*.XML";
&loadfile(@XML_filename);
@sort_output = sort{$hash_output{$b}<=>$hash_output{$a}} keys %hash_output;
print "key:$sort_output[$_].value:$hash_output{$sort_output[$_]}\n" for(0..50);
$a=<>;
sub loadfile {
	for(0..$#XML_filename){
		#reset
		 my @delete = qw/at et one least second with the a of in is to and for which that as be by or p so may an as/;
		 my @vocab = ();
		 my @compare_file = ();
		 my @compare_vocab = ();
		 my %vaocb_hash = ();
		#read start
		$filename = shift ;
		print "Loading file: $filename.....\n";
		open(FILE, "$filename") || die "$!\n";
		@file = <FILE>;
		close(FILE);
		for(@file){
			#刪除換行(XML檔案中換行有\n及\r故要刪兩次
			chomp $_;
			$_ =~ s/\r//g;
			#從小標籤開始刪除
			$_ =~ s/\<.{0,10}\>//g;
			$_ =~ s/\<.{0,30}\>//g;
			$_ =~ s/\<.{0,100}\>//g;
			$_ =~ s/\<.+\>//g;
			#變小寫
			$_ = lc $_;
			#將去標籤檔案儲存等待比對
			if($_ ne ''){@compare_file = (@compare_file, $_);}
		}
		@vocab = (@vocab, split ' ', $compare_file[$_]) for(0..$#compare_file);
		for(@vocab){
			$_ =~ s/\W//g;
			$_ =~ s/^\d+$//g;
			$_ =~ s/^\w$//g;
			if($_ ne ''){ $vaocb_hash{$_}++; }
		}
		delete $vaocb_hash{$_} for(@delete); 
		@compare_vocab = sort{$vaocb_hash{$b}<=>$vaocb_hash{$a}} keys %vaocb_hash;
		for $i (0..40){
			for $line (@compare_file){
				while($line =~ /$compare_vocab[$i]\s\w+/g){
					my $count_no = 0;
					$reg_compare = $&;
					for $no (@delete){
						if($reg_compare =~ /$compare_vocab[$i]\s$no$/){ $count_no = 1; }
					}
					if($count_no != 1){ $hash_output{$reg_compare}++; }
				}
			}
		}
		print "Complete!\n";
	}
}
