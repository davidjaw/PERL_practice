use v5.18.2;
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;

my $req = HTTP::Request->new(GET => 'http://eden.komica.org/00/index.htm');

my $head = $ua->get('http://eden.komica.org/00/index.htm');
say $head->{'SetCookie'};

$req->header('Cookie' => "__cfduid=d6019b1b09176581c715dc56bd7a7b32c1402301693069; expires=Mon, 23-Dec-2019 23:50:00 GMT; path=/; domain=.komica.org;HttpOnly");


my $res = $ua->request($req);
print $res->status_line;