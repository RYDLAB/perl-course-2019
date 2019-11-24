package MyApp;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller

  $r->get('/')->to(
    controller => 'root',
    action => 'mainpage',
  );

  $r->get('/about')->to(
    controller => 'root',
    action => 'show_about',
  );

  my $snippet = $r->any('/snippet')->to(controller => 'snippet');

  $snippet->get('/new')->to(action => 'create_snippet');

  $snippet->get('/id=<:snip_id>')->to(action => 'snippet_by_id');

  $snippet->get('/key=<:encr_key>')->to(action => 'snippet_by_key');
  
  my $search = $r->any('/search')->to(controller => 'search');

  $search->get('/')->to(action => 'search_page');

  $search->get('/title=<:title_name>')->to(action => 'search_by_title');


  my $db = Mojo::Pg->new($config->{posgresql}{url});

  $db->migrations->from_file(
    $self->home->rel_file('./etc/migrations.sql')
  );

  $self->attr(
    db => sub { $db },
  );
}

1
