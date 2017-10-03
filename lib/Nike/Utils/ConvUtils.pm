package Nike::Utils::ConvUtils;

use strict;
use warnings;
use Carp;
use feature 'say';
use DateTime::Format::Strptime;
use Attribute::Boolean;

our $VERSION = '0.01';

sub to_date {
    my ($class, $pattern, $value) = @_;
                
    my $parser = DateTime::Format::Strptime->new(
        pattern => $pattern,
        on_error => 'croak',
    );

    return $parser->parse_datetime($value);	
}

sub to_bool {
    my ($class, $key, $value) = @_;	
    
    Carp::croak(sprintf "expect 0 or 1 got %s", $value)
        unless $value == 0 || $value == 1;				
        
    my $bool_value : Boolean;
    $bool_value = $value;
    
    return $bool_value;
}

1;

__END__

=head1 NAME

Nike::Utils::ConvUtils - Conversion utility package

=head1 DESCRIPTION

Defines miscillaneous conversion methods.

=cut
