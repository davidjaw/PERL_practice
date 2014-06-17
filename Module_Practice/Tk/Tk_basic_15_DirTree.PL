use Tk;
use strict;
use Tk::DirTree;
use Cwd;

my $mw = MainWindow->new;
$mw->geometry("300x400");
$mw->title("DirTree Example");

my $CWD = Cwd::cwd();

my $DIR_TREE = $mw->Scrolled('DirTree',
                             -scrollbars => "osoe",
                             -width => 10,
                             -height => 25,
                             -exportselection => 1,
                             -browsecmd => sub {$CWD = shift},
                             -command   => \&show_cwd)->pack(-fill => "both", -expand => 1);

$DIR_TREE->chdir($CWD);

my $button_frame = $mw->Frame()->pack(-side => "bottom");
$button_frame->Button(-text => "Ok",
                      -command => \&show_cwd)->pack(-side => "left");
$button_frame->Button(-text => "Exit",
                      -command => sub{exit})->pack(-side => "left");

sub show_cwd {
  $mw->messageBox(-message => "Directory Selected: $CWD", -type => "ok");
}

MainLoop;