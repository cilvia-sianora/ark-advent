<?= raw_string qq[<\?xml version="1.0" encoding="utf-8"?\>] ?>
<feed xmlns="http://www.w3.org/2005/Atom">
? my $w3c = $c->stash->{w3c_date};
? my $latest_post = $c->stash->{latest_post}; 
	<title>Jobeet</title>
	<subtitle>Latest Job</subtitle>
	<link href="<?= $c->uri_for('/job/atom') ?>" rel="self" />
	<link href="<?= $c->uri_for('/job') ?>" />
	<updated><?= $w3c->format_datetime($latest_post->created_at) ?></updated>
	<author><name>Jobeet</name></author>
	<id><?= sha1_hex($c->uri_for('/job/atom')) ?></id>

? my $max_rows = Jobeet::Models->get('conf')->{max_jobs_on_hp};
? for my $cat ($c->stash->{categories}->all) {
?	for my $job ($cat->get_active_jobs({ rows => $max_rows })->all){
	<entry>
		<title><?= $job->position ?> (<?= $job->location ?>)</title>
		<link href="" />
		<id><?= sha1_hex($job->id) ?></id>
		<updated><?= $w3c->format_datetime($job->created_at) ?></updated>
		<summary type="xhtml">
			<div><?= $job->description ?></div>
			<h4>How to apply?</h4>
			<p><?= $job->how_to_apply ?></p>
		</summary>
		<author>
			<name><?= $job->company ?></name>
		</author>
	</entry>
?	}
? }
</feed>