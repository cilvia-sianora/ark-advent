use strict;
use warnings;
use lib 'lib';

use Jobeet::Schema;

my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

my $category_rs = $schema->resultset('Category');
print $category_rs->count;

# my $category = $category_rs->create({
# 	name => 'new category',
# });
# print $category_rs->count;

# my $new_rs = $category_rs->search({ name => 'new category' });

# my @categories = $category_rs->all;
# print @categories;

while (my $category = $category_rs->next) {
	print $category->name;
	$category->update({ name => 'new name' });
	print $category->name;
	$category->delete;
}
print $category_rs->count;