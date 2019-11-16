#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

use utf8;
my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;

my $eng_spy = 'aceoprxyABCEHKMOPTX';
my $rus_spy = 'асеоргхуАВСЕНКМОРТХ';

open(my $fh, "< $encoding", $file_name) or die "Can't open $file_name : $!";

while (<$fh>) {
    # Если в одной строке находятся буквы английского алфавита и русские буквы,
    # похожие на английские, то делаем вывод, что русские буквы -- "шпионы", и мы
    # их заменяем на нормальные английские. То же самое и с английскими "шпионами" в русской строке
    eval "y/$rus_spy/$eng_spy/" if / [a-zA-Z]+ [$rus_spy]+ | [$rus_spy]+ [a-zA-Z]+ /x;
    eval "y/$eng_spy/$rus_spy/" if / [а-яА-Я]+ [$eng_spy]+ | [$eng_spy]+ [а-яА-Я]+ /x;
    print;
}

__END__
=pod

=encoding UTF-8

=head1 ИМЯ

anti_lookalike.pl

Устраняет иноязычные буквы со схожим начертанием из слов, результаты печатает на экран.
Текст исходного сообщения находится в файле normal.txt

=head1 СИНТАКСИС

./anti_lookalike.pl ./remove_lookalike.txt
