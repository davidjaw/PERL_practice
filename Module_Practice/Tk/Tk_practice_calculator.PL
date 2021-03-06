	###################################
	#     ┌┐      ┌┐                  #
	#    ┌┘┴──────┘┴┐                 #
	#    │      ─   │                 #
	#    │  ┬┘  └┬  │                 #
	#    │          │                 #
	#    │  **  ┴  *│                 #
	#    └─┐    ┌───┘                 #
	#      │    │                     #
	#      │    └─────────────┐       #
	#      │                  │       #
	#      │                  ├┐      #
	#      │                  ┌┘      #
	#      └─┐ ┐ ┌──────┐ ┐ ┌─┘       #
	#        │ │ │      │ │ │         #
	#        │ ┤ ┤      │ ┤ ┤         #
	#        └─┴─┘      └─┴─┘         #
	#     神獸保佑    程式不Bug       #
	###################################
use v5.18.2;
use Tk;
use Tk::ROText;

my $num;
my @log;

my $mw = MainWindow->new();
$mw->geometry("320x300");
$mw->title("Calculator");
$mw->resizable(0,0);  # 禁止調整大小

my $font = $mw->fontCreate( -size => '10');

my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);
my $exit_menu = $main_menu->cascade(-label=>"Exit", -underline => 10, -tearoff=>0);
$exit_menu->command(-label=>"Exit", -underline=>0, -command=>sub{exit});

my $text_frame = $mw->Frame(-width=>'320', -background=>'white', -height=>'200')->pack(-side=>'top');
	my $text_left = $text_frame->Frame(-width=>'50', -background=>'black', -height=>'200')->pack(-side=>'left');
		my $text_top_label = $text_left->Label(-background=>'white', -foreground=>'blue', -height=>'4', -text=>"state\n\nSum\n")->pack(-side=>"left");
	my $text_right = $text_frame->Frame(-width=>'280', -background=>'black', -height=>'200')->pack(-side=>'left');
		my $text_top = $text_right->ROText(-height=>'1',-background => 'black', -foreground => 'green')->pack(-side=>'top');
		$text_top->insert('@0,0', "0");
		my $text_bottom = $text_right->ROText(-height=>'2',-background => 'black', -foreground => 'green')->pack(-side=>'top');
		$text_bottom->insert('@0,0', "0");

my $button_frame = $mw->Frame(-background=>'green', -height=>'241', -width=>'321')->pack(-side=>'top');
	my $button_top = $button_frame->Frame(-background=>'green', -height=>'60', -width=>'80')->pack(-side=>'top');
		my $button_7 = 		$button_top->Button(-height=>'3', -width=>'8', -text => "7", -font=>"$font", -command => [\&button_pressed, '7'	])->pack(-side => 'left');
		my $button_8 = 		$button_top->Button(-height=>'3', -width=>'8', -text => "8", -font=>"$font", -command => [\&button_pressed, '8'	])->pack(-side => 'left');
		my $button_9 = 		$button_top->Button(-height=>'3', -width=>'8', -text => "9", -font=>"$font", -command => [\&button_pressed, '9'	])->pack(-side => 'left');
		my $button_dev = 	$button_top->Button(-height=>'3', -width=>'8', -text => "*", -font=>"$font", -command => [\&button_pressed, '*'	])->pack(-side => 'left');
	my $button_mid1 = $button_frame->Frame(-background=>'green', -height=>'60', -width=>'80')->pack(-side=>'top');
		my $button_4 = 		$button_mid1->Button(-height=>'3', -width=>'8', -text => "4", -font=>"$font", -command => [\&button_pressed, '4'	])->pack(-side => 'left');
		my $button_5 = 		$button_mid1->Button(-height=>'3', -width=>'8', -text => "5", -font=>"$font", -command => [\&button_pressed, '5'	])->pack(-side => 'left');
		my $button_6 = 		$button_mid1->Button(-height=>'3', -width=>'8', -text => "6", -font=>"$font", -command => [\&button_pressed, '6'	])->pack(-side => 'left');
		my $button_time = 	$button_mid1->Button(-height=>'3', -width=>'8', -text => "/", -font=>"$font", -command => [\&button_pressed, '/'])->pack(-side => 'left');
	my $button_mid2 = $button_frame->Frame(-background=>'green', -height=>'60', -width=>'80')->pack(-side=>'top');
		my $button_1 = 		$button_mid2->Button(-height=>'3', -width=>'8', -text => "1", -font=>"$font", -command => [\&button_pressed, '1'	])->pack(-side => 'left');
		my $button_2 = 		$button_mid2->Button(-height=>'3', -width=>'8', -text => "2", -font=>"$font", -command => [\&button_pressed, '2'	])->pack(-side => 'left');
		my $button_3 = 		$button_mid2->Button(-height=>'3', -width=>'8', -text => "3", -font=>"$font", -command => [\&button_pressed, '3'	])->pack(-side => 'left');
		my $button_minu = 	$button_mid2->Button(-height=>'3', -width=>'8', -text => "-", -font=>"$font", -command => [\&button_pressed, '-'])->pack(-side => 'left');
	my $button_bottom = $button_frame->Frame(-background=>'green', -height=>'60', -width=>'80')->pack(-side=>'top');
		my $button_ac = 	$button_bottom->Button(-height=>'3', -width=>'8', -text => "AC", -font=>"$font", -command => [\&button_pressed, 'ac'])->pack(-side => 'left');
		my $button_0 = 		$button_bottom->Button(-height=>'3', -width=>'8', -text => "0",  -font=>"$font", -command => [\&button_pressed, '0'	])->pack(-side => 'left');
		my $button_eq = 	$button_bottom->Button(-height=>'3', -width=>'8', -text => "=",  -font=>"$font", -command => [\&button_pressed, 'eq'])->pack(-side => 'left');
		my $button_pls = 	$button_bottom->Button(-height=>'3', -width=>'8', -text => "+",  -font=>"$font", -command => [\&button_pressed, '+'	])->pack(-side => 'left');

