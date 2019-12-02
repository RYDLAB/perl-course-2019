package Megacode::Controller::Snippet;
use Mojo::Base 'Mojolicious::Controller';

sub about_snippets {
    my $self = shift;

    $self->render(text => 'Сниппеты это круто');
}

sub create_snippet {
    my $self = shift;

    $self->render(text => 'Как бы не так');
}

sub snippet_by_id {
    my $self = shift;
    
    $self->render(text => 'Ваш сниппет появится попозже');
}

sub snippet_by_key {
    my $self = shift;

    $self->render(text => 'Ваш скрытый сниппет еще прячется');
}

1
