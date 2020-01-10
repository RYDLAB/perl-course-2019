package MyApp::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub create_snippet {
    my $self = shift;

    $self->render('/snippet/create_snippet');
}

sub get_created_snippet {
    my $self = shift;
    my $params = $self->req->params->to_hash;

    my ($snip, $type) = $self->app->model('Snippet')->create_snippet( $params->%* );

    if ( $type eq 'id' )
    {
        $self->redirect_to("/snippet/id/$snip");
    } else {
        $self->redirect_to("/");
    }
}

sub snippet_render {
	my $self = shift;

	my $snipID = $self->param('snip_id');
	my $res = $self->model('Snippet')->get_snippet($snipID, 'False');

	if (defined $res->{snippet}{title} && !$res->{snippet}{is_hide}) {
		$self->stash(res => $res);
		$self->render('/snippet/snippet');
	}
	else {
		$self->render('/layout/default');
	}
}

1