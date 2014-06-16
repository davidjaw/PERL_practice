use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Multiple Windows Test");

my $subwin1 = $mw->Toplevel;
$subwin1->title("Sub Window #1");

my $subwin2 = $mw->Toplevel;
$subwin2->title("Sub Window #2");

MainLoop;