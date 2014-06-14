use v5.18.2;
use LWP::UserAgent;   ##perl中用来处理网页请求的模块
use Encode;   ##添加处理中文的模块
use File::Copy;
require dav_trans;

my $ua = LWP::UserAgent->new();
$ua->timeout(10);
my $r = $ua->get('http://www.d586.com/gaoshoujimowojitianyi/'); 
my $string = $r->{'_content'};
# list part
my $split = (split '\r', $string)[0];
$split =~ s/href="/\n/g;
$split =~ s/<\/a><\/dd><dd><a //g;
my %list = map{
	if($_ =~ /^(\d+)\/">(\S+)/){
		$1 => $2;
	} else {
		();
	}
} split '\n', $split;
my $total;
for(keys %list){ $total++; }
# content part
# http://www.d586.com/gaoshoujimowojitianyi/
my $current = 1;
my $c = 0;
for my $num(sort keys %list){
	say "$current / $total";
	my $filename;
	if($current < 10){ $filename = '00'.$current.$list{$num}; }
	elsif($current < 100){ $filename = '0'.$current.$list{$num}; }
	else{ $filename = $current.$list{$num}; }
	my $reg = $filename;
	Encode::from_to($filename, "gbk", "big5");
	$filename = $reg if $filename =~ /\?/;
	say $filename;
	goto SKIP if -e "$filename.txt";
	open W, ">$filename.txt";
	my $url = 'http://www.d586.com/gaoshoujimowojitianyi/'.$num.'/';
	$r = $ua->get($url);
	$string = $r->{'_content'};
	my $form = qr/&nbsp;&nbsp;&nbsp;&nbsp;/;
	my @novel = map {		# @novel has only three element: topic, content, endding.
		$_ =~ s/\r//g;
		if($_ =~ /$form/){
			$_ =~ s/\<.{1,10000}?\>//g;
			$_ =~ s/$form/\n/g;
			$_;
		} else { (); }
	} split '\n', $string;
	print W @novel;
	close (W);
	$c++;
	SKIP:
	$current++;
}
say 'uncoding.........';
dav_trans::trans();
say 'done!';
my $a = <>;