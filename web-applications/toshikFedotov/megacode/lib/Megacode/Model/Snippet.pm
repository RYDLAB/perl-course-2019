package Megacode::Model::Snippet;

use strict;
use warnings;
use utf8;
use Digest::MD5 'md5_hex';
use Encode 'encode_utf8';


use Mojo::Base 'MojoX::Model';
use Digest::SHA qw(sha1_base64);

sub get_snippet {
    my ($self, $id, $is_hide) = @_;
    my $db = $self->app->db->db;

    my %result;

    if ($is_hide eq 'True') {
        $id = $db->query(
            'select snippet_id from encrypted_keys
             where key = (?)', $id
        )->hash->{'snippet_id'}
    }

    $result{'snippet'} = $db->query('select * from snippets where id = (?)', $id)->hash;
    $result{'files'} = $db->query('select * from files where snippet_id = (?)', $id)->hash;
    $result{'languages'} = $db->query(
        'select l.name from languages l, files f
         where f.id = (?) and f.language_id = l.id',
         $result{files}->{id}
    )->hash;

    return \%result
}

sub create_snippet {
    my ($self, %params) = @_;
    my $db = $self->app->db->db;

    my $tx = $db->begin;

    $params{'is_hide'} = defined $params{'is_hide'} ? 'True' : 'False';

    my ($snip_name, $lang_type, $is_hide, $content) = ($params{'snippet_name'},
                                                       $params{'file_type'},
                                                       $params{'is_hide'},
                                                       $params{'content'});
    my $id = $db->insert( snippets =>
        {
                title => $snip_name,
                is_hide => $is_hide,
                creating_date => $db->query('select now() as now')->hash->{'now'}
        },
        {
            returning => 'id'
        }
    )->hash->{'id'};

    my $lang_id = $db->query('select id from languages where name = (?)', $lang_type)->hash->{'id'};

    $db->insert( files =>
        {
            snippet_id => $id,
            language_id => $lang_id,
            title => $snip_name,
            content => $content,
            queue_num => 1
        }
    );
    my ($result, $type) = ($id, 'id');

    if ($is_hide eq 'True') {
        $result = $db->insert ( encrypted_keys =>
            {
                snippet_id => $id,
                key => sha1_base64 $id . sha1_base64 $snip_name
            },
            {
                returning => 'key'
            }
        )->hash->{'key'};

        $type = 'key';
    }

    $tx->commit;

    return ($result, $type);
}

1
