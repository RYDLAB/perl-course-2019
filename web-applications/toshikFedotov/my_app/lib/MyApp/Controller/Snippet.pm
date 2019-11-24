package MyApp::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub create_snippet {
    my $self = shift;

    $self->render(text => 'Sorry, but this page in development stage');
}

sub snippet_by_id {
    my $self = shift;
    my $snippet_id = $self->param('snip_id');

    $self->render(text => "Snippet #$snippet_id not found");
}

sub snippet_by_key {
    my $self = shift;
    my $encryp_key = $self->param('encr_key');

    $self->render(text => "Snippet with key: $encryp_key not found");
}

1
