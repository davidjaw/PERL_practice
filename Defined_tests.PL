use v5.18.2;
my $num = 100;
my $num0 = 0;
my $string = 'string';
my $string0 = '';
say 'num defined' 		if ($num 	== defined);  # WHY?
say 'num0 undef'		if ($num0 	== undef);
say 'string defined'	if ($string 	== defined);
say 'string0 undef' 	if ($string0 == undef);