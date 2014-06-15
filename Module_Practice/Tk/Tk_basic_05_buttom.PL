use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Button Test");
#                                                command = do if pressed 
my $button1 = $mw->Button(-text => "Button #1", -command => \&button1_sub)->pack();

my $button2 = $mw->Button(-text => "Button #2", -command => \&button2_sub)->pack();

sub button1_sub {
  $mw->messageBox(-message => "Button 1 Pushed", -type => "ok");
  #                                                       出現一個確認按鈕
}

sub button2_sub {
  my $yesno_button = $mw->messageBox(-message => "Button 2 Pushed. Exit?",
                                        -type => "yesno", -icon => "question");

  $mw->messageBox(-message => "You pressed $yesno_button!", -type => "ok");

  if ($yesno_button eq "Yes") {
    $mw->messageBox(-message => "Ok, Exiting.", -type => "ok");
    exit;
  } else {
    $mw->messageBox(-message => "I didn't think so either.", -type => "ok");
  }
}

MainLoop;