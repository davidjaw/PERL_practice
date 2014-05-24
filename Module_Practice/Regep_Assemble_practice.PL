# my $passenger = qr/(?:Mr. Howell|Mrs. Howell|Mary Ann)/;
# can use Regexp::Common to make it easier
use v5.18;
use Regexp::Assemble;
my $ra = Regexp::Assemble->new;
for( 'Mr. Howell', 'Mrs. Howell', 'Mary Ann' ){
	$ra -> add( "\Q$_" );
}
say $ra->re;

#沒裝此模組= =