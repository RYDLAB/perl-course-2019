#!/usr/bin/env perl

use strict;
use warnings;
use Pod::Usage qw(pod2usage);

pod2usage( -verbose => 99 ) if -t STDIN;

my $letter = 'a-zA-Z';
my $str = <STDIN>;

my $answer;
my $re1 = qr/
    (?<!-) ([$letter]) [^$letter-]* ([$letter]) [^$letter-]* ([$letter]) (?!-)
    (??{
        $answer = "$1-$3";
        ord($1) - ord($2) == ord($2) - ord($3) && abs(ord($2) - ord($3)) == 1
        ? '(*ACCEPT)'
        : '(*FAIL)'
    })
/x;
my $re2 = qr/
    ([$letter])-([$letter]) [^$letter]* ([$letter]) (?!-)
    (??{
        $answer = "$1-$3";
        (ord($1) - ord($2))*(ord($2) - ord($3)) > 0 && abs(ord($2) - ord($3)) == 1
        ? '(*ACCEPT)'
        : '(*FAIL)'
    })
/x;
my $re3 = qr/
    ([$letter])-([$letter]) [^$letter]* ([$letter])-([$letter])
    (??{
        $answer = "$1-$4";
        (ord($1) - ord($2))*(ord($2) - ord($3)) > 0 && (ord($2) - ord($3))*(ord($3) - ord($4)) > 0 && abs(ord($2) - ord($3)) == 1
        ? '(*ACCEPT)'
        : '(*FAIL)'
    })
/x;

1 while $str =~ s/ (?| $re1 | $re2 | $re3 ) / $answer /xeg;

print $str;


my $comment=<<'big piece of C';
# perl is hard
#  viva la C

my $letter = qr/[a-z]/i;

my @data = split //, <>;
my $i = 0;

print $data[$i++] while $i<=$#data && $data[$i] !~ $letter;
exit(0) if $i>$#data;

my $first = $i;

search_second:
{
    1 while ++$i<=$#data && $data[$i] !~ $letter;
    print(@data[$first..$#data]), exit(0) if $i>$#data;

    my $second = $i;

    my $delta1 = ord($data[$first]) - ord($data[$second]);
    if(abs $delta1 != 1){
        print @data[$first..($second-1)];
        $first = $second;
        redo search_second
    }

    my $third_found = undef;
    search_third:
    {
        1 while ++$i<=$#data && $data[$i] !~ $letter;
        print($third_found ? ("$data[$first]-", @data[$second..$#data]) : @data[$first..$#data]), exit(0) if $i>$#data;

        my $third = $i;

        my $delta2 = ord($data[$second]) - ord($data[$third]);
        if($delta2 != $delta1){
            print $third_found ? ("$data[$first]-", @data[$second..($third-1)]) : @data[$first..($third-1)];
            $first = $third;
            redo search_second
        }

        $third_found = 1;
        $second = $third;
        redo search_third
    }
}
big piece of C

__END__
=pod

=encoding UTF-8

=head1 ИМЯ

range.pl

Принимает список английских букв с произвольным разделителем (или без него), и преобразует идущие подряд символы в диапазоны:

a b c d d c b a -> a-d d-a

xyz -> x-z

=head1 СИНТАКСИС

echo abc | ./range.pl
