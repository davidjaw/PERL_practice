use v5.18.2;
# getK_content needs url to get
# use LWP::UserAgent;
# use HTTP::Cookies;
 
package dav_getK{
	sub getK_content{
		my $url = shift;
		# get cookie
		my $ua = LWP::UserAgent->new();
		$ua->timeout(10);
		my $code = $ua->get($url);
		my $cookie = $code->header('Set-Cookie');
		# set cookie & agent
		$ua->agent("Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36");
		my $req = HTTP::Request->new(GET => "$url");
		$req->header('Cookie' => "$cookie");
		# output page0
		my $res = $ua->request($req);
		# say $res->status_line;
		return ($res->{_content});
	}
	return 1;
}