sub button_pressed{
	my $pressed_button = shift;
	unless($pressed_button eq 'ac' || $pressed_button eq 'eq'){
		if($pressed_button+0 ne $pressed_button){ # 非數字
			my $last;
			my $string = join '', @log;
			$last = $log[-1] unless (@log == 0);
			unless($last eq $pressed_button || $last+0 eq $last){
				$log[-1] = $pressed_button unless (@log == 0);
				$text_top->delete('0.0', 'end');
				$text_top->insert('@0,0', "$string");
			} else {
				push @log, $pressed_button;
				my $string = join '', @log;
				$text_top->delete('0.0', 'end');
				$text_top->insert('@0,0', "$string");
			}
		} else {
			push @log, $pressed_button;
			my $string = join '', @log;
			$text_top->delete('0.0', 'end');
			$text_top->insert('@0,0', "$string");
		}
	} elsif($pressed_button eq 'ac') {
		@log = ();
		$text_top->delete('0.0', 'end');
		$text_bottom->delete('0.0', 'end');
		$text_top->insert('@0,0', "0");
		$text_bottom->insert('@0,0', "0");
	} elsif($pressed_button eq 'eq') {
		my $cont = join '', @log;
		my @each;
		while($cont =~ /(\d+(?:\W*))/g){
			my $reg = $1;
			if($reg =~ /(\d+)(\W)/){ push @each, ($1 , $2);
			} else { push @each, $reg; }
		}
		my $sign = 0;
		JUMP:
		@each = grep $_ ne '', @each;
		for my $num(0..$#each){
			my $reg = \$each[$num];
			if($sign){
				if($$reg eq '+' || $$reg eq '-'){ 
					$$reg = $each[$num-1] + $each[$num+1] if($$reg eq '+');
					$$reg = $each[$num-1] - $each[$num+1] if($$reg eq '-');
					$each[$num-1] = '';
					$each[$num+1] = '';
					goto JUMP;
				}
			} else {
				if($$reg eq '*' || $$reg eq '/'){ 
					$$reg = $each[$num-1] * $each[$num+1] if($$reg eq '*');
					$$reg = $each[$num-1] / $each[$num+1] if($$reg eq '/');
					$each[$num-1] = '';
					$each[$num+1] = '';
					goto JUMP;
				}
			}
		}
		$sign++;
		goto JUMP unless($sign > 1);
		@log = ();
		my $string = join '', @each;
		$text_bottom->delete('0.0', 'end');
		$text_bottom->insert('@0,0', "$string");
	}
}
MainLoop;