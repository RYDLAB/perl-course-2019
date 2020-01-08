my $str = "MXVW#DQRWKHU#SHUO#KDFNHU";
for my $i(0..length($str)-1){
	print chr(ord(substr($str, $i, 1)) - 3);
}

