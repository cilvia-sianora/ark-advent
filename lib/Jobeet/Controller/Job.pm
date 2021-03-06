package Jobeet::Controller::Job;
use Ark 'Controller';
with 'Ark::ActionClass::Form';

use DateTime::Format::W3CDTF;

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;
}

sub insert {
	my $self = shift;

	$self->expires_at( models('Schema')->now->add( days => models('conf')->{acitive_days} ) );
	$self->next::method(@_);

}

# job/{job_token} (details)
sub show :Path :Args(1) {
	my ($self, $c, $job_token) = @_;

	$c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
		or $c->detach('/default');

	my $history = $c->session->get('job_history') || [];

	my $i = 0;
	while ( $i < scalar(@$history) ){
		if ($history->[$i]->{token} eq $job_token) {
			splice(@$history, $i, 1);
			last;		
		}
		$i++;
	}

	unshift @$history, { $c->stash->{job}->get_columns };

	$c->session->set( job_history => $history );
}

# job/create (post new job)
sub create :Local :Form('Jobeet::Form::Job') {
	my ($self, $c) = @_;

	if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
		my $job = models('Schema::Job')->create_from_form($self->form);
		$c->redirect( $c->uri_for('/job', $job->token) );
	}
}

sub job :Chained('/') :PathPart :CaptureArgs(1) {
	my ($self, $c, $job_token) = @_;
	
	# $c->stash->{job_token} = $job_token;
	$c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
		or $c->detach('/default');
}

# job/{job_token}/edit (edit)
sub edit :Chained('job') :PathPart :Form('Jobeet::Form::Job') {
	my ($self, $c) = @_;

	my $job = $c->stash->{job};

	if ($c->req->method eq 'POST'){
		if ($self->form->submitted_and_validvalid) {
			$job->update_from_form($self->form);
			$c->redirect( $c->uri_for('/job', $job->token) );
		}
	} else {
		$self->form->fill([
			$job->get_columns,
			category => $job->category->slug,
		]);
	}
}

# job/{job_token}/delete (delete)
sub delete :Chained('job') :PathPart {
	my ($self, $c) = @_;

	$c->stash->{job}->delete;
	$c->redirect( $c->uri_for('/job') );
}

sub publish :Chained('job') :PathPart {
	my ($self, $c) = @_;

	my $job = $c->stash->{job};

	$job->publish;
	$c->redirect( $c->uri_for('/job', $job->token) );
}

# fee
sub atom :Local {
	my ($self, $c) = @_;
	$c->res->content_type('application/atom+xml; charset=utf-8');
	# $c->res->content_type('application/xml');

	$c->stash->{w3c_date} = DateTime::Format::W3CDTF->new;
    $c->stash->{latest_post} = models('Schema::Job')->latest_post;

    $c->forward('index');
}

1;
