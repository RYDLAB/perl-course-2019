#!/usr/bin/env perl
use Mojolicious::Lite;

open my $fh, '<', $0;
my $file_content = do { local $/; <$fh> };
get $0 =~ /([^\/]+)$/ => sub {
    shift->render(text => $file_content, format => 'txt');
};
app->start;
