use v5.18.2;
use threads;
use threads::shared;
use LWP::UserAgent;
use HTTP::Cookies;

say 'Enter URL: ';
chomp(my $url = <>);
my $ua = LWP::UserAgent->new();
$ua->timeout(10);
my $code = $ua->get($url);
my $cookie = $code->header('Set-Cookie');
$ua->agent("Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36");
my $req = HTTP::Request->new(GET => "$url");
$req->header('Cookie' => "$cookie");
my $res = $ua->request($req);
# ¨ú±o­¶¼Æ
my @url = map {
	chomp $_;
	if($_ =~ /<strong>/){ 
		if($_ =~ /http/){ $_; } else { (); } 
	} else { (); }
} $res->{_content};
@url = sort { $a <=> $b } map {
	if($_ =~ /http/){ 
		if($_ =~ /\d+\-(\d+)\-/){ $1; } else { (); } 
	} else { (); }
} split '"', $url[0];
my $page = $url[-1];
say $page;


















