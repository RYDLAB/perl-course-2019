#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);

pod2usage( -verbose => 99 ) if -t STDIN;

...

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
