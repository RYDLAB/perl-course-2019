package Megacode::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';

sub mainpage {
    my $self = shift;

    $self->render(text => 'This page in development stage, sorry');
}

sub about {
    my $self = shift;

    $self->render(text => 'This page in development stage, сорямба :('); 
}

1
