package Nike::API::BetMixer;

use strict;
use warnings;
use Carp;
use feature 'say';

use HTTP::Headers;
use HTTP::Request;
use LWP::UserAgent;
use Config::Any;

use Nike::API::JSONBetParser;

our $VERSION = '0.01';

sub new {
	my $class = shift;
		
	Carp::croak("missing mandatory argument 'lang'")
		unless grep(/^lang/, @_);
		
	my $self  = bless { @_ }, $class;
	$self->{parser} = new Nike::API::JSONBetParser();
	# be nice and introduce yourself by book
    $self->{headers} = new HTTP::Headers(
		'User-Agent' => 'Dalvik/2.1.0 (Linux; U; Android 5.1.1; Nexus 4 Build/LMY48T)'
	);
		
	my $nike_ini_file = q{./etc/nike_api.ini};
	my @files = ($nike_ini_file);
	my $cfg = Config::Any->load_files({files => \@files, use_ext => 1});		
	$self->{mixer_url} = $cfg->[0]{$nike_ini_file}{mixer_url};
	     
	return $self;
}

sub mix {
	my $self = shift;
					
	my $request = new HTTP::Request(
		"GET",
		sprintf($self->{mixer_url}, $self->{lang}),
		$self->{headers}
	);
    
	my $ua = new LWP::UserAgent;
	my $response = $ua->request($request);
	if ($response->is_success) {
		$self->{parser}->parse($response->decoded_content);
	} else {
	    Carp::croak($response->status_line);
	}         
}

1;

__END__

=head1 NAME

Nike::API::BetMixer - Niké smart mobile API client

=head1 DESCRIPTION

The mixer connects to Niké smart mobile endpoint, retreives mixed bet payload and passes it along to a parser supplied in its constructor.

=cut
