#!/usr/bin/perl
use v5.18.2;
use lib qw'lib out out/images';
use Mojo::UserAgent;
use threads;
use threads::shared;

# define all url to crawl
my @domainURL = qw'http://sage.komica.org/00/index.htm';
push @domainURL, "http://sage.komica.org/00/$_.htm" for 1..10;
our @finalURL:shared;
our @imgURL:shared;

# crawl out every resURL
for(0..1){
	say '--------------------grabbing resURLs-----------------------';
	my $th0 = threads->new( \&crawl, "$domainURL[$_*5 + 0]");
	my $th1 = threads->new( \&crawl, "$domainURL[$_*5 + 1]");
	my $th2 = threads->new( \&crawl, "$domainURL[$_*5 + 2]");
	my $th3 = threads->new( \&crawl, "$domainURL[$_*5 + 3]");
	my $th4 = threads->new( \&crawl, "$domainURL[$_*5 + 4]");
	
	&threadJoin;
}
$_ = 'http://sage.komica.org/00/'.$_ for @finalURL;
say "\n\n";

# crawl out every imgURL
for(0..9){
	say '------------------Grabbing imgURLs-------------------------';
	my $th0 = threads->new( \&crawl, "$finalURL[$_*5 + 0]", 1);
	my $th1 = threads->new( \&crawl, "$finalURL[$_*5 + 1]", 1);
	my $th2 = threads->new( \&crawl, "$finalURL[$_*5 + 2]", 1);
	my $th3 = threads->new( \&crawl, "$finalURL[$_*5 + 3]", 1);
	my $th4 = threads->new( \&crawl, "$finalURL[$_*5 + 4]", 1);
	
	&threadJoin;
}
say "\n\nGot ", $#imgURL + 1, " imgURLs! ";

# get img!
my $times = int $#imgURL / 5 + 1;
for(0..$times){
	my $left = $times * 5 - $_ * 5;
	say "-------------------- Downloading, $left img left --------------------";
	my $th0 = threads->new( \&getImg, "$imgURL[$_*5 + 0]");
	my $th1 = threads->new( \&getImg, "$imgURL[$_*5 + 1]");
	my $th2 = threads->new( \&getImg, "$imgURL[$_*5 + 2]");
	my $th3 = threads->new( \&getImg, "$imgURL[$_*5 + 3]");
	my $th4 = threads->new( \&getImg, "$imgURL[$_*5 + 4]");
	
	&threadJoin;
}

sub threadJoin {
	for my $thread(threads->list(threads::all)){
		WAIT:
		if($thread->is_joinable()){
			$thread->join();
		} else { goto WAIT }
	}
}

sub crawl {
	my ($url, $method) = @_;
	$method = 0 unless $method == 1;
	say "Dealing $url , method = $method";
	my $urlForm = do {
		if($method == 0){ 'index\.php\?res=' }
		elsif($method == 1) { 'http://sage.komica.org/00/src/' }
	};
	my @crawl = map {
		if($_ =~ /(?:href=[\"]*)($urlForm\d+[\.]*\w*)/){ $1; } else { (); }
	} split '\n', Mojo::UserAgent->new(max_redirects => 3)->get($url => {DNT => 1})->res->body;
	push @finalURL, @crawl if $method == 0;
	push @imgURL, @crawl unless $method == 0;
}

sub getImg{
	my $url = shift;
	return if $url eq '';
	my $fileName = $1 if $url =~ /(\d+\.\w+$)/;
	say 'Downloading ', $fileName, '.....';
	open W, ">out/images/$fileName";
	binmode (W);
	say W Mojo::UserAgent->new->get($url => {DNT => 1})->res->body;
	close(W);
}
