use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Scrollbar Test");

my $scroll_text = $mw->Scrollbar();

my $main_text = $mw->Text(-yscrollcommand => ['set', $scroll_text], -background => 'black', -foreground => 'red');

$scroll_text->configure(-command => ['yview', $main_text]);

$scroll_text->pack(-side=>"right", -expand => "no", -fill => "y");
$main_text->pack(-side => "left", -anchor => "w", -expand => "yes", -fill => "both");

MainLoop;