# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 9;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN {	use_ok('Cv', -more) }

my ($x, $y) = map { int rand 65536 } 0..1;
my $pt = cvPoint($x, $y);
is_deeply($pt, [ $x, $y ]);

SKIP: {
	skip "no T", 7 unless Cv->can('CvPoint');

	{
		my $pt2 = Cv::CvPoint($pt);
		is_deeply($pt2, $pt);
	}

	e { Cv::CvPoint([]) };
	err_is("Cv::CvPoint: pt is not of type CvPoint");

	e { Cv::CvPoint([1]) };
	err_is("Cv::CvPoint: pt is not of type CvPoint");

	{
		use warnings FATAL => qw(all);
		my $pt2 = e { Cv::CvPoint(['1x', '2y']) };
		err_is("Argument \"1x\" isn't numeric in subroutine entry");
	}

	{
		no warnings 'numeric';
		my $pt2 = e { Cv::CvPoint(['1x', '2y']) };
		err_is($@, "");
		is_deeply($pt2, [ 1, 2 ]);
	}

	eval "use Time::Piece";
	if ($@) {
		ok(1);
	} else {
		my $t1 = Time::Piece->strptime("2012-01-01", "%Y-%m-%d");
		my $t2 = Time::Piece->strptime("2012-01-02", "%Y-%m-%d");
		my $pt2 = Cv::CvPoint([$t2 - $t1, 0]);
		is_deeply($pt2, [ $t2 - $t1, 0 ]);
	}
}