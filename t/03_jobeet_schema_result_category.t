use strict;
use warnings;
use utf8;
use Test::More;

use Jobeet::Test;
use Jobeet::Models;
use DateTime;

binmode(Test::More->builder->$_, ':utf8') for qw/failure_output output todo_output/;

{
	my $new_cat = models('Schema::Category')->create({
		name => 'CamelCase',
	});

	is $new_cat->slug, 'camel_case', 'slug column: create slug column automatically.';

	$new_cat->name('UpdatedCategoryName');
	$new_cat->update;

	is $new_cat->slug, 'updated_category_name', 'slug column: update slug column automatically';
}

{
	my $job_rs = models('Schema::Job');

	my $design_cat = models('Schema::Category')->create({ name => 'Design' });

	my $design_job1 = $job_rs->create({
		type		=> 'full-time',
		category_id	=> $design_cat->id,
		company		=> "Company 1",
		position	=> 'Web designer',
		location	=> 'NY, America',
		description	=> 'Lorem ipsum',
		how_to_apply => "Send to lorem ipsum",
		is_public	=> 1,
		is_activated => 1,
		token		=> "job1",
		email		=> 'job@lorem.com',
	});

	my $design_job2 = $job_rs->create({
		type		=> 'full-time',
		category_id	=> $design_cat->id,
		company		=> "Company 2",
		position	=> 'Web designer',
		location	=> 'NY, America',
		description	=> 'Lorem ipsum',
		how_to_apply => "Send to lorem ipsum",
		is_public	=> 1,
		is_activated => 1,
		token		=> "job2",
		email		=> 'job@lorem.com',
	});
	my $design_job3 = $job_rs->create({
		 type		=> 'full-time',
		category_id	=> $design_cat->id,
		company		=> "Company 3",
		position	=> 'Web designer',
		location	=> 'NY, America',
		description	=> 'Lorem ipsum',
		how_to_apply => "Send to lorem ipsum",
		is_public	=> 1,
		is_activated => 1,
		token		=> "job3",
		email		=> 'job@lorem.com',
	});
	
	{
		is $design_cat->get_active_jobs->count, 3, 'get_active_jobs: regiter 3 jobs';
	}

	{
		my $yest = models('Schema')->now->subtract( days => 1 );
		$design_job2->update({ expires_at => $yest });

		is $design_cat->get_active_jobs->count, 2, 'get_active_jobs: $design_job2 has expired, so it is not being shown';
	}

	{
		my $now = models('Schema')->now;
		my $one_hour_ago = $now->clone->subtract( hours => 1 );
		my $tomorrow = $now->clone->add( days => 1 );

		$design_job1->update({ created_at => $now });
		$design_job3->update({ created_at => $one_hour_ago });

		{
			my $first_job = $design_cat->get_active_jobs->first;
			is $first_job->id, $design_job1->id, 'get_active_jobs: $design_job1 is made now, $design_job3 was made 1 hour ago, $design_cat->get_active_jobs->first is $design_job1';
		}

		$design_job3->update({ created_at => $tomorrow });
		{
			my $first_job = $design_cat->get_active_jobs->first;
			is $first_job->id, $design_job3->id;
		}
	}

	{
		is $design_cat->get_active_jobs->count, 2;
		is $design_cat->get_active_jobs({ rows => 1 })->count, 1;
	}
}
done_testing;