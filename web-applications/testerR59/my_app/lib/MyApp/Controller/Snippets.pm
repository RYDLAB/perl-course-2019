package MyApp::Controller::Snippets;
use Mojo::Base 'Mojolicious::Controller';

sub main_page {
    my $self = shift;

    # get data to show on main_page
    # ...

    $self->render();
}

sub show_one {
    my $self = shift;

    # get details of one snippet
    # ...

    $self->render();
}

sub create_page {
    my $self = shift;

    # get list of languages
    # ...

    $self->render();
}

sub create_one {
    my $self = shift;

    # save data of snippet
    # ...

    $self->redirect_to('snippet', id => 0);
}

1
