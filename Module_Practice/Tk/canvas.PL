use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("400x300");
$mw->title("Canvas Example");

my $canvas = $mw->Canvas(-relief => "sunken", -background => "blue");

$canvas->createLine(2, 3, 350, 100, -width => 10, -fill => "black");
$canvas->createLine(120, 220, 450, 200, -fill => "red");
$canvas->createOval(30, 80, 100, 150, -fill => "yellow");
$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");
$canvas->createArc(40, 40, 200, 200, -fill => "green");
$canvas->createPolygon(350, 120, 190, 160, 250, 120, -fill => "white");

$canvas->pack();

$mw->Button(-text => 'Exit', -command => sub {exit})->pack();;

MainLoop;