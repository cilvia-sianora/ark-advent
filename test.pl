use strict;
use warnings;
use lib 'lib';

use Jobeet::Schema;
use Jobeet::Models;

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
my @temp = models('Schema::Category')->all;
for my $obj (@temp){
	# print $job->position,"\n";
	print $obj->name,"\n";
}