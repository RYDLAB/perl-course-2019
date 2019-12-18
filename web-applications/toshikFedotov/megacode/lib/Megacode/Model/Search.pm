package Megacode::Model::Search;

use Mojo::Base 'MojoX::Model';

sub get_results {
    my ($self, $title) = @_;
    my $db = $self->app->db->db;
    $title =~ s/.*/%$&%/;

    my $snippets = $db->query(
        'select * from snippets
         where is_hide=\'f\' and
         title like (?)', $title
    )->hashes;

    foreach my $snippet (@$snippets) {
        $snippet->{file} = $db->query(
            'select * from files where queue_num = 1 and
             snippet_id = (?)', $snippet->{id}
        )->hash;

        $snippet->{file}{content} = $& . "\n..." if $snippet->{file}{content} =~ /(.*\n){10}/;

        $snippet->{language} = $db->query(
            'select name from languages where
             id = (?)', $snippet->{file}{language_id}
        )->hash->{'name'};
    }

    return $snippets;
}

1
