# 資料是四位元的整數，在傳遞過程中是加密的，加密規則如下：每位元數位都加上5,然後用和除以10的餘數代替該數位，再將第一位和第四位交換，第二位和第三位交換。
# 編寫一個程式，使用戶在輸入資料後，可以用加密碼輸出
use v5.18.2;
<<<<<<< HEAD
print 'enter: ';
chomp(my $in = <>);
die "Wrong form" if length $in > 4;
my @out = split '', $in;
@out = map { ($_ + 5)%10 } @out;
my $output = $out[3];
$out[3] = $out[0];
$out[0] = $output;
$output = $out[1];
$out[1] = $out[2];
$out[2] = $output;
say @out;
$output = join '', @out;
say $output;
=======
>>>>>>> bbfadd2dabab9e11762280327499a0d66487e842
