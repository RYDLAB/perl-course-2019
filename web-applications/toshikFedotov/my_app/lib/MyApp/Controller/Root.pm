package MyApp::Controller::Root;
use Mojo::Base 'Mojolicious::Controller';

sub mainpage {
    my $self = shift;

    $self->render;
}

sub show_about {
    my $self = shift;

    $self->render(text => 'Megacode is a super-puper code-sharing site');
}

1
