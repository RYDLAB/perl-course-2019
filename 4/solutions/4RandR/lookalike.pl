#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;
use utf8;
use Pod::Usage qw(pod2usage);

binmode STDOUT, ':encoding(UTF-8)';

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

my %english_to_russian = (a => 'а', A => 'А', 'y' => 'у', 'o' => 'о', 'O' => 'О', 'e' => 'е', 'E' => 'Е', 'c' => 'с',
'C' => 'С', 'B' => 'В', 'M' => 'М', 'x' => 'х', 'X' => 'Х', 'p' => 'р', 'P' => 'Р', 'H' => 'Н');

my %russian_to_english = reverse %english_to_russian;

my $keys_english = join '|', keys %english_to_russian;
my $keys_russian = join '|', keys %russian_to_english;

open (my $filehandle, '<:encoding(UTF-8)', $file_name) or exit;

sub translate {
    my ($line, $keys, %letters) = @_;
    $line =~ s/$keys/$letters{$&}/g;
    print $line;
}

my @lines = <$filehandle>;

translate($lines[0], $keys_russian, %russian_to_english);
translate($lines[1], $keys_english, %english_to_russian);

close($filehandle);

__END__
=pod

=encoding UTF-8

=head1 ИМЯ

anti_lookalike.pl

Устраняет иноязычные буквы со схожим начертанием из слов, результаты печатает на экран.
Текст исходного сообщения находится в файле normal.txt

=head1 СИНТАКСИС

./anti_lookalike.pl ./remove_lookalike.txt
