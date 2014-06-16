use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x150");
$mw->title("Menu Test");

my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);
my $exit_menu = $main_menu->cascade(-label=>"Exit", -underline => 0, -tearoff=>0);
$exit_menu->command(-label=>"Exit", -underline=>0, -command=>sub{exit});
$main_menu->command(-label=>"Say Hello", -underline => 0, -command=>sub{$mw->messageBox(-message=>"Hello!", -type => "ok")});

MainLoop;