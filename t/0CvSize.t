# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 8;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN {	use_ok('Cv', -more) }

my ($width, $height) = map { int rand 16384 } 0..1;
my $size = Cv::cvSize($width, $height);
is_deeply($size, [$width, $height]);

SKIP: {
	skip "no T", 6 unless Cv->can('CvSize');

	{
		my $size2 = Cv::CvSize($size);
		is_deeply($size2, $size);
	}

	e { Cv::CvSize([]) };
	err_is("Cv::CvSize: size is not of type CvSize");

	{
		use warnings FATAL => qw(all);
		e { Cv::CvSize(['1x', $height]) };
		err_is("Argument \"1x\" isn't numeric in subroutine entry");
		e { Cv::CvSize([$width, '2x']) };
		err_is("Argument \"2x\" isn't numeric in subroutine entry");
	}

	{
		no warnings 'numeric';
		my $size2 = e { Cv::CvSize(['1x', '2x']) };
		err_is("");
		is_deeply($size2, [ 1, 2 ]);
	}
}