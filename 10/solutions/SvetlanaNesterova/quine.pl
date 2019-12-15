#!/usr/bin/env perl
use Mojolicious::Lite;
use File::Slurp;
use File::Basename;

my $text = read_file($0);
get basename($0) => sub {
    shift->render(text => $text);
};
app->start;
