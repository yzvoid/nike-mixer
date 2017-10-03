package Nike::Exception::UnknownBetType;

use strict;
use warnings;

use Moose;
extends 'Throwable::Error';

our $VERSION = '0.01';

has execution_phase => (
	is  => 'ro',  
    default => 'startup',
);

1;

__END__

=head1 NAME

Nike::Exception::UnknownBetType - UnknownBetType exception

=head1 DESCRIPTION

Gets thrown when a bet type was not recognized.

=cut
