#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Pod::Usage qw(pod2usage);

binmode STDOUT, ':encoding(UTF-8)';
my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;


my $original_text = my $parsed_text = do {
    local $/ = undef;

    open (my $filehandle, '<:encoding(UTF-8)', $file_name) or die "couldn't open '$file_name': $!";

    <$filehandle>;
};

while ($original_text =~ /\b(.)([а-яА-Я]*?)([^\s]?)\b/g) {
    my $first = $1;
    my $second = reverse $2;
    my $third = $3;

    $parsed_text =~ s/$&/$first$second$third/;
}

print $parsed_text;

__END__
=encoding UTF-8

=head1 ИМЯ

shuffled_chars.pl

Для каждого из слов, меняет порядок всех букв кроме первой и последней на обратный.

=head1 СИНТАКСИС

./shuffled_chars.pl ./shuffle_me.txt
