package MyContactForm;
use Ark 'Form';

param subject => (
	label		=> 'Subject',
	type		=> 'TextField',
	constraint	=> [
		'NOT_NULL',
		[ 'LENGTH', 0, 100 ],
	],
);

param message => (
	label		=> 'Message',
	type		=> 'TextField',
	widget		=> 'textarea',
	constraint	=> ['NOT_NULL'],
);

param sender => (
	label		=> 'E-mail',
	type		=> 'EmailField',
	constraint	=> ['NOT_NULL'],
);

1;