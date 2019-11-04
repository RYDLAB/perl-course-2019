#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

use utf8;
my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;

my $eng_spy = 'aceoprxyABCEHKMOPTX';
my $eng_other = 'bdfghijklmnqstuvwz';
my $rus_spy = 'асеоргхуАВСЕНКМОРТХ';
my $rus_other = 'бвдёжзийклмнптфцщчшщъыьэюя';

open(my $fh, "< $encoding", $file_name) or die "Can't open $file_name : $!";
while (<$fh>) {
    if (/[$eng_spy]+/ && /[$rus_other]+/) {eval "y/$eng_spy/$rus_spy/"}
    elsif (/[$rus_spy]+/ && /[$eng_other]+/) {eval "y/$rus_spy/$eng_spy/"}
    print $_;
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
