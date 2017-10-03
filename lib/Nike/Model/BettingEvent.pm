package Nike::Model::BettingEvent;

use strict;
use warnings;
use Carp;
use feature 'say';
binmode(STDOUT, ":encoding(utf8)");

use TryCatch;

use parent qw(Nike::Model::Persistable);
use Nike::Utils::ConvUtils;
use Nike::Model::Odd;
use Nike::DB::ObjectManager;
use Nike::Exception::ObjectDoesNotExist;

our $VERSION = '0.01';

sub new_from_resultset {
	my ($class, $betting_event_rs) = @_;
		
	Carp::croak(sprintf "new_from_resultset takes exactly two arguments, got %d", scalar(@_) - 1)
		unless @_ - 1 == 1;		
								
	my $odds = Nike::DB::ObjectManager->get_odds_by_bettting_event_id($betting_event_rs->id);
															
	my %data = (
		id => $betting_event_rs->betting_event_id,
		eventId => $betting_event_rs->event_id,
		gameId => $betting_event_rs->game_id,
		groupId => $betting_event_rs->group_id,
		instanceId => $betting_event_rs->instance_id,
		expanded => $betting_event_rs->expanded,
		name => $betting_event_rs->name,
		number => $betting_event_rs->number,
		odds => $odds,
		popularTip =>  $betting_event_rs->popular_tip,
		status => $betting_event_rs->status
	);
													
	return $class->new(\%data);
}


sub new {
	my ($class, $data) = @_ ;
		
	my $self  = bless { }, $class;
				
	$self->{betting_event_id} = %{$data}{id};		
	$self->{event_id} = %{$data}{eventId};		
	$self->{game_id} = %{$data}{gameId};		
	$self->{group_id} = %{$data}{groupId};		
	$self->{instance_id} = %{$data}{instanceId};		
	$self->{expanded} = Nike::Utils::ConvUtils->to_bool(%{$data}{expanded});		
	$self->{name} = %{$data}{name};		
	$self->{number} = %{$data}{number};		
		
	my @odds;
	my $odd_items = %{ $data }{'odds'};
	foreach my $odd_item (@$odd_items) {
		push @odds, ref($odd_item) eq 'Nike::DB::Schema::Result::NikeOdd' ? 
			Nike::Model::Odd->new_from_resultset($odd_item) : 
			Nike::Model::Odd->new($odd_item);
	}
				
	$self->{odds} = \@odds;
						
	$self->{popular_tip} = %{$data}{popularTip};
	$self->{status} = %{$data}{status};
			
	return $self;
}

sub save {
	my $self = shift;
		
	my @odds;
	foreach my $odd (@{  $self->{odds} }) {					
		push @odds, $odd->save();
	}		
		
	my $betting_event;		
	try {
		$betting_event = Nike::DB::ObjectManager->get_betting_event_by_id('betting_event_id', $self->{betting_event_id});
	} catch (Nike::Exception::ObjectDoesNotExist $e) {
	    $betting_event = Nike::DB::ObjectManager->create_betting_event($self, \@odds);				
	}		
				
	return $betting_event;
}

sub stringify {
	my $self = shift;
				
	my @odds;
	foreach my $odd (@{ $self->{odds} }) {
		push @odds, $odd->stringify;
	}
		
	return sprintf 'BettingEvent => {id = %d,  event_id = %d,  game_id = %d, group_id = %d, instance_id = %d, ' . 
		'expanded = %s, name = "%s", number = %d, odds => [%s], popular_tip = %d, status = "%s"}',  
		$self->{betting_event_id},  $self->{event_id}, $self->{game_id}, $self->{group_id}, $self->{instance_id}, 
		$self->{expanded}, $self->{name}, $self->{number}, join(', ', @odds), $self->{popular_tip}, $self->{status};		 							
}

sub to_xml_writer {
	my ($self, $writer) = @_;
				        
    $writer->startTag('BettingEvent', id => $self->{betting_event_id});       
       
    $writer->emptyTag('Event', id => $self->{event_id});
    $writer->emptyTag('Game', id => $self->{game_id});
    $writer->emptyTag('Group', id => $self->{group_id});
    $writer->emptyTag('Instance', id => $self->{instance_id});
    $writer->dataElement('Expanded', $self->{expanded});
    $writer->dataElement('Name', $self->{name});
    $writer->dataElement('Number', $self->{number});
       
    $writer->startTag('Odds');       
	foreach my $odd (@{ $self->{odds} }) {       
		$odd->to_xml_writer($writer);
	}
	$writer->endTag('Odds');       
		
    $writer->dataElement('PopularTip', $self->{popular_tip});
    $writer->dataElement('Status', $self->{status});
		
    $writer->endTag('BettingEvent');
}

1;

__END__

=head1 NAME

Nike::Model::BettingEvent - BettingEvent model representations

=head1 DESCRIPTION

Encapsulates BettingEvent domain entity.

=cut
