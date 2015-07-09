use v5.18.2;
my ( $inFile, $method ) = ($ARGV[0], $ARGV[1]);
my (@out, @varName, $in, $out, $ref);
if($method == ''){
  $in = $inFile;
} else {
  say "fileName: $inFile";
  open R, "$inFile";
  @out = <R>;
  $in = join '', map { chomp; $_; } @out;
  close(R);
}
@out = '';
while($in =~ /'(.+?)'/g){
  push @out, $1;
}
while($in =~ /\+\s*([^\s]+?)\s*\+/g){
  push @varName, '${'.$1.'}';
}
$out = join '', @out;
@out = '';
say "check \n$out\n";
check($out);
for(0..$#varName){
  $out[$_] = $varName[$_];
}
say join '', @out;
my $space = 0;
sub check {
  my ($inString, $spaceStr, $tmpReg, $tmp) = (shift, undef);
  return 0 if $space > 10;
  if($inString =~ /(.*?\<[^\/]*?)\</){
    $spaceStr = ' ' x ($space*2);
    $tmp = $1;
    $tmpReg = quotemeta($1);
    $space++;
    $inString =~ s/$tmpReg//;
  } elsif ($inString =~ /(.*?\<\/.*?)\</){
    $tmp = $1;
    $tmpReg = quotemeta($1);
    $space--;
    $spaceStr = ' ' x ($space*2);
    $inString =~ s/$tmpReg//;
  }
  push @out, $spaceStr.$tmp."\n";
  if ($inString =~ /\<.*?\</) {
    check($inString) 
  } else { push @out, $inString."\n"; }
}
