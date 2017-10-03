package Nike::Exception::ObjectDoesNotExist;

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

Nike::Exception::ObjectDoesNotExist - ObjectDoesNotExist exception

=head1 DESCRIPTION

Gets thrown when requested object does not exist in database.

=cut
