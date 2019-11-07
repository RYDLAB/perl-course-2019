#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;
use Pod::Usage qw(pod2usage);

pod2usage(-verbose => 99) if -t STDIN;

sub find_relation {
    my ($one, $other) = @_;
    if (chr(ord($one) + 1) eq $other) {
        return 1
    }
    elsif (chr(ord($one) - 1) eq $other) {
        return -1
    }

    return 0
}
my $chars = join(" ", <STDIN>);

$chars =~ /([^a-z]+)/;
my $separator = $1 || "";
$chars =~ s/[^a-z]//g;

my @return_list;
my $start;
my $end;
my $seq_length = 1;
my $seq_direction = 0;
my $c;

foreach $c (split //, $chars) {
    cycle_start:
    if (!$start) {
        $start = $end = $c;
        next
    }

    if ($seq_length == 1) {
        $seq_direction = find_relation($start, $c);
        if ($seq_direction == 0) {
            push @return_list, $start;
            $start = $end = $c;
            next
        }
    }

    if (chr(ord($end) + $seq_direction) eq $c) {
        $end = $c;
        $seq_length++;
    }
    else {
        if ($seq_length == 2) {
            push @return_list, $start;
            $start = $end;
            $seq_length = 1;
            goto cycle_start;
        }
        else {
            push @return_list, "$start-$end";
        }
        $start = $end = $c;
        $seq_length = 1;
        $seq_direction = 0
    }
}
if ($seq_length == 1) {
    push @return_list, $start
}
elsif ($seq_length == 2) {
    push @return_list, $start, $end
}
else {
    push @return_list, "$start-$end"
}
say join($separator, @return_list);

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
