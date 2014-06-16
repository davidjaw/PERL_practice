use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x150");
$mw->title("Menubutton Test");

my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);

my $btn = $main_menu->Menubutton(-text => "Colorful Buttons...",
                                 -underline => 0, -tearoff=>0);
$btn->command(-label => "Button #1",
              -activebackground => "blue",
              -foreground => "blue",
              -command => sub{$mw->messageBox(-message => "Button #1 Pressed")});

$btn->command(-label => "Button #2",
              -activebackground => "red",
              -activeforeground => "black",
              -background => "yellow",
              -foreground => "green",
              -command => sub{$mw->messageBox(-message => "Button #2 Pressed")});

$btn->command(-label => "Exit", -command => sub{exit});

MainLoop;