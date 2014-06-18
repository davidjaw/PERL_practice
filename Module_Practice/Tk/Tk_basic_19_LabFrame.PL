use Tk;
use Tk::LabFrame;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x200");
$mw->title("LabFrame Example");

my $labeled_frame1 = $mw->LabFrame(-label => "Caption Across Top of Frame",
                                   -labelside => "acrosstop")->pack();

my $labeled_frame2 = $mw->LabFrame(-label => "Caption Below Frame",
                                   -labelside => "bottom")->pack(-fill => "x");

$labeled_frame1->Label(-text => "Inside Frame #1")->pack();
$labeled_frame2->Label(-text => "Inside Frame #2")->pack();

my $button_frame = $mw->Frame()->pack(-side => "bottom");
$button_frame->Button(-text => "Exit",
                      -command => sub{exit})->pack();

MainLoop;