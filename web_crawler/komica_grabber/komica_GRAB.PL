use v5.18.2;
use threads;
use threads::shared;
use LWP::UserAgent;
use HTTP::Cookies;
use File::Copy;
require get_K;
# version: v1.1.0

my %komica:shared; # for saving HTML codes
my $url = 'http://eden.komica.org/00/index.htm';
$komica{'0'} = dav_getK::getK_content($url);

my @th;
for(1..9){ $th[$_] = threads->new(\&Grabber_HTML,   $_); }  # 寫一起會比較慢, WHY?
for(1..9){ $th[$_]->join; }                           		#

my @reply_url = map {
	my $content = $komica{$_};
	my $form_title = qr/\[<a href=index.php\?res=/;
	my @links = map {
		if($_ =~ /$form_title(\d+)/){ $_ = $1; } else { $_ = ''; }
		if($_ ne ''){
			$_ = 'http://eden.komica.org/00/index.php?res='.$_;
		} else { (); }
	} split '\n', $content;
	@links;
} keys %komica;

my (@url_img, $cont) : shared;
for my $num(0..19){
	my $thr0   =   threads->new(\&Grabber_img_url,   $reply_url[$num*5]);
	my $thr1   =   threads->new(\&Grabber_img_url,   $reply_url[$num*5+1]);
	my $thr2   =   threads->new(\&Grabber_img_url,   $reply_url[$num*5+2]);
	my $thr3   =   threads->new(\&Grabber_img_url,   $reply_url[$num*5+3]);
	my $thr4   =   threads->new(\&Grabber_img_url,   $reply_url[$num*5+4]);
	$thr0->join;
	$thr1->join;
	$thr2->join;
	$thr3->join;
	$thr4->join;
	say 'Done! Left ', (20-$num-1)*5,' times';
}
open W, '>out.txt';
say W $_ for @url_img;
close(W);

my $times = int($#url_img / 5);
for(0..$times+1){
	my $thr0   =   threads->new(\&Grabber_img,   $url_img[$_*5]);
	my $thr1   =   threads->new(\&Grabber_img,   $url_img[$_*5+1]);
	my $thr2   =   threads->new(\&Grabber_img,   $url_img[$_*5+2]);
	my $thr3   =   threads->new(\&Grabber_img,   $url_img[$_*5+3]);
	my $thr4   =   threads->new(\&Grabber_img,   $url_img[$_*5+4]);
	$thr0->join;
	$thr1->join;
	$thr2->join;
	$thr3->join;
	$thr4->join;
	say 'Done! Left ', ($times-$_)*5,' times';
}





sub Grabber_img_url{
	my $url = shift;
	say "now solving url: $url";
	my $content = dav_getK::getK_content($url);
	my $form_img = qr/http:\/\/eden-cf.komica.org\/00\/src\/\d+.\w+/;
	my @link_img = grep {
		if($_ =~ /"($form_img)"/){ $_ = $1; }
	} split '\n', $content;
	push @url_img, @link_img;
	$cont++;
}

sub Grabber_img{
	my $url = shift;
	my $FN;
	if($url =~ /http:\/\/eden-cf.komica.org\/00\/src\/(\d+.\w+)/ ){ $FN = $1; }
	say "Copying file: $FN";
	my $content = dav_getK::getK_content($url);
	open WFN, ">$FN";
	binmode  WFN;
	print WFN $content;
	close (WFN);
	move($FN, 'jpgs')if -r 'jpgs';
}
sub Grabber_HTML{
	my $num = shift;
	my $url = 'http://eden.komica.org/00/'.$num.'.htm?';
	$komica{$num} = dav_getK::getK_content($url);
	say "$num Finished!!";
}