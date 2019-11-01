#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

binmode STDOUT, ':utf8';

open(my $file, '<:encoding(UTF-8)', $file_name) or die "Can't open $file_name: $!";
my $english = 'aceopxABCEHMOPTX';
my $russian = 'асеорхАВСЕНМОРТХ';
while(<$file>){
    print, next if /^[^a-z]+$/i || /^[^а-яё]+$/i;
    eval "tr/$russian/$english/" unless grep {/[^$russian]/} /[а-яА-Я]/g;
    eval "tr/$english/$russian/" unless grep {/[^$english]/} /[a-zA-Z]/g;
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
