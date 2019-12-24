package Megacode;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->plugin('Model');

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

# Main pages

  my $main = $r->any('/')->to(controller => 'main');

  $main->get('/')->to(action => 'mainpage');

  $main->get('/about')->to(action => 'about');

# Snippets

  my $snippet = $r->any('/snippet')->to(controller => 'snippet');

  $snippet->get('/')->to(action => 'about_snippets');

  $snippet->get('/new')->to(action => 'create_snippet');

  $snippet->post('/new')->to(action => 'get_created_snippet');

  $snippet->get('/id/<*snip_id>')->to(action => 'snippet_by_id');

  $snippet->get('/key/<*encr_key>')->to(action => 'snippet_by_key');

# Search pages

  my $search = $r->any('/search')->to(controller => 'search');

  $search->get('/')->to(action => 'search_page');

  $search->post('/')->to(action => 'get_title');

  $search->get('/title/<*title_name>')->to(action => 'search_by_title');


  my $db = Mojo::Pg->new($config->{postgresql}{url});

  $db->migrations->from_file(
    $self->home->rel_file('/etc/migrations.sql')
  );

  $self->attr(
    db => sub { $db },
  );
}

1;
