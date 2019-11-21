package CodeChunks::Controller::SnippetsView;
use Mojo::Base 'Mojolicious::Controller';

use strict;
use warnings;

sub show_list {
    my $c = shift;

    $c->render(snippets => $c->snippets->list_paged_view(0, 5));
}

sub show_one{
    my $c = shift;

    my $url = $c->param('url_name');
    unless ($url) {
        $c->render(text => 'Bad request', status => 400);
        return
    }

    my $result = $c->snippets->find_by_url($url);
    unless($result){
        $c->render(text => 'Not found', status => 404);
        return
    }

    $c->render(snippet => $result);
}

sub show_one_raw{
    my $c = shift;

    my $url = $c->param('url_name');
    unless ($url) {
        $c->render(text => 'Bad request', status => 400);
        return
    }

    my $result = $c->snippets->find_by_url($url);
    unless($result){
        $c->render(text => 'Not found', status => 404);
        return
    }

    $c->render(text => $result->{'text'}, format => 'txt');
}

1;
