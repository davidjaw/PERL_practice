package dav_trans{
use Encode;
use File::Copy;
use v5.18.2;
	sub trans{
		mkdir 'uncode' unless (-d 'uncode'); # mkdir for org files
		my @filename;
		if(-e '.memo.dav'){ 
			open R, '.memo.dav'; 
			@filename = map{
				chomp $_;
				$_;
			}<R>;
			open FH_ME, '>>.memo.dav';
			close(R);
		} else { open FH_ME, '>.memo.dav' unless -e '.memo.dav'; }
		my @files = glob '*.txt';
		for my $fn(@files){
			for(@filename){ goto SKIP if($_ eq $fn); }
			open R, "$fn";
			my @file = <R>;
			close(R); 
			File::Copy::move($fn, 'uncode');
			
			open W, ">$fn";
			@file = map{
				chomp $_;
				$_ = encode("utf-8",decode("gbk",$_));
				if($_ =~ /(.+?)_.*/){ $_ = $1; }
				$_;
			} @file;
			($file[1], $file[2]) = '';
			@file = grep $_ ne '', @file;
			say W $_ for(@file);
			close(W);
			say FH_ME $fn;
			SKIP:
		}
		close(FH_ME);
	}
	1;
}