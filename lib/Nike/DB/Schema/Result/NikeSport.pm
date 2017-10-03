use utf8;
package Nike::DB::Schema::Result::NikeSport;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Nike::DB::Schema::Result::NikeSport

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<nike_sport>

=cut

__PACKAGE__->table("nike_sport");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nike_sport_id_seq'

=head2 sport_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

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
    sequence          => "nike_sport_id_seq",
  },
  "sport_id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nike_sport_sport_id_key>

=over 4

=item * L</sport_id>

=back

=cut

__PACKAGE__->add_unique_constraint("nike_sport_sport_id_key", ["sport_id"]);

=head1 RELATIONS

=head2 nike_bets

Type: has_many

Related object: L<Nike::DB::Schema::Result::NikeBet>

=cut

__PACKAGE__->has_many(
  "nike_bets",
  "Nike::DB::Schema::Result::NikeBet",
  { "foreign.sport_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-30 14:52:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HorY8e7DN+ly3H/e6JmzZA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
