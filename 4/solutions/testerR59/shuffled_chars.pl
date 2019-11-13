#!/usr/bin/env perl

use strict;
use warnings;
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

binmode STDOUT, ':utf8';

open(my $file, '<:encoding(UTF-8)', $file_name) or die "Can't open $file_name: $!";
s/\b(\w)(\w+)(\w)\b/$1.(reverse $2).$3/eg, print while <$file>;
close $file;

__END__
=encoding UTF-8

=head1 ИМЯ

shuffled_chars.pl

Для каждого из слов, меняет порядок всех букв кроме первой и последней на обратный.

=head1 СИНТАКСИС

./suffled_chars.pl ./shuffle_me.txt
