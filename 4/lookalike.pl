#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

binmode STDOUT, ':utf8';

open(my $file, '<:encoding(UTF-8)', $file_name) or die "Can't open $file_name: $!";
my $eng = 'aceopxABCEHMOPTX';
my $rus = 'асеорхАВСЕНМОРТХ';
while(<$file>){
    print, next if /^[^a-z]+$/i || /^[^а-яё]+$/i;
    eval "tr/$rus/$eng/" unless grep {/[^$rus]/} /[а-яА-Я]/g;
    eval "tr/$eng/$rus/" unless grep {/[^$eng]/} /[a-zA-Z]/g;
    print
}
close $file;
