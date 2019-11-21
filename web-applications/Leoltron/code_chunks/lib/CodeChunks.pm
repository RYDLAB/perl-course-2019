package CodeChunks;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;

use CodeChunks::Model::Snippets;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Load configuration from hash returned by config file
    my $config = $self->plugin('Config');
    # Configure the application
    $self->secrets($config->{secrets});

    # Model
    $self->helper(pg => sub {state $pg = Mojo::Pg->new($ENV{"POSTGRES_CONNECTION_URL"})});
    $self->helper(snippets => sub {state $snippets = CodeChunks::Model::Snippets->new(pg => shift->pg)});

    $self->pg->migrations->from_file($self->home->rel_file('./etc/migrations.sql'));

    # Router
    my $r = $self->routes;
    $r->get('/')->to('SnippetsView#show_list');
    $r->get('/add')->to('SnippetsForms#add');
    $r->get('/:url_name')->to('SnippetsView#show_one');
    $r->get('/:url_name/raw')->to('SnippetsView#show_one_raw');
    $r->get('/api/snippets')->to('SnippetsApi#get_all');
    $r->get('/api/snippets/:url_name')->to('SnippetsApi#get');
    $r->post('/api/snippets/add')->to('SnippetsApi#add');
    $r->delete('/api/snippets/:url_name/delete')->to('SnippetsApi#delete');

    delete $self->static->extra->{'favicon.ico'};
}

1;
