#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use Mojo::UserAgent;
use FindBin qw($Bin);
use Crypt::CBC;

my $ua = Mojo::UserAgent->new;

$ua->max_redirects(5)
    ->get('https://github.com/toshikFedotov/coin-exchange/raw/master/donotopenit.hack')
    ->result->save_to($Bin . '/D0N0t0p3nit.H@ck');

my $cipher = Crypt::CBC->new(
    -key => 'p3r1h@c|<er',
    -salt => 'tatysh00'
);

open (my $fh, '<', 'D0N0t0p3nit.H@ck');
$cipher->start('D');

my $message = '';

while (<$fh>) {
    $_ = $cipher->crypt($_);
    $message .= $_;
}

$cipher->finish();
close ($fh);

while ($message =~ /\d\d/g) {
    print chr($&);
}
say "\n";

unlink glob 'D0N0t0p3nit.H@ck';
