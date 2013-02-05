# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 8;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN {	use_ok('Cv', -more) }

my ($width, $height) = unpack("f2", pack("f2", map { rand 1 } 0..1));
my $size = Cv::cvSize2D32f($width, $height);
is_deeply($size, [$width, $height]);

SKIP: {
	skip "no T", 6 unless Cv->can('CvSize2D32f');

	{
		my $size2 = Cv::CvSize2D32f($size);
		is_deeply($size2, $size);
	}

	e { Cv::CvSize2D32f([]) };
	err_is("size is not of type CvSize2D32f in Cv::CvSize2D32f");

	{
		use warnings FATAL => qw(all);
		e { Cv::CvSize2D32f(['1x', $height]) };
		err_is("Argument \"1x\" isn't numeric in subroutine entry");
		e { Cv::CvSize2D32f([$width, '2x']) };
		err_is("Argument \"2x\" isn't numeric in subroutine entry");
	}

	{
		no warnings 'numeric';
		my $size2 = e { Cv::CvSize2D32f(['1x', '2x']) };
		err_is("");
		is_deeply($size2, [ 1, 2 ]);
	}
}