#!/usr/bin/env perl

use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;
open(my $fh, "< $encoding", $file_name);
while (<$fh>) {
   $_ =~ s/(\w?+)(\w+)(\w{1})/$1 . (reverse $2) . $3/gxe;
   print $_;
}

__END__
=encoding UTF-8

=head1 ИМЯ

shuffled_chars.pl

Для каждого из слов, меняет порядок всех букв кроме первой и последней на обратный.

=head1 СИНТАКСИС

./suffled_chars.pl ./shuffle_me.txt
