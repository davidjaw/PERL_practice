use v5.18.2;
# getK_content needs url to get
# use LWP::UserAgent;
# use HTTP::Cookies;
 
package dav_getK{
	sub getK_content{
		my $url = shift;
		my $ua = LWP::UserAgent->new();             # get cookie
		$ua->timeout(10);                           # 
		my $code = $ua->get($url);                  # 
		my $cookie = $code->header('Set-Cookie');   # 
		$ua->agent("Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36");  # set cookie & agent
		my $req = HTTP::Request->new(GET => "$url");                                                                                  # 
		$req->header('Cookie' => "$cookie");                                                                                          # 
		my $res = $ua->request($req); # output page0
		# say $res->status_line;   # Debug
		return ($res->{_content});
	}
	return 1;
}