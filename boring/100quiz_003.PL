use v5.18.2;
# 一個整數，它加上100後是一個完全平方數，再加上168又是一個完全平方數，請問該數是多少？
for(0..10000){
	my $ans = $_;
	my $first = sqrt ($ans + 100);
	my $second = sqrt ($ans + 168);
	if(length $first < 8 && length $second < 8){ say $ans; }
}