#!/usr/bin/perl
# �����榡�G
# ���::����::����::�Ƶ�
# �s�X�GANSI
use v5.18.2;

my @file;
while(1){
	system('cls');
	say '1: �d�ݬ���';
	say '2: �O�b';
	say '3: �d�����O';
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
	say '======== �O�b���� ========', "\n";
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
		say $date, ":\t�Ӥ��O: ", $cost->{$date}{cost}, "��";
		for(@{$ref->{$date}}){ say $_, "\n"; }
		$cost->{days} ++;
	}
	if($cost->{days} == 0) {
		say '�S���O��';
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
	print '�п�J��� (ex: 0123): ';
	chomp(my $date = <>);
	say '���ؿ��: ';
	say '1. ����';
	say '2. �ͬ�';
	say '3. �T��';
	say '4. ��L';
	print 'Enter: ';
	chomp(my $choice = <>);
	print '��O: ';
	chomp( my $cost = <>);
	print '�Ƶ�: ';
	chomp (my $ps = <>);
	$ps = '�L�Ƶ�' unless $ps ne '';
	print "\n", substr ($date, 0, 2) + 0, '��', substr($date, -2), '��  ';
	print '����  ' if $choice == 1;
	print '�ͬ�  ' if $choice == 2;
	print '�T��  ' if $choice == 3;
	print '��L  ' if $choice == 4;
	print $cost, '��  ( ';
	say $ps, ' )';
	print '�H�W���T��? (q for menu): ';
	my $conforn = <>;
	if($conforn == 1){
		print W substr ($date, 0, 2) + 0, '��', substr($date, -2), '��::';
		print W '����::' if $choice == 1;
		print W '�ͬ�::' if $choice == 2;
		print W '�T��::' if $choice == 3;
		print W '��L::' if $choice == 4;
		print W $cost, '��::( ';
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
	print "�d�����O�G\n",
	" 1. ���� \n",
	" 2. �ͬ� \n",
	" 3. �T�� \n",
	" 4. ��L \n",
	"Enter: ";
	my $search = <>;
	if($search == 1){ $search = "����"; }  elsif ($search == 2) { $search = "�ͬ�"; } 
	elsif ($search == 3) { $search = "�T��"; }  elsif($search == 4) { $search = "��L"; } 
	else { return 1; }
	for my $date (sort keys %$ref){
		for(@{$ref->{$date}}){ say $_ if $_ =~ /$search/; }
		say "$date $search cost: $cost->{$date}{$search}\n" if $cost->{$date}{$search} > 0;
	}
	my $pause = <>;
}