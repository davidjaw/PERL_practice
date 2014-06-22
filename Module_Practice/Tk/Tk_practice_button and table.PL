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
use Tk::LabFrame;

my $HP = 1000;
my $state = 0;
my $weapon = 0;

my $mw = MainWindow->new();
$mw->geometry("330x200");
$mw->title("Boring practice");
$mw->resizable(0,0);  # 禁止調整大小

my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);
my $exit_menu = $main_menu->cascade(-label=>"Statue", -underline => 10, -tearoff=>0);
$exit_menu->command(-label=>"View", -underline=>0, -command=>sub{exit});
$exit_menu->command(-label=>"Change", -underline=>0, -command=>sub{exit});
##############################################################################################
my $upper_wd = $mw->LabFrame(-foreground=>"green", -label => '     Actions     ',-labelside => "top", -height => '50', -background => 'black')->pack(-side => 'top', -fill=>'x');
	my $walk_button = $upper_wd->Button(-width=>'10' , -text => "Walk", -command => \&walk)->pack(-side => 'left');
	my $attack_button = $upper_wd->Button(-width=>'10' , -text => "Attack", -command => \&attack)->pack(-side => 'left');
my $upper_wp = $upper_wd->Frame(-background => 'black')->pack(-side => 'right');
	my $radio_weapon = $upper_wp->Radiobutton(-text => "Use  weapon", -value => "1", -variable=> \$weapon)->pack(-side => "right");
	my $radio_weapon = $upper_wp->Radiobutton(-text => "Fight with arm", -value => "0", -variable=> \$weapon)->pack(-side => "right");
##############################################################################################
my $body_wd = $mw->Frame(-background => 'white', -width => '450', -height => '40')->pack(-side => 'top');
my $body_left = $body_wd->Frame(-background => 'white')->pack(-side => 'left');
	my $HP_label = $body_left->Label(-background => 'white', -text=>"Monster's HP:")->pack(-side=>'left');
my $body_right = $body_wd->Frame(-background => 'white', -width => '450', -height => '40')->pack(-side => 'right', -fill => 'x');
##############################################################################################
my $bottom_frame = $mw->Frame(-height => 400, -width => '300', -background=>'black')->pack(-side=>'top', -fill=>'y');
my $scroll = $bottom_frame->Scrollbar();
my $text = $bottom_frame->ROText(-background => 'black', -foreground => 'green', -yscrollcommand => ['set', $scroll]);
$scroll->configure(-command => ['yview', $text]);
$scroll->pack(-side => "right", -expand => "no", -fill => "y");
$text->pack();
$text->delete('0.0', 'end');
$text->insert('@0,0', "Current Statue: Normal \n");
##############################################################################################
my $canvas = $body_right->Canvas(-height => '40', -width => '450', -relief => "sunken", -background => "white");
my $hp = $canvas->createLine(5, 20, 205, 20, -width => 10, -fill => "red");
$canvas->pack(-side => 'top');


sub attack{
	if($state){
		my $random = int(rand 50);
		$random += 50 if $random >= 45;
		$random = ($random * 110 / 100) if($weapon);
		$text->insert('@0,0', "(Gain 10% more damage by weapon.)\n") if($weapon);
		$mw->messageBox(-message => "Critical attack!!!!!") if($random/1.1 >= 45);
		$text->insert('@0,0', "Critical attack!!! Deal \'$random\' damage!!\n") if $random/1.1 >= 45;
		$text->insert('@0,0', "Deal \'$random\' damage\n") if $random/1.1 < 45;
		$canvas->delete($hp);
		$HP = $HP - $random;
		if($HP > 0){
			my $endX = int($HP / 5) + 5;
			$hp = $canvas->createLine(5, 20, $endX, 20, -width => 10, -fill => "red");
		} else {
			$state = 0;
			$text->insert('@0,0', "Congratulations!! Monster is dead!!\n");
			$HP = 1000;
		}
	} else {
		$mw->messageBox(-message=>"There is no monster to attack.");
	}
}
sub walk{
	if($state){
		$text->insert('@0,0', "Cant walk if there is a monster....\n");
	} else {
		my $random = int(rand 50);
		$mw->messageBox(-message => 'Monster appear!!!') if $random >= 25;
		$text->insert('@0,0',"Monster appear!!!!!!\nMonster current HP: 1000/1000\n")if $random >= 25;
		$text->insert('@0,0', "No monster appear.....\n")if $random < 25;
		$state = 1 if $random >= 25;
	}
}
MainLoop;