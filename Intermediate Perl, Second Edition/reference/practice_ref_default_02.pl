#!/usr/bin/perl
#示範在匿名串列下的賦值
	$keyword_ref = {
		"filename" => [],
		"times" => [],
	};
push @{$keyword_ref->{"filename"}}, 'asdfasdfasdf'; 
print @{$keyword_ref->{"filename"}};
