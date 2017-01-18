use strict;
use warnings;
use lib 'lib';

use Jobeet::Schema;
use Jobeet::Models;
# use DateTime;
use JSON;
use Jobeet::Test;
# use Test::More;

# use String::CamelCase;

# my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

# my $category_rs = $schema->resultset('Category');
# print $category_rs->count;

# my $category = $category_rs->create({
# 	name => 'new category',
# });
# print $category_rs->count;

# my $new_rs = $category_rs->search({ name => 'new category' });

# my @categories = $category_rs->all;
# print @categories;

# while (my $category = $category_rs->next) {
# 	print $category->name;
# 	$category->update({ name => 'new name' });
# 	print $category->name;
# 	$category->delete;
# }
# print $category_rs->count;

## DBIx ##

# for my $category_name (qw/category1 category2/) {
#     models('Schema::Category')->create({ name => $category_name });
# }

# print "category\n";
# my $cat = models('Schema::Category')->find({ name => 'Programming' });
# for my $job ($cat->get_active_jobs){
# my @jobs = models('Schema::Job')->all;
# for my $job (@jobs){
# 	print $job->position,"\n";
	# print "$cat->position $cat->category->name\n";
# 	print $job->category_id . " " . $job->location . $job->position . $job->company . $job->expires_at . " " . $job->is_activated . "\n";
# 	print (($job->expires_at - models('Schema')->now )->delta_days());
# }
# print $#jobs . "\n";
# print models('Schema')->now . "\n";

# my $new_cat = models('Schema::Category')->create({
# 		name => 'CamelCase',
# 	});
# print $new_cat->slug . "\n";

# my @a = qw(1 2 3 4 5 4);
# my $ref = \@a;
# print @$ref, "\n";

# my $x = 4;

# my @del_index = grep { $ref->[$_] == $x } 0..scalar(@$ref)-1;
# print @del_index, "\n";
# splice(@$ref, @del_index);

# my $i = 0;
# $i++ until $ref->[$i] == $x;
# splice(@$ref, $i, 1);

# print @$ref, "\n";
# unshift @$ref, $x;

# print @$ref, "\n";

# @a = qq[<\?xml version="1.0" encoding="utf-8"?\>];
# print @a, "\n";
# @a = qw[<\?xml version="1.0" encoding="utf-8"?\>];
# print @a, "\n";

# print models('home')->subdir(qw/sql fixtures/)->file('default.pl');

print "Hello","\n";
my @affs = models('Schema::Affiliate')->all;
for my $aff (@affs) {
	print $aff->id, "\n";
}

# {
# 	my $res = request( GET => '/api/foo/jobs' );
# 	print $res->code, "\n";
# }

	my $data = models('Schema::Affiliate')->single({});
	# print $data->token, "\n";
	my $token = qw/0a0d4dc70dfa1df5cda3b355a4f1789ad5538d97/;
	my $res = request( GET => '/api/0a0d4dc70dfa1df5cda3b355a4f1789ad5538d97/jobs' );
	print $res->code, "\n";
