#!usr/bin/perl
use File::Find;
# sub what_to_do{
	# print "$File::Find::name\n";
# }
# my @starting_directories = qw(../stuff);
# find(\&what_to_do, @starting_directories);

my @starting_directories = qw(../stuff .); # muti dir
find(
	sub{
		print "$File::Find::name\n"; # $_ = filename
	},
	@starting_directories,
);