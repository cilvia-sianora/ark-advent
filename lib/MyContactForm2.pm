package MyContactForm2;
use Ark 'Form';

extends 'MyContactForm';

param '+message' => (
	constraint => [
		'NOT_NULL',
		['LENGTH', 0, 3000],
	],
);

param url => (
	label	=> 'URL',
	type	=> 'TextField',
);

1;