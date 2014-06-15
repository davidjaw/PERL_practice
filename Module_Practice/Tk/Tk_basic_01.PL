use v5.18.2;
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x70");
$mw->title("Hello World!!!");

# 在主窗口内创建一个标签，并使用标题 Hello World。标签创建的末尾是一个附加函数 pack，它是一个几何管理器。
# 该管理器用于小部件上，用来计算在小部件的父部件上分配的空间；同时还显示该小部件：
$mw->Label(-text => 'Hello World')->pack();
# 该代码行在主窗口中创建一个“Close”按钮。当通过鼠标点击激活或用键盘执行它后，此按钮将退出 Perl 脚本：
$mw->Button(-text => "Close", -command =>sub{exit})->pack();
# 而且，由于此按钮占用主窗口的空间，所以需要使用 pack 函数来计算所占用的空间。

MainLoop;