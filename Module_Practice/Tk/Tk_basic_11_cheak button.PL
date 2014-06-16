use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x150");
$mw->title("Check Button Test");

my $check1 = 'NOT CHECKED';
my $check2 = 'NOT CHECKED';
my $check3 = 'NOT CHECKED';

my $check_frame = $mw->Frame()->pack(-side => "top");
$check_frame->Label(-text=>"Select some check buttons.")->pack(-side => "top")->pack();

my $chk1 = $check_frame->Checkbutton(-text => 'Check #1', -variable => \$check1, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->pack();
my $chk2 = $check_frame->Checkbutton(-text => 'Check #2', -variable => \$check2, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->pack();
my $chk3 = $check_frame->Checkbutton(-text => 'Check #3', -variable => \$check3, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->pack();

my $button_frame = $mw->Frame()->pack(-side => "bottom");
my $ok_button = $button_frame->Button(-text => 'OK', -command => \&check_sub)->pack(-side => "left");
my $exit_button = $button_frame->Button(-text => 'Exit', -command => sub{exit})->pack(-side => "right");

sub check_sub {
  my $check_msg = "Check #1: $check1\nCheck #2: $check2\nCheck #3: $check3";
  $mw->messageBox(-message => "Check Button Summary:\n$check_msg", -type => "ok");
}

MainLoop;