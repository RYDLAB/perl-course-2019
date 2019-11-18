#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use FindBin qw ( $Bin );
use lib "$Bin/";

use Ant;

use constant {
    FIELD_SIZE  => 70,
    START_X     => 35,
    START_Y     => 35,
    START_DIR_X => 0,
    START_DIR_Y => 1,
    STEPS       => 9000,
};

my $ant = Ant->new(
    pos_x => START_X,
    pos_y => START_Y,
    dir_x => START_DIR_X,
    dir_y => START_DIR_Y,
);

my @field;
push @field, [ (-1) x ( FIELD_SIZE ) ] for 1 .. FIELD_SIZE;

$ant->travel(\@field, STEPS);

print join '', ( map { $_ == 1 ? '#' : '.' } @$_ ), "\n" foreach @field;
