package Megacode::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

sub mainpage {
    my $self = shift;
    my $snippets = $self->app->model('Main')->get_snippets();

    $self->stash(
        snippets => $snippets
    );

    $self->render('main/mainpage');
}

sub about {
    my $self = shift;

    $self->render();
}

1
