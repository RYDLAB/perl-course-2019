#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);
use strict;
use warnings;
use v5.10;

pod2usage( -verbose => 99 ) if -t STDIN;

my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;
my $chars = readline;
my $letters = 'abcdefghijklmnopqrstuvwxyz';
my @all_series;
while ($chars =~ /(\w)/g) {
    my $next_char = $1;
    state $series = undef;
    state ($f_pos, $s_pos);
    my $nextchar_pos = index $letters, $next_char; 
    if (!defined $series) {
        $series = "$next_char-$next_char";
        $f_pos = $s_pos = $nextchar_pos; 
        next;
    }
    if ($f_pos <= $s_pos) {
        if ($next_char =~ /[$series]/) {
            push_series($f_pos, $s_pos, $series);
            $series = "$next_char-$next_char";
            $f_pos = $s_pos = $nextchar_pos;
        }
        else {
            $series =~ s/(\w)-\w/$1-$next_char/;
            $s_pos = $nextchar_pos;
            push_series($f_pos, $s_pos, $series) if $chars =~ /$next_char\n/;
        }
    }
    else {
        if ($nextchar_pos > $s_pos && $nextchar_pos < $f_pos) {
            push_series($f_pos, $s_pos, $series);
            $series = "$next_char-$next_char";
            $f_pos = $s_pos = $nextchar_pos;
        }
        else {
            $series =~ s/(\w)-\w/$1-$next_char/;
            $s_pos = $nextchar_pos;
            push_series($f_pos, $s_pos, $series) if $chars =~ /$next_char\n/;
        }
    }
}
say join ',', @all_series;
sub push_series {
    my ($f_pos, $s_pos, $series) = @_;
    if (abs($f_pos - $s_pos) > 1) {push @all_series, $series}
    else {$series =~ /(\w)-(\w)/; push @all_series, $1, $2}
}

__END__
=pod

=encoding UTF-8

=head1 ИМЯ

range.pl

Принимает список английских букв с произвольным разделителем (или без него), и преобразует идущие подряд символы в диапазоны:

a b c d d c b a -> a-d d-a

xyz -> x-z

=head1 СИНТАКСИС

echo abc | ./range.pl
