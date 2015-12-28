use v5.10;

my @filenames = glob '*.jpg';
mkdir 'out';
my $cont = 0;
for my $filename (@filenames) {
  my $filenameCont;
  open R, "<$filename";
  binmode(R);
  if($cont < 10) {
    $filenameCont = 'out/00'.$cont.'.jpg';
  } elsif($cont < 100) {
    $filenameCont = 'out/0'.$cont.'.jpg';
  } else {
    $filenameCont = 'out/'.$cont.'.jpg';
  }
  open W, ">$filenameCont";
  binmode(W);
  while(<R>){
    print W $_;
  }
  close(R);
  close(W);
  $cont++;
}
say '按下 ENTER 刪除檔案';
<>;
for my $filename (@filenames) {
  unlink $filename;
}
