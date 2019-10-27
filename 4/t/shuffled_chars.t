#!/usr/bin/env perl

use Test::More tests => 1;
use FindBin qw( $Bin );

use Digest::SHA qw( sha1_base64 );

my $checksum = '0QirwgMCA8oKJ4hkLft29tWA8G0';

my $out = `perl -wMstrict '$Bin/../shuffled_chars.pl' ./shuffle_me.txt 2>&1`;

is (
    sha1_base64( $out ),
    $checksum,
    'text matched',
);
