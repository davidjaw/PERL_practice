use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("400x50");
$mw->title("Multiple Windows Test");

my $button1 = $mw->Button(-text => "Open new window", -command => \&button1_sub)->pack(-side => "top");
$mw->Button(-text => "Exit", -command => sub{exit})->pack();

sub button1_sub {
  my $subwin1 = $mw->Toplevel;
  $subwin1->geometry("300x25");
  $subwin1->title("Sub Window #1");
  my $subwin_button = $subwin1->Button(-text => "Close window", -command => [$subwin1 => 'destroy'])->pack();
}
MainLoop;