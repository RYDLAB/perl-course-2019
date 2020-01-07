package Megacode::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub create_snippet {
    my $self = shift;

    $self->render('/snippet/create_snippet');
}

1