#!/usr/bin/env perl

use feature 'postderef';
use Test::More tests => 2;

use FindBin qw( $Bin );

use lib "$Bin/../";

my $test_dir = "$Bin/dir2test";

use MyTree qw ( tree_size tree_size_i tree );

subtest 'tree_size()' => sub {
    is(
        tree_size($test_dir),
        516,
    );
    is(
        tree_size("$test_dir/a/512b"),
        512,
    );
    is(
        tree_size("$test_dir/a/b/c/d/f"),
        2,
    );

};

subtest 'tree()' => sub {
    is(
        tree("$test_dir/a/b/b1/b2/f"),
        2,
    );

    is_deeply(
        tree("$test_dir/a/b/b1/b2/"),
        { f => 2 },
    );

    is_deeply(
        tree("$test_dir/"),
        {
            a => {
                '512b' => 512,
                b      => {
                    c  => { d  => { f => 2 } },
                    b1 => { b2 => { f => 2 } },
                },
            },
        },
    );
};
