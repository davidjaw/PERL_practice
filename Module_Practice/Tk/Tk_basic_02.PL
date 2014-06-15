
use Tk;
use v5.18.2;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Frame Test");

$mw->Frame(-background => 'red')->pack(-ipadx => 50, -side => "left", -fill => "y");
$mw->Frame(-background => 'blue')->pack(-ipadx => 50, -side => "right", -fill => "y");

MainLoop;