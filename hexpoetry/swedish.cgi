#!/usr/bin/perl

print <<EOM
Content-Type: text/html

<head><title>haxx hex poetry: words</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<small><a href="./">back to main page</a></small>
<p class=title>A Bunch Of Possible Swedish Words To Use</p>
<p>
 Here's an incomplete list with more than 200 <b>swedish</b> words you can use:
<p>
EOM
        ;

open(WORDS, "<swewords.txt");
while(<WORDS>) {
    chomp;
    if(/^[abcdefilo0123456789]*$/) {
        print "$_ \n";
    }
}
close(WORDS);

print <<BOT
<p class=address>daniel at haxx dot se</p></body>
BOT
;
