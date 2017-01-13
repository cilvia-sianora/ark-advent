package Jobeet::Controller::Job;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    # print "job controller\n";
    # my $temp = models('Schema::Job');
    # foreach my $job ($temp){
    # 	print $job->position,"\n";
    # }

    $c->stash->{jobs} = models('Schema::Job');
}

1;
