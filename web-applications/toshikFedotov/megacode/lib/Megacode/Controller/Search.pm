package Megacode::Controller::Search;
use Mojo::Base 'Mojolicious::Controller';

sub search_page {
    my $self = shift;

    $self->render();
}

sub get_title {
    my $self = shift;

    my $title = $self->req->params->to_hash->{'title'};
    $self->redirect_to("/search/title/$title");
}

sub search_by_title {
    my $self = shift;
    my $title = $self->param('title_name');

    my $snippets = $self->app->model('Search')->get_results($title);
    if (defined $snippets->[0]{title}) {
        $self->stash(snippets => $snippets);
        $self->render();
    } else {
        $self->render(template => 'search/search_not_found');
    }
}

1
