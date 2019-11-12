package Megacode::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub about_snippets {
    my $self = shift;

    $self->render();
}

sub create_snippet {
    my $self = shift;

    $self->render();
}

sub get_created_snippet {
    my $self = shift;
    my $params = $self->req->params->to_hash;

    my ($snip, $type) = $self->app->model('Snippet')->create_snippet( $params->%* );

    if ( $type eq 'id' )
    {
        $self->redirect_to("/snippet/id/$snip");
    } else {
        $self->redirect_to("/snippet/key/$snip");
    }
}

sub snippet_by_id {
    my $self = shift;
    
    my $snip_id = $self->param('snip_id');
    my $res = $self->model('Snippet')->get_snippet($snip_id, 'False');
    if ( defined $res->{snippet}{title} && !$res->{snippet}{is_hide}) {
        $self->stash(res => $res);
        $self->render('/snippet/snippet');
    }
    else {
        $self->render('/main/notfound');
    }
}

sub snippet_by_key {
    my $self = shift;

    my $key = $self->param('encr_key');
    my $res = $self->model('Snippet')->get_snippet($key, 'True');
    if (defined $res->{snippet}{title} ) {
        $self->stash(
            res => $res,
            snip_id => $res->{snippet}{id} 
        );
        $self->render('/snippet/snippet');
    }
    else {
        $self->render('/main/notfound');
    }
}

1
