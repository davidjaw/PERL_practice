use Tk;
use v5.18.2;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Entry Test");
# 文本小部件和入口小部件的唯一差别在于小部件的名称：
$mw->Entry(-background => 'black', -foreground => 'white')->pack(-side => "top");

MainLoop;