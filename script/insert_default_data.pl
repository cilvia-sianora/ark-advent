

use strict;
use warnings;
use FindBin::libs;

use Jobeet::Models;

for my $category_name (qw/Design Programming Manager Administrator/){
	models('Schema::Category')->create({ name => $category_name });
}

my $programming_category = models('Schema::Category')->find({ name => 'Programming' });
$programming_category->add_to_jobs({
	type		=> 'full-time',
	company		=> 'Sensio Labs',
	logo		=> 'sensio-labs.gif',
	url			=> 'http://www.sensiolabs.com/',
	position	=> 'Web Developer',
	location	=> 'Paris, France',
	description	=> q[You've already developed websites blabla],
	how_to_apply =>	'Send your resume to blabla@yey.com',
	is_public	=> 1,
	is_activated => 1,
	token		=> 'job_sensio_labs',
	email		=> 'yatta@yey.com',
	expires_at	=> '2017-01-13',
});

my $design_category = models('Schema::Category')->find({ name => 'Design' });
$design_category->add_to_jobs({
	type		=> 'part-time',
	company		=> 'Yey',
	logo		=> 'extreme-sensio.gif',
	url			=> 'http://yey.com/',
	position	=> 'Web Designer',
	location	=> 'Paris, France',
	description	=> 'q[lalalalal lalalalal lalalala]',
	how_to_apply => 'Send your resume to lala@lala.com',
	is_public	=> 1,
	is_activated => 1,
	token		=> 'jobs_extreme_sensio',
	email		=> 'yey@lala.com',
	expires_at	=> '2017-01-14',
});
