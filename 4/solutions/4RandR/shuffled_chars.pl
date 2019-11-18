#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Pod::Usage qw(pod2usage);

binmode STDOUT, ':encoding(UTF-8)';

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

open (my $filehandle, '<:encoding(UTF-8)', $file_name) or die "couldn't open '$file_name': $!";

my $original_text = join '', <$filehandle>;

close($filehandle);

$original_text =~ s/(\w)(\w{2,})(\w)/$1.(reverse $2).$3/eg;
print $original_text;

__END__
=encoding UTF-8

=head1 ИМЯ

shuffled_chars.pl

Для каждого из слов, меняет порядок всех букв кроме первой и последней на обратный.

=head1 СИНТАКСИС

./shuffled_chars.pl ./shuffle_me.txt
