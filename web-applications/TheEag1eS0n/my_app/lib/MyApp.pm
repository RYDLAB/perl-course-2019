package MyApp;
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

  # # Normal route to controller
  # $r->any('/')->to('layouts#default');


#main pages
  my $main = $r->any('/main')->to(
    controller => 'main',
    action => 'mainpage'
  );

  $main = $r->any('/')->to(
    controller => 'main',
    action => 'about'
  );

#snippet pages
  my $snippet = $r->get('/snippet/new')->to(
    controller => 'snippet',
    action => 'create_snippet'
    );


  my $db = Mojo::Pg->new($config->{postgresql}{url});
  
  $db->migrations->from_file(
  	$self->home->rel_file('./etc/migrations.sql')
  );

  $self->attr(
	db => sub{ $db },
  );

  $self->attr(
	pg => sub { $self->db->db },
  );
}

1;
