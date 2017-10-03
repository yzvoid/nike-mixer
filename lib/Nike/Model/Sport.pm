package Nike::Model::Sport;

use strict;
use warnings;
use Carp;
use feature qw(say);
binmode(STDOUT, ":encoding(utf8)");

use TryCatch;

use parent qw(Nike::Model::Persistable);
use Nike::DB::ObjectManager;
use Nike::Exception::ObjectDoesNotExist;

our $VERSION = '0.01';

sub new {
	my ($class, $data) = @_ ;
		
	my $self  = bless { }, $class;
				
	$self->{sport_id} = %{$data}{sportId};		
	$self->{name} = %{$data}{sportName};		
			
	return $self;
}

sub save {
	my $self = shift;
		
	my $sport;		
	try {
		$sport = Nike::DB::ObjectManager->get_sport_by_id('sport_id', $self->{sport_id});
	} catch (Nike::Exception::ObjectDoesNotExist $e) {
	    $sport = Nike::DB::ObjectManager->create_sport($self);				
	}		
		
	return $sport;
}

sub stringify {
	my $self = shift;
		
	return sprintf 'Sport => {sport_id = %d,  name = "%s"}',  
		$self->{sport_id},  $self->{name};		 
}

sub to_xml_writer {
	my ($self, $writer) = @_;
			        
    $writer->startTag('Sport', id => $self->{sport_id});       
       		
    $writer->dataElement('Name', $self->{name});
		
    $writer->endTag('Sport');
}

1;

__END__

=head1 NAME

Nike::Model::Sport - Sport model representations

=head1 DESCRIPTION

Encapsulates Sport domain entity.

=cut
