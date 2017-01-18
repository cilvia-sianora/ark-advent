use strict;
use warnings;
use FindBin::libs;

use Jobeet::Models;
use DateTime;

my $job_rs = models('Schema::Job');
my $cat_rs = models('Schema::Category');

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



# my $design_category = models('Schema::Category')->find({ name => 'Design' });
# $design_category->add_to_jobs({
# 	type		=> 'full-time',
# 	company		=> 'Company',
# 	logo		=> 'extreme-sensio.gif',
# 	url			=> 'http://yey.com/',
# 	position	=> 'Web Designer',
# 	location	=> 'Tokyo, Japan',
# 	description	=> 'q[lalalalal lalalalal lalalala]',
# 	how_to_apply => 'Send your resume to lala@lala.com',
# 	is_public	=> 1,
# 	is_activated => 1,
# 	token		=> 'jobs_design2',
# 	email		=> 'yey@lala.com',
# 	expires_at	=> '2017-01-31',
# });

# {
# 	my $cat_prog = $cat_rs->find({ name => 'Programming' });
# 	my $job = $job_rs->create({
# 		type			=> 'full-time',
# 		category_id		=> $cat_prog->id,
# 		company			=> 'Sensio',
# 		position		=> 'Web Dev',
# 		location		=> 'Tokyo, Japan',
# 		description		=> 'waai waai waai',
# 		how_to_apply	=> 'Send your resume to lorem [at] waai.com',
# 		is_public		=> 1,
# 		is_activated	=> 1,
# 		token			=> 'job_expired',
# 		email			=> 'example@waai.com',
# 	});

# 	$job->update({
# 		created_at	=> '2017-01-01',
# 		expires_at	=> '2017-01-31',
# 	});
# }

# {
# 	my $cat_prog = $cat_rs->find({ name => 'Programming' });
# 	for my $i (100 .. 130) {
# 	    my $job = $job_rs->create({
# 	    	type 		=> 'full-time',
# 	        category_id  => $cat_prog->id,
# 	        company      => "Company $i",
# 	        position     => 'Web Developer',
# 	        location     => 'Paris, France',
# 	        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
# 	        how_to_apply => "Send your resume to lorem.ipsum [at] company_${i}.sit",
# 	        is_public    => 1,
# 	        is_activated => 1,
# 	        token        => "job_$i",
# 	        email        => 'job@example.com',
# 	    });
# 	}
# }

# Affiliate

{
	my $affiliate = models('Schema::Affiliate')->create({
		url	=> 'http:://www.sensio.com/',
		email => 'fabien@example.com',
		is_active => 1,
	});
	$affiliate->add_to_category_affiliate({
		category_id => models('Schema::Category')->find({ name => 'Programming' })->id,
	});
}

{
	my $affiliate = models('Schema::Affiliate')->create({
		url	=> 'http://www.symfony.org/',
		email => 'fabien2@example.com',
		is_active => 1,
	});
	$affiliate->add_to_category_affiliate({
		category_id => models('Schema::Category')->find({ name => 'Design' })->id,
	});
	$affiliate->add_to_category_affiliate({
		category_id => models('Schema::Category')->find({ name => 'Programming' })->id,
	});
}

1;