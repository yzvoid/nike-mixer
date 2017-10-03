package Nike::API::BetParser;

use strict;
use warnings;

use Attribute::Abstract;

our $VERSION = '0.01';

sub new {
	my $class = shift;
	my $self  = bless { @_ }, $class;

	return $self;
}

sub parse: Abstract;

1;

__END__

=head1 NAME

Nike::API::BetParser - Base class for parser like classes

=head1 DESCRIPTION

Defines interface that parser implementations must conform to.

=cut
