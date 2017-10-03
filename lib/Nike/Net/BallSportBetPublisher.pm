package Nike::Net::BallSportBetPublisher;

use Moose;
use JSON::XS;
use feature 'say';

extends 'Nike::Net::BetPublisher';

our $VERSION = '0.01';

sub do_publish {
	my ($self, $chan) = @_;
		
	my %body = (
		type => 'sport',
		value => ['Hádzaná', 'Volejbal', 'Basketbal', 'Rugby', 'Americký futbal', 'Futbal', 'Futsal', 'Baseball']
	);
		
	$chan->publish(
		exchange => '',
		routing_key => 'bets',
		body => encode_json \%body,
	);
}

1;

__END__

=head1 NAME

Nike::Net::BallSportBetPublisher - Bet publisher for ball-like sports

=head1 DESCRIPTION

Publishes ball-like sports along the publishing channel.

=cut
