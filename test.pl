use strict;
use warnings;
use lib 'lib';

# use Jobeet::Schema;
use Jobeet::Models;
use DateTime;

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

print "category\n";
# my $cat = models('Schema::Category')->find({ name => 'Programming' });
# for my $job ($cat->get_active_jobs){
my @jobs = models('Schema::Job')->all;
for my $job (@jobs){
	# print $job->position,"\n";
	# print "$cat->position $cat->category->name\n";
	print $job->category_id . " " . $job->location . $job->position . $job->company . $job->expires_at . " " . $job->is_activated . "\n";
	print (($job->expires_at - models('Schema')->now )->delta_days());
}
# print $#jobs . "\n";
print models('Schema')->now . "\n";

# my $new_cat = models('Schema::Category')->create({
# 		name => 'CamelCase',
# 	});
# print $new_cat->slug . "\n";

1;