use v5.18.2;
use LWP::UserAgent;
use HTTP::Cookies;
use File::Copy;
require get_K;
# version: v1.0.0

my $url = 'http://eden.komica.org/00/index.htm';
my ($content) = dav_getK::getK_content($url);
open W, '>komica.html';
say W $content;
close(W);

my $form = qr/http:\/\/eden-cf.komica.org\/00\/src\/\d+.\w+/;
open R, 'komica.html';
my @links = grep { 
	if($_ =~ /"($form)"/){ $_ = $1; }
} <R>;
# grab photos
for(@links){
	my $FN;
	if($_ =~ /http:\/\/eden-cf.komica.org\/00\/src\/(\d+.\w+)/ ){ $FN = $1; }
	say "Copying file: $FN";
	my $content = dav_getK::getK_content($_);
	open WFN, ">$FN";
	binmode  WFN;
	print WFN $content;
	close (WFN);
	move($FN, 'jpgs')if -r 'jpgs';
}