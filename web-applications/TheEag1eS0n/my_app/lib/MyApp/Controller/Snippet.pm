package MyApp::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub create_snippet {
    my $self = shift;

    $self->render('/snippet/create_snippet');
}

sub get_created_snippet {
	my $self = shift;

	$self->redirect_to("/snippet/id");
}

sub snippet_render {
	my $self = shift;

	$self->render('/snippet/snippet');
}

1