#!/usr/bin/perl
use v5.18.2;
use threads;
use threads::shared;
use LWP::UserAgent;
use File::Copy;
use Encode;
use Time::HiRes ('sleep');

my $novel_name;
if(-e '.memo_last.dav'){
	open R, '.memo_last.dav';
	$novel_name = <R>;
	close(R);
	print "Grab novel: \'$novel_name\'?\nEnter 1 for change: ";
	chomp(my $change = <>);
	if ($change == 1){
		print "Enter URL:" ;
		chomp($novel_name = <>);
		if ($novel_name =~ /http:\/\/www.d586.com\/(\w+?)\//){ $novel_name = $1; }
		open W, '>.memo_last.dav';
		print W $novel_name;
		close(W);
		open W, ">.memo_$novel_name.dav" unless -e ".memo_$novel_name.dav";
		close(W);
	}
} else {
	print "Enter URL:";
	chomp($novel_name = <>);
	if ($novel_name =~ /http:\/\/www.d586.com\/(\w+?)\//){ $novel_name = $1; }
	open W, '>.memo_last.dav';
	print W "$novel_name";
	close(W);
	open W, ">.memo_$novel_name.dav";
	close(W);
	mkdir $novel_name;
}
open R, "<.memo_$novel_name.dav";
my %skip = map{
	chomp $_;
	$_ => 1;
} <R>;
close(R);

system('cls');
say "Getting links from http://www.d586.com/$novel_name/ ........";
my $ua = LWP::UserAgent->new();
$ua->timeout(10);
my $r = $ua->get("http://www.d586.com/$novel_name/"); 
my @content_link = split '\r', $r->{'_content'};
my $content;
for(@content_link){ $content = $_ if length $_ > 700; }
$content =~ s/href="/\n/g;
my $value;
my %links = map{
	if($_ =~ /^\/(\w+?)\/(\d+)\/">(\S+)/) {
		$value = $1;
		# say "\$_ is $_ , \$1 = $1, \$2 = $2, \$3 = $3";
		$2 => $3;
	} else { (); }
} split '\n', $content;
my @sort_link;
for my $outter(sort keys %links){
	my $length = length $outter;
	my $chk = 0;
	for (sort keys %links){
		$chk = length $_ if length $_ != $length;
		last if length $_ != $length;
	}
	link_sort(\%links, $chk) if $chk > $length;
	link_sort(\%links, $length) if $chk < $length;
	last if $chk > 0;
}
say 'Done! start to download files.....';

my $total = @sort_link;
my $cont:shared;
my $times = int(($#sort_link + 1) / 5);
my $zero = 0;
for(my $i = $#sort_link + 1;$i > 10;$i=$i/10){ $zero++; }
say "zero = $zero";
for my $loop(0..$times){
	my @url = ($sort_link[$loop*5], $sort_link[$loop*5+1], $sort_link[$loop*5+2], $sort_link[$loop*5+3], $sort_link[$loop*5+4]);
	for(@url){
		$_ = substr($_, 1) if $_ =~ /^0/;
	}
	my $thr0 = threads->new(\&get_novel,   $url[0]);
	my $thr1 = threads->new(\&get_novel,   $url[1]);
	my $thr2 = threads->new(\&get_novel,   $url[2]);
	my $thr3 = threads->new(\&get_novel,   $url[3]);
	my $thr4 = threads->new(\&get_novel,   $url[4]);
	$thr0->join;
	sleep(0.25);
	$thr1->join;
	sleep(0.25);
	$thr2->join;
	sleep(0.25);
	$thr3->join;
	sleep(0.25);
	$thr4->join;
	sleep(0.25);
	sleep(1);
	open W, ">>.memo_$novel_name.dav";
	say W $_ for @url;
	close(W);
	say '';
}
open R, "<.memo_$novel_name.dav";
my %skip = map{
	chomp $_;
	$_ => 1;
} <R>;
close(R);
open W, ">.memo_$novel_name.dav";
print W $_ for keys %skip;
close(W);
say 'Done! ';


sub get_novel{
	my $num = shift;
	$cont++;
	my ($filename, $chk);
	if($cont < 10 && $zero > 1){ $filename = '0'.$cont.$links{$num} for 1..$zero; }
	elsif($cont < 100 && $zero > 2){ $filename = '0'.$cont.$links{$num} for 1..$zero; }
	elsif($cont < 1000 && $zero > 3){ $filename = '0'.$cont.$links{$num} for 1..$zero; }
	else{ $filename = $cont.$links{$num}; }
	my $reg = $filename;
	Encode::from_to($filename, "gbk", "big5");
	$filename = $reg if $filename =~ /\?/;
	say "Downloading $cont / $total : $filename.txt, num = $num";
	$chk = 1 if ($skip{$num} == 1);
	goto SKIP if ($skip{$num} == 1);
	open W, ">$filename.txt";
	my $url = "http://www.d586.com/$value/".$num.'/';
	$r = $ua->get($url);
	my @string = $r->{'_content'};
	@string = ($string[0], $string[10]);
	my $form = qr/&nbsp;&nbsp;&nbsp;&nbsp;/;
	my @novel = map {
		if($_ =~ /$form/){
			$_ =~ s/\<.{1,10000}?\>//g;
			$_ =~ s/$form/\n/g;
			$_ =~ s/if .+//g;
			$_ =~ s/yd_ad\d\(\)\;//g;
			split '\n', $_;
		} else { (); }
	} map {
		$_ =~ s/\r//g;
		split '\n', $_;
	} @string;
	($novel[1], $novel[2]) = '';
	$novel[-1] =~ s/[a-z|A-Z].+//g;
	@novel = grep $_ ne '', @novel;
	say W $_ for @novel;
	close (W);
	SKIP:
	$cont++ if $chk == 1;
	move($filename, $novel_name);
}
sub link_sort{
	my $hash = shift;
	my $length = shift;
	for(sort keys %$hash){ 
		$_ = '0'.$_ if length $_ < $length;
		push @sort_link, $_;
	}
	@sort_link = sort @sort_link;
}