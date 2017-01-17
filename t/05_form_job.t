use Test::More;
use CGI::Simple;

use_ok 'Jobeet::Form::Job';

{
	my $f = Jobeet::Form::Job->new(
		CGI::Simple->new({
			category	=> 'design',
			type		=> 'full-time',
			company		=> 'Sensio',
			url			=> 'http://sensio.com',
			position	=> 'Dev',
			location	=> 'Atlanta, USA',
			description	=> 'Hello World',
			how_to_apply => 'Send email',
			email		=> 'job@sensio.com'
		}),
	);

	ok $f->submitted_and_valid;
}

{
	my $f = Jobeet::Form::Job->new(
        CGI::Simple->new({
            company      => 'Sensio Labs',
            position     => 'Developer',
            location     => 'Atlanta, USA',
            email        => 'not.an.email',
        }),
    );

    ok $f->has_error, 'form has error ok';

    like $f->error_message_plain('description'),
        qr/required/, 'description required ok';
    like $f->error_message_plain('how_to_apply'),
        qr/required/, 'how_to_apply required ok';
    like $f->error_message_plain('email'),
        qr/invalid/, 'email is invalid ok';
}

done_testing;