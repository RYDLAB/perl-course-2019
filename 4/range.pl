use strict;
use warnings;
use Pod::Usage qw(pod2usage);

pod2usage( -verbose => 99 ) if -t STDIN;

my $letter = 'a-zA-Z';
my $str = <>;

my $strold = "";
my $flag = 1;

while($flag){
	$str =~ s/([$letter])[^$letter]*([$letter])[^$letter]*([$letter])/
		ord($1) - ord($2) == ord($2) - ord($3) && abs(ord($2) - ord($3)) == 1 ? "$1-$3" : $&/eg;
	$flag = 0 if $strold eq $str;
	$strold = $str;
}

$strold = "";
$flag = 1;

while($flag){
	$str =~ s/([$letter])-([$letter])([$letter])/
		abs(ord($2)-ord($3)) == 1? "$1-$3" : $&/eg;
	$flag = 0 if $strold eq $str;
	$strold = $str;
}

$strold = "";
$flag = 1;

while($flag){
	$str =~ s/-[$letter]-/-/g;
	$flag = 0 if $strold eq $str;
	$strold = $str;
}

$str =~ s/([$letter])([$letter])/$1,$2/g;

print "$str";
