#!/usr/bin/env perl

#
# Niké bet mixer orchestration script
#

use strict;
use warnings;
use feature 'say';

use Path::Tiny qw(path);
use lib path($0)->absolute->sibling('../lib')->stringify;

use Nike::API::BetMixer;

my $bet_mixer = new Nike::API::BetMixer(lang => 'sk');

say 'about to mix bets...';

foreach  my $bet (@{ $bet_mixer->mix() }) {	
	$bet->save();
	say $bet;
}

say 'done';