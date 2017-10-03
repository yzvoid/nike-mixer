#!/usr/bin/env perl

#
# Niké bet publisher orchestration script
#

use strict;
use warnings;
use feature 'say';

use Path::Tiny qw(path);
use lib path($0)->absolute->sibling('../lib')->stringify;

use Nike::Net::BallSportBetPublisher;

say 'about to publish ball sport bets...';

my $bet_publisher = Nike::Net::BallSportBetPublisher->new();
$bet_publisher->publish();
$bet_publisher->done();

say 'done';