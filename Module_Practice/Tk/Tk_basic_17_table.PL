use Tk;
use Tk::Table;
use strict;

my $mw = MainWindow->new;
$mw->geometry("475x125");
$mw->resizable(0,0);  # 禁止調整大小
$mw->title("Table Example");

my $table_frame = $mw->Frame()->pack();
my $table = $table_frame->Table(-columns => 8,
                                -rows => 4,
                                -fixedrows => 1,
                                -scrollbars => 'oe',
                                -relief => 'raised');

foreach my $col (1 .. 8)
{
  my $tmp_label = $table->Label(-text => "COL " . $col, -width => 8, -relief =>'raised');
  $table->put(0, $col, $tmp_label);
}

foreach my $row (1 .. 8)
{
  foreach my $col (1 .. 8)
  {
    my $tmp_label = $table->Label(-text => $row . "," . $col,
                                  -padx => 2,
                                  -anchor => 'w',
                                  -background => 'white',
                                  -relief => "groove");
    $table->put($row, $col, $tmp_label);
  }
}
$table->pack();

my $button_frame = $mw->Frame( -borderwidth => 4 )->pack();
$button_frame->Button(-text => "Exit", -command => sub {exit})->pack();

MainLoop;