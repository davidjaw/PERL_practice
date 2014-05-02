#!/usr/bin/perl

use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Text Test");

$mw->Text(-background => 'black', -foreground => 'red')->pack(-side => "top");

MainLoop;