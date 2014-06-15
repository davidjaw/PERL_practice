###################################
#     ┌┐      ┌┐
#    ┌┘┴──────┘┴┐
#    │      ─   │
#    │  ┬┘  └┬  │
#    │          │
#    │  **  ┴  *│
#    └─┐    ┌───┘
#      │    │
#      │    └─────────────┐
#      │                  │
#      │                  ├┐
#      │                  ┌┘
#      └─┐ ┐ ┌──────┐ ┐ ┌─┘
#        │ │ │      │ │ │
#        │ ┤ ┤      │ ┤ ┤
#        └─┴─┘      └─┴─┘
#     神獸保佑    程式不Bug
###################################
use Tk;
use v5.18.2;

my $cont;
my $mw = MainWindow->new;
$mw->geometry("400x100");
$mw->title("All-In-One Test");

my $main_frame = $mw->Frame()->pack(-side => 'top', -fill => 'x');

my $top_frame = $main_frame->Frame(-background => "blue")->pack( -side => "top", -fill => "x" );
my $top_label = $top_frame->Label(-text => "   Enter number to INSERT.   ", -foreground => 'blue', -background => 'white')->pack(-side => 'top');

my $left_frame = $main_frame->Frame(-background => "white")->pack(-side => "left", -fill => "y");
	my $left_top = $left_frame->Frame(-background => "black")->pack(-side => "top", -fill => "x");
		my $left_top_label = $left_top->Label(-text => 'Enter Num1: ', -background => 'white', -foreground => 'purple')->pack(-side => 'left');
		my $left_top_entry = $left_top->Entry(-background => 'black', -foreground => 'green')->pack(-side => 'left');
	my $left_mid = $left_frame->Frame(-background => "black")->pack(-side => "top", -fill => "x");
		my $left_mid_label = $left_mid->Label(-text => 'Enter Num2: ', -background => 'white', -foreground => 'purple')->pack(-side => 'left');
		my $left_mid_entry = $left_mid->Entry(-background => 'black', -foreground => 'green')->pack(-side => 'left');
	my $left_bottom = $left_frame->Frame(-background => "black")->pack(-side => "top", -fill => "x");
		my $left_bottom_label = $left_bottom->Label(-text => 'Enter Num3: ', -background => 'white', -foreground => 'purple')->pack(-side => 'left');
		my $left_bottom_entry = $left_bottom->Entry(-background => 'black', -foreground => 'green')->pack(-side => 'left');
	my $left_button = $left_frame->Frame(-background => 'blue')->pack(-side => 'top', -fill => 'x');
		my $left_button = $left_button->Button(-text => 'Submit', -command => \&submit)->pack(-side => 'right');


my $right_frame = $main_frame->Frame(-background => 'yellow')->pack(-side => 'right', -fill => 'y');
	my $right_top = $right_frame->Frame(-background => 'yellow')->pack(-side => 'top', -fill => 'x');
	my $right_text_frame = $right_frame->Frame(-background => 'white', -foreground => 'purple')->pack(-side => 'top', -fill => 'y');
		my $right_text = $right_text_frame->Text(-background => 'white', -foreground => 'purple')->pack(-side => 'top');
	my $right_clear = $right_top->Button(-text => 'ClEaR', -command => \&clear)->pack(-side => 'top');
		sub clear{
			say 'CLEAR pressed.';
			$right_text->delete('0.0', 'end');
		}

MainLoop;


sub submit {
	my $string_1 = $left_top_entry->get(); say "get string1: $string_1";
	my $string_2 = $left_mid_entry->get(); say "get string2: $string_2";
	my $string_3 = $left_bottom_entry->get(); say "get string3: $string_3";
	$right_text->insert("end", "Num1:$string_1, Num2:$string_2, Num3:$string_3\n");
}