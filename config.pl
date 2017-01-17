my $home = Jobeet::Models->get('home');

return {
	default_view	=> 'MT',
	active_days		=> 30,
	max_jobs_on_hp	=> 10,
	max_jobs_on_category => 5,

	database => [
		'dbi:SQLite:' . $home->file('database.db'), '', '',
		{
			sqlite_unicode => 1,
		},
	],	
};