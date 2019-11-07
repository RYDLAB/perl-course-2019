#!/usr/bin/env perl

use utf8;
use strict;

use warnings FATAL => 'all';
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage(-verbose => 99) unless defined $file_name;
binmode(STDOUT, ":utf8");
local $/ = undef;
open FH, "< :utf8", $file_name or die $!;

my $string = <FH>;
$string =~ s/(?<![а-яёa-z]{2})(?<=[а-яёa-z])([а-яёa-z]+)(?=[а-яёa-z])(?![а-яёa-z]{2})/reverse $1 /ieg;
print $string;

close(FH);

__END__
=encoding UTF-8

=head1 ИМЯ

shuffled_chars.pl

Для каждого из слов, меняет порядок всех букв кроме первой и последней на обратный.

=head1 СИНТАКСИС

./suffled_chars.pl ./shuffle_me.txt
