package MyApp::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';

sub search_page {
    my $self = shift;

    $self->render(text => 'Sorry, but this page in the development stage');
}

sub search_by_title {
    my $self = shift;
    my $title = $self->param('title_name');

    $self->render(text => "There is nothing about $title"); 
}

1
