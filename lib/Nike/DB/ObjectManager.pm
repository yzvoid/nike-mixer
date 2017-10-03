package Nike::DB::ObjectManager;

use strict;
use warnings;
use feature 'say';

use TryCatch;

use Nike::DB::Schema qw();
use Nike::Exception::ObjectDoesNotExist;
use Nike::Exception::UnknownBetType;

our $VERSION = '0.01';

our $schema = Nike::DB::Schema->connect('NIKE_DB');

our @bet_types = ('sport', 'tournament');

sub get_sport_by_id {
    my ($class, $id_attr, $sport_id) = @_;
    
    return $class->_get_object_by_id('Sport', $id_attr, $sport_id);
}

sub get_betting_event_by_id {
    my ($class, $id_attr, $betting_event_id) = @_;
        
    return $class->_get_object_by_id('BettingEvent', $id_attr, $betting_event_id);
}

sub get_tournament_by_id {
    my ($class, $id_attr, $tournament_id) = @_;
    
    return $class->_get_object_by_id('Tournament', $id_attr, $tournament_id);
}

sub get_bet_by_id {
    my ($class, $id_attr, $bet_id) = @_;
    
    return $class->_get_object_by_id('Bet', $id_attr, $bet_id);
}

sub get_bets_by_type {
	my ($self, $type_ctx) = @_;
		
	my @bets;
		
	if ($type_ctx->{type} eq 'sport') {
	    my $rs = $schema->resultset('NikeBet')->search(
			{ 
				'sport.name' =>  $type_ctx->{value} 
			},
			{
				join => [qw/sport betting_event/]
			}
		);
								
		while (my $bet = $rs->next) {
			push @bets, $bet;
		}
								
		return \@bets;
				
	} else {
		Nike::Exception::UnknownBetType->throw(sprintf "Unknown bet type, expected one of [%s] got '%s'.", join(',', @bet_types), $type_ctx->{type});
	}
}

sub get_odds_by_bettting_event_id {
	my ($self, $betting_event_id) = @_;
				 
	 my @odds;
		 
	my $rs = $schema->resultset('NikeBettingEventOdd')->search(
		{ 
			'betting_event_id' => $betting_event_id
		},
		{
			join => [qw/odd/]
		}
	);
						
	while (my $betting_event_odd = $rs->next) {
		push @odds, $betting_event_odd->odd;
	}
		
	return \@odds;		 
}

sub _get_object_by_id {
    my ($class, $obj_class, $obj_id_attr, $obj_id_val) = @_;
    
    my $rs = $schema->resultset('Nike' . $obj_class)->search(
		{
			$obj_id_attr => $obj_id_val
		}
    );
    
    if (defined $rs->first) {
		return $rs->first;
	} else {
		Nike::Exception::ObjectDoesNotExist->throw(sprintf "'%s' object with %s = %d does not exist.", $obj_class, $obj_id_attr, $obj_id_val);
	}    
}

sub create_sport {
	my ($class, $sport) = @_;
		
	return $schema->resultset('NikeSport')->create({
		sport_id => $sport->{sport_id},
		name => $sport->{name}
	});		 				
}

sub create_odd {
	my ($class, $odd) = @_;
			
	return $schema->resultset('NikeOdd')->create({
		header => $odd->{header},
		odd => $odd->{odd},
		tip => $odd->{tip}
	});		 				
}

sub create_betting_event {
	my ($class, $betting_event_obj, $odds) = @_;
			
	my $betting_event =  $schema->resultset('NikeBettingEvent')->create({
		betting_event_id => $betting_event_obj->{betting_event_id},
		event_id => $betting_event_obj->{event_id},
		game_id => $betting_event_obj->{game_id},
		group_id => $betting_event_obj->{group_id},
		instance_id => $betting_event_obj->{instance_id},
		expanded => $betting_event_obj->{expanded},
			name => $betting_event_obj->{name},
			number => $betting_event_obj->{number},
		    popular_tip => $betting_event_obj->{popular_tip},
		    status => $betting_event_obj->{status}			
	});		 				
		
	foreach my $odd (@$odds) {			
		$schema->resultset('NikeBettingEventOdd')->create({
			betting_event_id => $betting_event->id,
			odd_id => $odd->id
		});		 				
	}

	return $betting_event;		
}

sub create_tournament {
	my ($class, $tournament) = @_;
						
	return $schema->resultset('NikeTournament')->create({
		tournament_id => $tournament->{tournament_id},
		name => $tournament->{name},
		season => $tournament->{season},
		top => $tournament->{top}
	});		 				
}

sub create_bet {
	my ($class, $bet_obj) = @_;
		
	my $sport = $bet_obj->{sport}->save();		
	my $betting_event = $bet_obj->{betting_event}->save();		
	my $tournament = $bet_obj->{tournament}->save();			
	my $bet = $schema->resultset('NikeBet')->create({
		bet_id => $bet_obj->{bet_id},
		live => $bet_obj->{live},
		sport_id => $sport->id,
		betting_event_id => $betting_event->id,
		tournament_id => $tournament->id,
		opponent_away => $bet_obj->{opponent_away},
		opponent_home => $bet_obj->{opponent_home},
		start => $bet_obj->{start},
		tournament_info => $bet_obj->{tournament_info}
	});		 			

	return $bet;				
}

sub update_bet {
	my ($class, $bet_id, $data) = @_;
		
    return $schema->resultset('NikeBet')->search(
		{
			'bet_id' => $bet_id
		}
	)->update_all($data);
}

1;

__END__

=head1 NAME

Nike::DB::ObjectManager - Database access and manipulation manager 

=head1 DESCRIPTION

Provides operations  to store and retrieve domain entities.

=cut
