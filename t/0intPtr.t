# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 6;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN {	use_ok('Cv', -more) }

my @intPtr = map { int rand 65536 } 1 .. 100;

SKIP: {
	skip "no T", 5 unless Cv->can('intPtr');

	{
		my $intPtr = Cv::intPtr(\@intPtr);
		is_deeply($intPtr, \@intPtr);
	}

	e { Cv::intPtr({}) };
	err_is("Cv::intPtr: values is not of type int *");

	{
		use warnings FATAL => qw(all);
		e { Cv::intPtr(['1x']) };
		err_is("Argument \"1x\" isn't numeric in subroutine entry");
	}

	{
		no warnings 'numeric';
		my $intPtr2 = e { Cv::intPtr([1, '2x', 3]) };
		err_is("");
		is_deeply($intPtr2, [1, 2, 3]);
	}
}