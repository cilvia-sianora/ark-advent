? my $form = $c->stash->{form};

? extends 'common/jobs_base';

? block content => sub {

<h1>New Job</h1>

?= include('job/_partial_form', $form);
	
? } # end block content