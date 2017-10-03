use utf8;
package Nike::DB::Schema::Result::NikeBettingEvent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeBettingEvent

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_betting_event>

=cut

__PACKAGE__->table("nike_betting_event");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_betting_event_id_seq'

=head2 betting_event_id

  data_type: 'integer'
  is_nullable: 0

=head2 event_id

  data_type: 'integer'
  is_nullable: 0

=head2 game_id

  data_type: 'integer'
  is_nullable: 0

=head2 group_id

  data_type: 'integer'
  is_nullable: 0

=head2 instance_id

  data_type: 'integer'
  is_nullable: 0

=head2 expanded

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 number

  data_type: 'integer'
  is_nullable: 1

=head2 popular_tip

  data_type: 'integer'
  is_nullable: 1

=head2 status

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nike_betting_event_id_seq",
  },
  "betting_event_id",
  { data_type => "integer", is_nullable => 0 },
  "event_id",
  { data_type => "integer", is_nullable => 0 },
  "game_id",
  { data_type => "integer", is_nullable => 0 },
  "group_id",
  { data_type => "integer", is_nullable => 0 },
  "instance_id",
  { data_type => "integer", is_nullable => 0 },
  "expanded",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "number",
  { data_type => "integer", is_nullable => 1 },
  "popular_tip",
  { data_type => "integer", is_nullable => 1 },
  "status",
  { data_type => "varchar", is_nullable => 0, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nike_betting_event_betting_event_id_key>

=over 4

=item * L</betting_event_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "nike_betting_event_betting_event_id_key",
  ["betting_event_id"],
);

=head1 RELATIONS

=head2 nike_bets

Type: has_many

Related object: L<Nike::DB::Schema::Result::NikeBet>

=cut

__PACKAGE__->has_many(
  "nike_bets",
  "Nike::DB::Schema::Result::NikeBet",
  { "foreign.betting_event_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nike_betting_event_odds

Type: has_many

Related object: L<Nike::DB::Schema::Result::NikeBettingEventOdd>

=cut

__PACKAGE__->has_many(
  "nike_betting_event_odds",
  "Nike::DB::Schema::Result::NikeBettingEventOdd",
  { "foreign.betting_event_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-30 19:08:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jvbkvaWzfLd49FhK/gSb8A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
