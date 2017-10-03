package Nike::Model::Odd;

use strict;
use warnings;
use Carp;
use feature qw(say);
binmode(STDOUT, ":encoding(utf8)");

use parent qw(Nike::Model::Persistable);
use Nike::DB::ObjectManager;

our $VERSION = '0.01';

sub new_from_resultset {
	my ($class, $odd_rs) = @_;
		
	Carp::croak(sprintf "new_from_resultset takes exactly two arguments, got %d", scalar(@_) - 1)
		unless @_ - 1 == 1;		
																							
	my %data = (
		header => $odd_rs->header,
		odd => $odd_rs->odd,
		tip => $odd_rs->tip
	);
													
	return $class->new(\%data);
}


sub new {
	my ($class, $data) = @_ ;
		
	my $self  = bless { }, $class;
				
	$self->{header} = %{$data}{header};		
	$self->{odd} = %{$data}{odd};		
	$self->{tip} = %{$data}{tip};		
			
	return $self;
}

sub save {
	my $self = shift;
		
	return Nike::DB::ObjectManager->create_odd($self);				
}

sub stringify {
	my $self = shift;
		
	return sprintf 'Odd => {header = "%s",  odd = %d,  tip = "%s"}',  
		$self->{header},  $self->{odd}, $self->{tip};		 
}

sub to_xml_writer {
	my ($self, $writer) = @_;
				        
    $writer->startTag('Odd');       
       		
    $writer->dataElement('Header', $self->{header});
    $writer->dataElement('Odd', $self->{odd});
    $writer->dataElement('Tip', $self->{odd});
		
    $writer->endTag('Odd');
}

1;

__END__

=head1 NAME

Nike::Model::Odd - Odd model representations

=head1 DESCRIPTION

Encapsulates Odd domain entity.

=cut
