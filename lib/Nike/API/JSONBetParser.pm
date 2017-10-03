package Nike::API::JSONBetParser;

use strict;
use warnings;
use feature 'say';
use JSON::XS;

use parent qw(Nike::API::BetParser);
use Nike::Model::Bet;

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $self  = bless { @_ }, $class;

	return $self;
}

sub parse {
	my ($self, $content) = @_;

	my $json_content = decode_json $content;
	my $bet_items = %{ $json_content }{'bets'};
	my @bets;
	foreach my $bet_item (@$bet_items) {							     
		push @bets, Nike::Model::Bet->new($bet_item);				
	}
		
	return \@bets;
}

1;

__END__

=head1 NAME

Nike::API::JSONBetParser - JSON bet parser implementation

=head1 DESCRIPTION

The parser decodes payload received from Niké server and constructs bet model objects.

=cut
