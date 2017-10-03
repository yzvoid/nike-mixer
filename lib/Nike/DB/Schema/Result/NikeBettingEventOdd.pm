use utf8;
package Nike::DB::Schema::Result::NikeBettingEventOdd;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeBettingEventOdd

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_betting_event_odd>

=cut

__PACKAGE__->table("nike_betting_event_odd");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_betting_event_odd_id_seq'

=head2 betting_event_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 odd_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nike_betting_event_odd_id_seq",
  },
  "betting_event_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "odd_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 betting_event

Type: belongs_to

Related object: L<Nike::DB::Schema::Result::NikeBettingEvent>

=cut

__PACKAGE__->belongs_to(
  "betting_event",
  "Nike::DB::Schema::Result::NikeBettingEvent",
  { id => "betting_event_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 odd

Type: belongs_to

Related object: L<Nike::DB::Schema::Result::NikeOdd>

=cut

__PACKAGE__->belongs_to(
  "odd",
  "Nike::DB::Schema::Result::NikeOdd",
  { id => "odd_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-30 19:08:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MCwHvW6p5D4Q9aLRqZIfFw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
