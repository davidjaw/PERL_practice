use Tk;
use Tk::LabEntry;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x100");
$mw->title("LabEntry Example");

my $name = "";
$mw->LabEntry(-label => "Enter your name: ",
              -labelPack => [ -side => "left" ],
              -textvariable => \$name)->pack();

my $button_frame = $mw->Frame()->pack(-side => "bottom");
$button_frame->Button(-text => "Ok",
                      -command => \&show_greeting)->pack(-side => "left");
$button_frame->Button(-text => "Exit",
                      -command => sub{exit})->pack(-side => "left");

sub show_greeting {
  my $msg = "Who are you?";
  if ($name ne "") { $msg = "Nice to meet you $name!"; }
  $mw->messageBox(-message => "$msg\n", -type => "ok");
}

MainLoop;