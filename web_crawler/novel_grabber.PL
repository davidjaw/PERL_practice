use v5.18.2;
use LWP::UserAgent;   ##perl中用来处理网页请求的模块
use Encode;   ##添加处理中文的模块

print 'Enter URL:';
chomp(my $glo_url = <>);

my $ua = LWP::UserAgent->new();
$ua->timeout(10);
my $r = $ua->get('$glo_url');
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
my $current = 1;
my $chk = process();
for my $num(sort keys %list){
	goto SKIP if $current < $chk;
	say "$current / $total";
	open W, '>out.txt' if $chk == 0;
	open W, '>>out.txt' if $chk > 0;
	my $url = '$glo_url'.$num.'/';
	$r = $ua->get($url);
	$string = $r->{'_content'};
	my $form = qr/&nbsp;&nbsp;&nbsp;&nbsp;/;
	my @novel = map {		# @novel has only three element: topic, content, endding.
		$_ =~ s/\r//g;
		if($_ =~ /$form/){
			$_ =~ s/\<.{1,10000}?\>//g;
			$_ =~ s/$form/\n/g;
			split '\n',$_;
		} else { (); }
	} split '\n', $string;
	$novel[$_] = undef for 1..3;
	$novel[0] =~ s/(_D586.+)(D586.+)//g;
	@novel = grep $_ ne '', @novel;
	print W "$_\n"for @novel;
	say W "\n";
	close (W);
	SKIP:
	$current++;
	process(1,$current);
}
say 'done! Delete process.dav?';
say 'If you do that, next time u open this file will reload out.txt';
say '(Enter nothing to exit, 1 to delete)';
print 'Enter:';
my $a = <>;
unlink 'process.dav' if $a == 1;

sub process {
	my ($job, $cont) = @_;		# 0讀取1寫入
	$job = 0 if $job eq '';
	$cont = 0 if $cont eq '';
	if (-e 'process.dav' && $job == 0){
		open P, 'process.dav';
		my $p = <P>;
		$cont = $p;
		close(P);
		return $cont;
	} else {
		open P, '>process.dav';
		say P $cont;
		close(P);
	}
}
 