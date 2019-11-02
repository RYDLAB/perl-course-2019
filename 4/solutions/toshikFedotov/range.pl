#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);
use strict;
use warnings;
use v5.10;

pod2usage( -verbose => 99 ) if -t STDIN;

my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;
my $chars = readline;
my @all_series;
while($chars =~ /(\w)/g) {
    my $next_char = $1;
    state $series;
    if (!defined $series) {
        $series = "$next_char-$next_char";
        next;
    }
    elsif ($next_char =~ /[$series]/) {
        push @all_series, $series;
        $series = "$next_char-$next_char";
    }
    else {
        $series =~ s/(\w)-\w/$1-$next_char/;
        push @all_series, $series if $chars =~ /$next_char\n/;
    }
}
say join ',', @all_series;

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
