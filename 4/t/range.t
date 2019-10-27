#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 4;
use FindBin qw( $Bin );

my $out = `echo 'abcde' | perl -wMstrict '$Bin/../range.pl' 2>&1`;

is(
    $out,
    "a-e\n",
);

$out = `echo 'edcba' | perl -wMstrict '$Bin/../range.pl' 2>&1`;

is(
    $out,
    "e-a\n",
);

$out = `echo 'a,b,c,c,b,a' | perl -wMstrict '$Bin/../range.pl' 2>&1`;

is(
    $out,
    "a-c,c-a\n",
);


$out = `echo 'a,b,a,b,b,a' | perl -wMstrict '$Bin/../range.pl' 2>&1`;

is(
    $out,
    "a,b,a,b,b,a\n",
);
