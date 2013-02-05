# -*- mode: perl; coding: utf-8; tab-width: 4 -*-

use strict;
use warnings;
# use Test::More qw(no_plan);
use Test::More tests => 2;
use File::Basename;
use lib dirname($0);
use MY;
BEGIN { use_ok('Cv', -more) }

my $mat = Cv::Mat->new([240, 320], CV_8UC1);
# my $img = $mat->Cv::Image::new;
my $img = e { $mat->Cv::Image::new };
err_is('');