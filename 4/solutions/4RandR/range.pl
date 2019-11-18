#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use List::MoreUtils qw(first_index);
use Pod::Usage qw(pod2usage);

binmode STDOUT, ':encoding(UTF-8)';

pod2usage( -verbose => 99 ) if -t STDIN;

my @letters = grep /[a-zA-Z]/, split //, readline;

my $alphabet = 'abcdefghijklmnopqrstuvwxyz';

my $start_symbol = $letters[0];
my $start_index = index $alphabet, $start_symbol;

my $is_greater;

my @symbols;
my @result;

sub get_is_greater {
    $is_greater = shift gt shift;
}

get_is_greater($start_symbol, $letters[1]);

sub get_start_index {
    $start_index = get_is_greater($start_symbol, $letters[2 + first_index {$_ eq $start_symbol} @letters])
        ? (index $alphabet, $start_symbol) - 1
        : (index $alphabet, $start_symbol) + 1;
}

sub push_symbols {
    my $end_symbol = shift;
    if (scalar @symbols <= 3) {
        push @result, (@symbols);
    }
    else {
        push @result, "$start_symbol-$end_symbol";
    }
}

sub a_greater_then_b {
    push @symbols, $_;

    if ($_ ne substr ($alphabet, $start_index--, 1)) {
        my $end_symbol = substr ($alphabet, $start_index - 2, 1);

        push_symbols($end_symbol);

        $start_symbol = $_;

        $start_index = get_start_index();

        @symbols = ();
    }
}

sub a_less_then_b {
    push @symbols, $_;

    if ($_ ne substr ($alphabet, $start_index++, 1)) {
        my $end_symbol = substr ($alphabet, $start_index - 2, 1);

        push_symbols($end_symbol);

        $start_symbol = $_;

        $start_index = get_start_index();

        @symbols = ();
    }
}


for (@letters) {
    if ($is_greater) {
        a_greater_then_b();
    }
    else {
        a_less_then_b();
    }
}

my $end_symbol = $is_greater
    ? substr ($alphabet, $start_index + 1, 1)
    : substr ($alphabet, $start_index - 1, 1);

push @result, "$start_symbol-$end_symbol" if $start_symbol ne $end_symbol;

print join ',', @result;
print "\n";


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
