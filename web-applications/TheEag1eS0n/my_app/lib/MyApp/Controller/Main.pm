package MyApp::Controller::Main;

use Mojo::Base 'Mojolicious::Controller';

sub mainpage {
	my $self = shift;
	# my $snippets = $self->app->model('get')->get_snippets();
	# $self->stash(
	# 	snippets => $snippets
	# );

	$self->stash(total_items => 30, items_per_page => 10);

	$self->render('/content/mainpage');
}

sub about {
	my $self = shift;

	$self->render('/content/about');
}

1