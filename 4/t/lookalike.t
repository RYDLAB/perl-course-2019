#!/usr/bin/env perl

use Test::More tests => 1;
use FindBin qw( $Bin );

use Digest::SHA qw( sha1_base64 );

my $checksum = 'QPc4b3O5tvvC2jy9MKgYbD8vCtg';

my $out = `perl -wMstrict '$Bin/../lookalike.pl' ./remove_lookalike.txt 2>&1`;

is (
    sha1_base64( $out ),
    $checksum,
    'text matched',
);
