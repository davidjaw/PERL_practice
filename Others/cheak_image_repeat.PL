###################################
#     �z�{      �z�{                  #
#    �z�}�r�w�w�w�w�w�w�}�r�{                 #
#    �x      �w   �x                 #
#    �x  �s�}  �|�s  �x                 #
#    �x          �x                 #
#    �x  **  �r  *�x                 #
#    �|�w�{    �z�w�w�w�}                 #
#      �x    �x                     #
#      �x    �|�w�w�w�w�w�w�w�w�w�w�w�w�w�{       #
#      �x                  �x       #
#      �x                  �u�{      #
#      �x                  �z�}      #
#      �|�w�{ �{ �z�w�w�w�w�w�w�{ �{ �z�w�}       #
#        �x �x �x      �x �x �x         #
#        �x �t �t      �x �t �t         #
#        �|�w�r�w�}      �|�w�r�w�}         #
#     ���~�O��    �{����Bug       #
###################################
# ���{���ˬdJPG��PNG�ɮ׬O�_����
use v5.18.2;

my @filename = glob '*.jpg';
@filename = (@filename , glob '*.png' );

my %hash;
for(@filename){
	open R, $_;
	binmode R;
	@{$hash{$_}} = <R>;
	close (R);
}

SIGN:
for my $outterFN(keys %hash){
	my @outter_reg = $hash{$outterFN};
	for my $innerFN(keys %hash){
		next if $outterFN eq $innerFN;
		my $cheak = 0;
		my @inner_reg = $hash{$innerFN};
		for my $outter(@outter_reg){
			for my $inner(@inner_reg){
				$cheak++ if $outter ne $inner;
				last if $cheak > 0;
			}
		}
		if($cheak > 0){
			say "$outterFN is the same as $innerFN !";
			unlink $outterFN;
			delete $hash{$outterFN};
			say 'Delete complite! Press enter to continue';
			my $a = <>;
			goto SIGN;
		}
	}
}