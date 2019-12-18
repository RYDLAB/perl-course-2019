package Megacode::Model::Main;

use strict;
use warnings;

use Mojo::Base 'MojoX::Model';

sub get_snippets {
    my $self = shift;
    my $limit = $self->app->plugin('Config')->{'snip_limit'};
    my $db = $self->app->db->db;

    my $snippets = $db->query(
        'select * from snippets where is_hide = \'f\'
         order by creating_date desc limit (?)', $limit
    )->hashes;
    foreach my $snippet (@$snippets) {
        $snippet->{file} = $db->query(
            'select * from files where queue_num = 1 and
             snippet_id = (?)', $snippet->{id}
        )->hash;

        # limit the content of the file to ten lines
        $snippet->{file}{content} = $&."\n..." if $snippet->{file}{content} =~ /(.*\n){10}/;
        

        $snippet->{language} = $db->query(
            'select name from languages where
             id = (?)', $snippet->{file}{language_id}
        )->hash->{'name'};
    }
    return $snippets;
}
1
