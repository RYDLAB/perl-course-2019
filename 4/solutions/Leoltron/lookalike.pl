#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage(-verbose => 99) unless defined $file_name;

my $eng_similar_letters = 'aceopxABCEHMOPTX';
my $rus_similar_letters = 'асеорхАВСЕНМОРТХ';
my $rus_to_eng = "tr/$rus_similar_letters/$eng_similar_letters/";
my $eng_to_rus = "tr/$eng_similar_letters/$rus_similar_letters/";

sub chars_from_same_language {
    my $word = shift;
    return $word =~ /^([a-zA-Z]+|[а-яёА-ЯЁ]+)$/ig;
}

binmode(STDOUT, ":utf8");
open my $fh, "< :utf8", $file_name or die $!;

while (<$fh>) {
    unless (chars_from_same_language($_)) {
        eval(/[qwrtuisdfghjklzvbnmQWRYUISDFGJKLZVN]/ ? $rus_to_eng : $eng_to_rus);
    }
    print $_
}
close $fh;


__END__
=pod

=encoding UTF-8

=head1 ИМЯ

anti_lookalike.pl

Устраняет иноязычные буквы со схожим начертанием из слов, результаты печатает на экран.
Текст исходного сообщения находится в файле normal.txt

=head1 СИНТАКСИС

./anti_lookalike.pl ./remove_lookalike.txt
