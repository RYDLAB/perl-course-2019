package Megacode::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';

sub search_page {
    my $self = shift;
    
    $self->render(text => 'Сорямба, я еще не сделяль');
}

sub search_by_title {
    my $self = shift;

    $self->render(text => 'Увы и ах! Как это делается -- я еще учусь...');
}

1
