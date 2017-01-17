use strict;
use warnings;
use Test::More;

use Jobeet::Test;
use Jobeet::Models;

{
	my $new_cat = models('Schema::Category')->create({ name => 'Programming' });
	my $new_job = $new_cat->add_to_jobs({
		type	=> 'full-time',
		company	=> 'Sensio Labs',
		logo	=> 'sensio-labs.gif',
		url		=> 'http://www.sensio.com',
		position => 'Web Dev',
		location => 'Spain',
		description	=> q[Hello World!],
		how_to_apply => 'Send you resume to spain [at] sensio.com',
		is_public => 1,
		is_activated => 1,
		token	=> 'job_sensio',
		email	=> 'job@sensio.com',
	});

	isa_ok $new_job, 'Jobeet::Schema::Result::Job';

	isa_ok $new_job->created_at, 'DateTime';
	isa_ok $new_job->updated_at, 'DateTime';
	isa_ok $new_job->expires_at, 'DateTime';
}

done_testing;