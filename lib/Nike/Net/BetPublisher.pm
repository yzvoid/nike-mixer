package Nike::Net::BetPublisher;

use Moose;
use Attribute::Abstract;
use Net::RabbitFoot;

our $VERSION = '0.01';

has 'mq_conn' => (
	is        => 'ro',
    builder   => '_build_mq_conn',
    predicate => 'has_mq_conn',
);
 
sub _build_mq_conn {
	# TODO (pd): move to a config file
	return Net::RabbitFoot->new()->load_xml_spec()->connect(
		host => 'localhost',
		port => 5672,
		user => 'guest',
		pass => 'guest',
		vhost => '/',
	);
}		  

sub publish {
	my $self = shift;
      
    $self->do_publish($self->mq_conn->open_channel());
}

sub done {
	my $self = shift;
      
    $self->mq_conn->close();
}


sub do_publish: Abstract;

1;

__END__

=head1 NAME

Nike::Net::BetPublisher - Bet publisher interface

=head1 DESCRIPTION

Defines operations a publisher implementation must provide.

=cut
