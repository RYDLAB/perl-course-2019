#!/usr/bin/env perl
use Mojolicious::Lite;

open my $fh, '<', $0;
my $code = do { local $/; <$fh> };
get $0 =~ /([^\/]+)$/ => sub { shift->render(text => $code); };
app->start;
