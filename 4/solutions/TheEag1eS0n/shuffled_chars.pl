#!/usr/bin/env perl

use strict;
use warnings;

use Pod::Usage qw(pod2usage);

my $file_name = pop @ARGV;

pod2usage( -verbose => 99 ) unless defined $file_name;

binmode STDOUT, ':utf8';

open(my $file, '<encoding(UTF-8)', $file_name) or die "Can`t open $file_name: $!";
s/(\w)(\w+)(\w)/$1.(reverse $2).$3/eg, print while <$file>;

close $file;
