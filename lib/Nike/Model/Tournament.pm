package Nike::Model::Tournament;

use strict;
use warnings;
use Carp;
use feature 'say';
binmode(STDOUT, ":encoding(utf8)");

use TryCatch;

use parent qw(Nike::Model::Persistable);
use Nike::DB::ObjectManager;
use Nike::Exception::ObjectDoesNotExist;
use Nike::Utils::ConvUtils;

our $VERSION = '0.01';

sub new {
	my ($class, $data) = @_ ;
		
	my $self  = bless { }, $class;
			
	$self->{tournament_id} = %{$data}{id};		
	$self->{name} = %{$data}{name};		
	$self->{season} = %{$data}{season};
	$self->{top} = Nike::Utils::ConvUtils->to_bool(%{$data}{top});		
					
	return $self;
}

sub save {
	my $self = shift;
		
	my $tournament;		
	try {
		$tournament = Nike::DB::ObjectManager->get_tournament_by_id('tournament_id', $self->{tournament_id});
	} catch (Nike::Exception::ObjectDoesNotExist $e) {
	    $tournament = Nike::DB::ObjectManager->create_tournament($self);				
	}		
		
	return $tournament;
}

sub stringify {
	my $self = shift;
		
	return sprintf 'Tournament => {id = %d,  name = "%s",  season = %d, top = %s}',  
		$self->{tournament_id},  $self->{name}, $self->{season}, $self->{top};		 
}

sub to_xml_writer {
	my ($self, $writer) = @_;
				        
    $writer->startTag('Tournament', id => $self->{tournament_id});       
       		
    $writer->dataElement('Name', $self->{name});
    $writer->dataElement('Season', $self->{season});
    $writer->dataElement('Top', $self->{top});
		
    $writer->endTag('Tournament');
}

1;

__END__

=head1 NAME

Nike::Model::Tournament - Tournament model representations

=head1 DESCRIPTION

Encapsulates Tournament domain entity.

=cut
