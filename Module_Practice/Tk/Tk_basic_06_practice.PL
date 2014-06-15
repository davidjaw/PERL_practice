use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("500x200");
$mw->title("All-In-One Test");


my $main_frame = $mw->Frame()->pack(-side => 'top', -fill => 'x');

my $top_frame = $main_frame->Frame(-background => "red")->pack(-side => 'top', -fill => 'x');
my $left_frame = $main_frame->Frame(-background => "black")->pack(-side => 'left', -fill => 'y');
my $right_frame = $main_frame->Frame(-background => "white")->pack(-side => "right");

$top_frame->Label(-text => "All-In-One Test!",  -background => "red")->pack(-side => "top");
$left_frame->Label(-text => "Enter text to copy", -background => "black", -foreground => "yellow")->pack(-side => "left");
my $copy_entry = $left_frame->Entry(-background => "white", -foreground => "red")->pack(-side => "left");
my $copy_button = $left_frame->Button(-text => "Copy Text", -command => \&copy_entry)->pack(-side => "right");

my $clear_text = $right_frame->Button(-text => "Clear Text", -command => \&clear_entry)->pack(-side => "top");
my $paste_text = $right_frame->Text(-background => "white", -foreground => "black")->pack(-side => "top");

sub clear_entry {
  $paste_text->delete('0.0', 'end');
}

sub copy_entry {
  my $copied_text = $copy_entry->get();
  $paste_text->insert("end", $copied_text);
}

MainLoop;