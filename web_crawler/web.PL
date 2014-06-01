use v5.18.2;
use Encode;   ##添加处理中文的模块
use LWP::UserAgent;   ##perl中用来处理网页请求的模块

# open W, '>out2.txt';

my $ua = LWP::UserAgent->new();
$ua->timeout(10);
my $r = $ua->get('http://www.80txt.com/txtml_50346.html'); 
my $string = $r->{'_content'};
my @url =  map {
	if($_ =~ /\=\"(\S+)?\"\>/){
		$_ = $1;
	} else { (); }
} map {
	if($_ =~ m/^<li><a rel="nof/){ $_; }
} split '\n', $string;
# novel part
say $url[50];
# for(0..$#url){
	# say "\t$_ / $#url";
	# my $filename;
	# my %exits = map { $_ => 1 }glob '*.txt';
	# if($_ < 10){ $filename = "00$_.txt"; } elsif($_ < 100){ $filename = "0$_.txt"; } else { $filename = "$_.txt"; }
	# if($exits{$filename} == 1){ goto endd; } else { open W, ">$filename"; }
	
	# $r = $ua->get($url[$_]);
	# $string = $r->{'_content'};
	# my @novel;
	# my $form = qr/&nbsp;&nbsp;&nbsp;&nbsp;/;
	# my @a = map {
		# $_ =~ s/\r//g;
		# if($_ =~ /$form/){
			# $_ =~ s/\<.{1,10000}?\>//g;
			# $_ =~ s/$form/\n/g;
			# $_;
		# } else { (); }
	# } split '\n', $string;
	# say W @a;
	# endd:
# }