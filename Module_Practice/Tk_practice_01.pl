#!user/bin/perl
use Tk;

print "enter name: ";
$wm_name = <>;
print "enter text: ";
$text = <>;
my $mw = new MainWindow(-title=>"$wm_name");
$mw->geometry('500x500');
#                       文字內容          樣版				深度					對齊上方		xy皆對齊
my $label = $mw->Label(-text=>"$text", -relief =>'sunken', -border =>12)->pack(-side =>'top', -fill =>'both');
my $label = $mw->Label(-text=>"this is text 2", -relief =>'sunken', -border =>2);
$label->pack(-side =>'left', -fill =>'both');
my $button = $mw->Button(-text => "close", -command => sub {$mw->destroy;});
$button->pack(-side =>'bottom');

MainLoop;
