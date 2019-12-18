my $str = "MXVW#DQRWKHU#SHUO#KDFNHU";
for my $i(0..length($str)){
	print chr(ord(substr($str, $i, 1)) - 3);
}

