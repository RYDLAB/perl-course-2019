package CodeChunks::Controller::SnippetsApi;
use Mojo::Base 'Mojolicious::Controller';

use strict;
use warnings;

use LWP::Simple;

my $chars = 'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890';

sub get {
    my $c = shift;

    my $url = $c->param('url_name');
    unless ($url) {
        $c->render(text => 'Bad request', status => 400);
        return
    }

    my $result = $c->snippets->find_by_url($url);
    $c->render(json => $result, status => $result ? 200 : 404);
}

sub get_all {
    my $c = shift;
    my $v = $c->validation;

    my $skip = $c->param('skip');
    my $take = $c->param('take');
    $v->input({ skip => $skip, take => $take });
    $v->required('skip')->num();
    $v->required('take')->num();
    if ($v->has_error) {
        $c->render(text => 'Bad request', status => 400);
        return
    }

    $c->render(json => $c->snippets->list_paged_view($skip, $take))
}

sub add {
    my $c = shift;
    my @text = ();
    foreach my $s (@{$c->req->json->{parts}}) {
        my $value = $s->{value};
        my $url = $s->{url};

        my $part = $url ? LWP::Simple::get($url) : $value;
        $part =~ s/\r\n/\n/g;

        push @text, $part;
    }

    my $url = "";
    for (0 .. 7) {
        $url = $url . substr($chars, (rand length($chars)), 1)
    }

    $c->snippets->add({ url => $url, text => join("\n", @text), private => $c->req->json->{private}});
    $c->render(json => { url => $url })
}

sub delete {
    my $c = shift;
    my $v = $c->validation;

    my $id = $c->param('id');
    $v->input({ id => $id });
    $v->required('id')->num();
    if ($v->has_error) {
        $c->render(text => 'Bad request', status => 400);
        return
    }

    $c->snippets->remove($id)
}

1;
