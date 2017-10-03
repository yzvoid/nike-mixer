use utf8;
package Nike::DB::Schema::Result::NikeTournament;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeTournament

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_tournament>

=cut

__PACKAGE__->table("nike_tournament");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_tournament_id_seq'

=head2 tournament_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 season

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 top

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nike_tournament_id_seq",
  },
  "tournament_id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "season",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "top",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nike_tournament_tournament_id_key>

=over 4

=item * L</tournament_id>

=back

=cut

__PACKAGE__->add_unique_constraint("nike_tournament_tournament_id_key", ["tournament_id"]);

=head1 RELATIONS

=head2 nike_bets

Type: has_many

Related object: L<Nike::DB::Schema::Result::NikeBet>

=cut

__PACKAGE__->has_many(
  "nike_bets",
  "Nike::DB::Schema::Result::NikeBet",
  { "foreign.tournament_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-30 19:27:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pkUVR1Y8siHTYIXQJnraUQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
