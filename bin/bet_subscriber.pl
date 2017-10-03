#!/usr/bin/env perl

#
# Niké bet subscriber orchestration script
#

use strict;
use warnings;
use feature 'say';

use AnyEvent;
use Net::RabbitFoot;
use JSON::XS;

use TryCatch;

use Path::Tiny qw(path);
use lib path($0)->absolute->sibling('../lib')->stringify;

use Nike::DB::ObjectManager;
use Nike::Exception::UnknownBetType;
use Nike::Model::Bet;

my $conn = Net::RabbitFoot->new()->load_xml_spec()->connect(
    host => 'localhost',
    port => 5672,
    user => 'guest',
    pass => 'guest',
    vhost => '/',
);

my $chan = $conn->open_channel();

$chan->declare_queue(queue => 'bets');

say 'Waiting for published bets. To exit press CTRL-C';

sub callback {
    my $msg = shift;        
    
    try {    
        my $bets = Nike::DB::ObjectManager->get_bets_by_type(decode_json $msg->{body}->{payload});    
        foreach my $bet_rs (@$bets) {
            my $bet = Nike::Model::Bet->new_from_resultset($bet_rs);
            say $bet->to_xml();
        }
    } catch (Nike::Exception::UnknownBetType $e) {
        say 'Failed to get bets, reason: ' . $e;
    }
}

$chan->consume(
    on_consume => \&callback,
    no_ack => 1,
);

# Wait forever
AnyEvent->condvar->recv;