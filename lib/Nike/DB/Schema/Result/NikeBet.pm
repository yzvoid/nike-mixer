use utf8;
package Nike::DB::Schema::Result::NikeBet;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeBet

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_bet>

=cut

__PACKAGE__->table("nike_bet");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_bet_id_seq'

=head2 bet_id

  data_type: 'integer'
  is_nullable: 0

=head2 live

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 sport_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 betting_event_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tournament_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 opponent_away

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 opponent_home

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 start

  data_type: 'timestamp'
  is_nullable: 0

=head2 tournament_info

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nike_bet_id_seq",
  },
  "bet_id",
  { data_type => "integer", is_nullable => 0 },
  "live",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
  "sport_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "betting_event_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tournament_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "opponent_away",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "opponent_home",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "start",
  { data_type => "timestamp", is_nullable => 0 },
  "tournament_info",
  { data_type => "varchar", is_nullable => 1, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nike_bet_bet_id_key>

=over 4

=item * L</bet_id>

=back

=cut

__PACKAGE__->add_unique_constraint("nike_bet_bet_id_key", ["bet_id"]);

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

=head2 sport

Type: belongs_to

Related object: L<Nike::DB::Schema::Result::NikeSport>

=cut

__PACKAGE__->belongs_to(
  "sport",
  "Nike::DB::Schema::Result::NikeSport",
  { id => "sport_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tournament

Type: belongs_to

Related object: L<Nike::DB::Schema::Result::NikeTournament>

=cut

__PACKAGE__->belongs_to(
  "tournament",
  "Nike::DB::Schema::Result::NikeTournament",
  { id => "tournament_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-10-02 21:43:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/D66i5ZPkpFnCHUKgVDZJw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
