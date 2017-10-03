use utf8;
package Nike::DB::Schema::Result::NikeOdd;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeOdd

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_odd>

=cut

__PACKAGE__->table("nike_odd");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_odd_id_seq'

=head2 header

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=head2 odd

  data_type: 'real'
  is_nullable: 0

=head2 tip

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nike_odd_id_seq",
  },
  "header",
  { data_type => "varchar", is_nullable => 0, size => 8 },
  "odd",
  { data_type => "real", is_nullable => 0 },
  "tip",
  { data_type => "varchar", is_nullable => 0, size => 8 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 nike_betting_event_odds

Type: has_many

Related object: L<Nike::DB::Schema::Result::NikeBettingEventOdd>

=cut

__PACKAGE__->has_many(
  "nike_betting_event_odds",
  "Nike::DB::Schema::Result::NikeBettingEventOdd",
  { "foreign.odd_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-30 19:08:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TWRgK7rTg0RabPB5M53w6A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
