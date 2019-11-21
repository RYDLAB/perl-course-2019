package CodeChunks::Model::Snippets;
use Mojo::Base -base;

has 'pg';

use strict;
use warnings FATAL => 'all';


sub add {
    my ($self, $snippet) = @_;
    return $self->pg->db->insert('snippets', $snippet, { returning => 'snippet_id' })->hash->{snippet_id};
}

sub list {shift->pg->db->select('snippets')->hashes->to_array}

sub list_paged_view {
    my ($self, $skip, $take) = @_;
    shift->pg->db->query('select
    snippet_id, url, to_char(creation_date, \'DD.MM.YYYY HH24:MI:SS\') as creation_date,
    substring(text, \'^[^\n]*(?:\n[^\n]*){0,9}\') as text_short,
    length(text) as total_length
     from snippets where not private LIMIT (?) OFFSET (?)', $take, $skip)->hashes->to_array
}

sub find_by_id {
    my ($self, $id) = @_;
    return $self->pg->db->select('snippets', '*', { snippet_id => $id })->hash;
}

sub find_by_url {
    my ($self, $url) = @_;
    return $self->pg->db->select('snippets', '*', { url => $url })->hash;
}

sub remove {
    my ($self, $id) = @_;
    $self->pg->db->delete('snippets', { snippet_id => $id });
}

sub save {
    my ($self, $id, $snippet) = @_;
    $self->pg->db->update('snippets', $snippet, { snippet_id => $id });
}


1;
