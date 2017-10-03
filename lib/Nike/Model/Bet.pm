package Nike::Model::Bet;

use strict;
use warnings;
use Carp;
use feature 'say';
binmode(STDOUT, ":encoding(utf8)");
  
use TryCatch;

use parent qw(Nike::Model::Persistable);
use Nike::Model::BettingEvent;
use Nike::Model::Sport;
use Nike::Model::Tournament;
use Nike::DB::ObjectManager;
use Nike::Exception::ObjectDoesNotExist;

use Nike::Utils::ConvUtils;

our $VERSION = '0.01';

sub new_from_resultset {
	my ($class, $bet_rs) = @_;
		
	Carp::croak(sprintf "new_from_resultset takes exactly two arguments, got %d", scalar(@_) - 1)
		unless @_ - 1 == 1;		
								
	my $sport = Nike::DB::ObjectManager->get_sport_by_id('id', $bet_rs->sport_id);
																						
	my %data = (
		id => $bet_rs->id,
		live => $bet_rs->live,
		mainBettingEvent =>  $bet_rs->betting_event,
			opponents => {
				away => $bet_rs->opponent_away,
				home => $bet_rs->opponent_home
			},
        sportId => $sport->sport_id,
        sportName => $sport->name,                                
        start => Nike::Utils::ConvUtils->to_date('%Y-%d-%m %H:%M:%S', $bet_rs->start),                
        tournament => {
			id => $bet_rs->tournament->tournament_id,
			name => $bet_rs->tournament->name,
			season => $bet_rs->tournament->season,
			top => $bet_rs->tournament->top
		},
        tournamentInfo => $bet_rs->tournament_info  										
	);
															
	return $class->new(\%data);
}

sub new {
	my ($class, $data) = @_ ;
		
	my $self  = bless { }, $class;
				
	$self->{bet_id} = %{$data}{id};
				
	$self->{live} = Nike::Utils::ConvUtils->to_bool(%{$data}{live});		
								
	my $betting_event = %{$data}{mainBettingEvent};
				
	$self->{betting_event} = ref($betting_event) eq 'Nike::DB::Schema::Result::NikeBettingEvent' ? 
		Nike::Model::BettingEvent->new_from_resultset($betting_event) : 
		Nike::Model::BettingEvent->new($betting_event);
								
	my $opponents = %{$data}{opponents};
		
	$self->{opponent_away} = %{$opponents}{away};
	$self->{opponent_home} = %{$opponents}{home};
				
	$self->{sport} = Nike::Model::Sport->new($data);
		
	my $start =	%{$data}{start};						
	$self->{start} = ref($start) eq 'DateTime' ? $start : Nike::Utils::ConvUtils->to_date('%d.%m.%Y %H:%M', $start);		
		
	my $tournament = %{$data}{tournament};
	$self->{tournament} = Nike::Model::Tournament->new($tournament);		
		
	$self->{tournament_info} = %{$data}{tournamentInfo};
		
	return $self;
}

sub save {
	my $self = shift;
				
	my $bet;		
		
	try {
		$bet = Nike::DB::ObjectManager->get_bet_by_id('bet_id', $self->{bet_id});
		Nike::DB::ObjectManager->update_bet($self->{bet_id},
		    {
				live => $self->{live}	
			}	
		);
	} catch (Nike::Exception::ObjectDoesNotExist $e) {
	    $bet = Nike::DB::ObjectManager->create_bet($self);				
	}		
		
	return $bet;
}

sub stringify {
	my $self = shift;
		
	return sprintf 'Bet => {bet_id = %d,  live = %s,  betting_event = %s, opponent_away = "%s", opponent_home = "%s", sport = "%s"}',  
		$self->{bet_id},  $self->{live}, $self->{betting_event}, $self->{opponent_away}, $self->{opponent_home}, $self->{sport};		 
}

sub to_xml_writer {
	my ($self, $writer) = @_;
				        
    $writer->startTag('Bet', id => $self->{bet_id});   
           
    $writer->dataElement('Live', $self->{live});
    $self->{betting_event}->to_xml_writer($writer);
       
    $writer->dataElement('Opponent',  $self->{opponent_away}, location => 'away');
    $writer->dataElement('Opponent',  $self->{opponent_home}, location => 'home');
       
    $self->{sport}->to_xml_writer($writer);
       
    $writer->dataElement('Start',  $self->{start}->strftime('%d.%m.%Y %H:%M'));
       
    $self->{tournament}->to_xml_writer($writer);
       
    $writer->dataElement('TournamentInfo',  $self->{tournament_info});
       
    $writer->endTag('Bet');
       
    return $writer->end();
}

1;

__END__

=head1 NAME

Nike::Model::Bet - Bet model representations

=head1 DESCRIPTION

Encapsulates Bet domain entity.

=cut
