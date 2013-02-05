# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 9;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN { use_ok('Cv') }

if (1) {
	my @pts = map { [ map { rand } qw(x y) ] } 1 .. rand 100;
	my $seq = Cv::Seq::Point->new(CV_64FC2, @pts);
	isa_ok($seq, 'Cv::Seq::Point');
	is_deeply([@$seq], [@pts]);
}

if (2) {
	my @pts = map { [ map { rand } qw(x y) ] } 1 .. rand 100;
	my $seq = Cv::Seq::Point->new(CV_64FC2, [@pts]);
	isa_ok($seq, 'Cv::Seq::Point');
	is_deeply([@$seq], [@pts]);
}

if (3) {
	my @pts = map { rand } 1 .. rand 100;
	my $seq = Cv::Seq::Point->new(CV_64FC1, [@pts]);
	isa_ok($seq, 'Cv::Seq::Point');
	is_deeply([@$seq], [map { [$_] } @pts]);
}

if (11) {
	my @pts = map { [ map { rand } qw(x y) ] } 1 .. rand 100;
	e { Cv::Seq::Point->new(CV_64FC3, @pts) };
	err_is("can't init in Cv::Seq::Point::s_new");
}

if (12) {
	my @pts = map { [ map { rand } qw(x y) ] } 1 .. rand 100;
	e { Cv::Seq::Point->new(CV_64FC1, @pts) };
	err_is("can't init in Cv::Seq::Point::s_new");
}