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

	{
		isa_ok models('Schema::Category')->get_with_jobs, 'Jobeet::Schema::ResultSet::Category', 'get_with_jobs: returning "Jobeet::Schema::ResultSet::Category" object';
	}

	{
		my $first_job = models('Schema::Category')->get_with_jobs->first;
		is $first_job->id, $new_job->id, 'get_with_jobs: got $new_job';
	}

	{
		my $yest = models('Schema')->now->subtract( days => 1 );
		# new job expires
		$new_job->update({ expires_at => $yest });
		is models('Schema::Category')->get_with_jobs->count, 0, 'get_with_jobs: expired job is not appeared';
	}

}

done_testing;