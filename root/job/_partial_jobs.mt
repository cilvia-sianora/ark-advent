? my @jobs = @_;
<table class="jobs">
? my $i = 0;
? for my $job (@jobs) {
	<tr class="<?= $i++ % 2 ? 'even' : 'odd' ?>">
		<td class="location">
			<?= $job->location ?>
		</td>
		<td class="position">
			<a href="<?= $c->uri_for('/job', $job->token) ?>">
				<?= $job->category_id ?><?= $job->position ?>
			</a>
		</td>
		<td class="company">
			<?= $job->company ?>
		</td>
	</tr>	
? }
</table>