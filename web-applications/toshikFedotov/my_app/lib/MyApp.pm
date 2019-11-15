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
  $r->get('/')->to('example#welcome');

  my $db = Mojo::Pg->new($config->{posgresql}{url});
  
  $db->migrations->from_file(
    $self->home->rel_file('./etc/migrations.sql')
  );
  
  $self->attr(
    db => sub { $db },
  );

  $self->attr(
    pg => sub { $self->db->db },
  );
}

1
