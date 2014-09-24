#!/usr/bin/perl
# 紀錄格式：
# 日期::項目::金錢::備註
# 編碼：ANSI
use v5.18.2;

my @file;
while(1){
	system('cls');
	say '1: 查看紀錄';
	say '2: 記帳';
	say '3: 查找類別';
	print 'Enter: ';
	my $enter = <>;
	if($enter+0 == 1){ &load;
	} elsif ($enter+0 == 2){ &enter;
	} elsif ($enter+0 == 3){ &date_search;
	}
}

sub reload {
	open R, 'keep_accounts.txt';
	@file = map {
		chomp; 
		$_ = join "\t", (split '::', $_);
		$_;
	} <R>;
	close (R);
}

sub load {
	system('cls');
	say '======== 記帳紀錄 ========', "\n";
	unless(-e 'keep_accounts.txt') { open W, '> keep_accounts.txt'; close (W); }
	open R, 'keep_accounts.txt';
	my ($ref, $cost);
	while(<R>){
		if($_ =~ /(\S+?)::(\S+?)::(\S+)::(.+)/){
			push @{$ref->{$1}}, "  $2\t$3\t$4";
			$cost->{cost} += $3;
			$cost->{$1}{cost} += $3;
		}
	}
	for my $date (sort keys %$ref){
		say $date, ":\t該日花費: ", $cost->{$date}{cost}, "元";
		for(@{$ref->{$date}}){ say $_, "\n"; }
		$cost->{days} ++;
	}
	if($cost->{days} == 0) {
		say '沒有記錄';
		my $error = <>;
		return 1;
	}
	print "\n\t", 'Average daily cost: ', $cost->{cost} / $cost->{days}, ' NT ';
	my $pause = <>;
}

sub enter {
	open W, '>> keep_accounts.txt';
	system('cls');
	say ;
	print '請輸入日期 (ex: 0123): ';
	chomp(my $date = <>);
	say '項目選擇: ';
	say '1. 食物';
	say '2. 生活';
	say '3. 娛樂';
	say '4. 其他';
	print 'Enter: ';
	chomp(my $choice = <>);
	print '花費: ';
	chomp( my $cost = <>);
	print '備註: ';
	chomp (my $ps = <>);
	$ps = '無備註' unless $ps ne '';
	print "\n", substr ($date, 0, 2) + 0, '月', substr($date, -2), '日  ';
	print '食物  ' if $choice == 1;
	print '生活  ' if $choice == 2;
	print '娛樂  ' if $choice == 3;
	print '其他  ' if $choice == 4;
	print $cost, '元  ( ';
	say $ps, ' )';
	print '以上正確嗎? (q for menu): ';
	my $conforn = <>;
	if($conforn == 1){
		print W substr ($date, 0, 2) + 0, '月', substr($date, -2), '日::';
		print W '食物::' if $choice == 1;
		print W '生活::' if $choice == 2;
		print W '娛樂::' if $choice == 3;
		print W '其他::' if $choice == 4;
		print W $cost, '元::( ';
		say W $ps, ' )';
	} elsif ($conforn eq "q\n"){ return 1; } else { &enter; }
	close (W);
}

sub date_search {
	system('cls');
	open R, 'keep_accounts.txt';
	my ($ref, $cost);
	while(<R>){
		if($_ =~ /(\S+?)::(\S+?)::(\S+)::(.+)/){
			push @{$ref->{$1}}, "$1 : $2\t$3\t$4";
			$cost->{$1}{$2} += $3;
		}
	}
	print "查詢類別：\n",
	" 1. 食物 \n",
	" 2. 生活 \n",
	" 3. 娛樂 \n",
	" 4. 其他 \n",
	"Enter: ";
	my $search = <>;
	if($search == 1){ $search = "食物"; }  elsif ($search == 2) { $search = "生活"; } 
	elsif ($search == 3) { $search = "娛樂"; }  elsif($search == 4) { $search = "其他"; } 
	else { return 1; }
	for my $date (sort keys %$ref){
		for(@{$ref->{$date}}){ say $_ if $_ =~ /$search/; }
		say "$date $search cost: $cost->{$date}{$search}\n" if $cost->{$date}{$search} > 0;
	}
	my $pause = <>;
}