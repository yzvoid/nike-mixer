package Nike::Model::Persistable;

use strict;
use warnings;
use feature 'say';
use Attribute::Abstract;
use XML::Writer;

use overload 
    '""' => 'stringify';
    
our $VERSION = '0.01';
        
sub new {
	my $class = shift;
	my $self  = bless { @_ }, $class;

	return $self;
}

sub save: Abstract;

sub stringify: Abstract;

sub to_xml {
	my $self = shift;

	my $writer = new XML::Writer(OUTPUT => 'self', DATA_MODE => 1, DATA_INDENT => 2);
	$writer->xmlDecl('UTF-8');
		
	return $self->to_xml_writer($writer);
}

sub to_xml_writer: Abstract;

1;

__END__

=head1 NAME

Nike::Model::Persistable - Base class for model representations

=head1 DESCRIPTION

Defines interface for model classes.

=cut
