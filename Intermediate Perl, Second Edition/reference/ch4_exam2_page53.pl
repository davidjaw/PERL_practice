my @david = qw/lipton pen foods brain/;
my @dennis = qw/foods foods foods foods foods foods/;
my @jason = qw/pen brain purpose/;
my %all = (
	david => \@david,
	dennis => \@dennis,
	jason => \@jason
);

cheak_item_OK(\%all);

sub cheak_item_OK{
	my @need = qw/girlfriend foods brain purpose pen/;
	my $ref = shift;
	for my $name (keys %$ref){
		for my $NI (@need){
			my $cheak = 0;
			for my $item (@{$ref->{$name}}){
				if($item eq $NI){ $cheak++; }
			}
			if($cheak == 0){ print "$name don't have $NI\n"; }
		}
		print "\n";
	}
}