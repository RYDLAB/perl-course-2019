#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

binmode STDOUT, ':utf8';

open(my $file, '<:encoding(UTF-8)', $file_name) or die "Can't open $file_name: $!";

my $english = 'a-z';
my $russian = 'а-яё';
my $eng_as_rus = 'aceopxABCEHMOPTX';
my $rus_as_eng = 'асеорхАВСЕНМОРТХ';

while(<$file>){
    next unless /[$english]/i && /[$russian]/i;
    eval "tr/$rus_as_eng/$eng_as_rus/" unless grep {/[^$rus_as_eng]/} /[$russian]/ig;
    eval "tr/$eng_as_rus/$rus_as_eng/" unless grep {/[^$eng_as_rus]/} /[$english]/ig;
} continue {
    print
}

close $file;

__END__
=pod

=encoding UTF-8

=head1 ИМЯ

anti_lookalike.pl

Устраняет иноязычные буквы со схожим начертанием из слов, результаты печатает на экран.
Текст исходного сообщения находится в файле normal.txt

=head1 СИНТАКСИС

./anti_lookalike.pl ./remove_lookalike.txt
