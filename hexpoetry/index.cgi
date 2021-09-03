#!/usr/bin/perl

require "CGI.pm";

$req = new CGI;

$download = $req->param('download');

$poetry = $req->param('poetry');

$strict=$req->param('strictness');

if($strict eq "") {
    $strict=1; # default to 1
}

if(!$poetry || ($poetry eq "\r\n")) {
    $poetry = join("\r\n",
                   ("a bad cool deaf dood",
                    "a celeb feed cod",
                    "blab dead fled food",
                    "beef bleed blood"));
}

if(!$download) {
    print <<EOM
Content-Type: text/html

<head><title>haxx hex poetry</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<p class=title>Hex Poetry</p>
<p>
Don't ask why, just do it. This generates a hexadecimal output!
<p>
Fill in your poetry below. Set strictness below. <a href="words.cgi">A list of possible words</a> and some <a href="goodies.html">goodies</a>.<p>

EOM
        ;

print <<FORM
<form name=poetry method="POST" action="./">
<textarea name=poetry cols=60 rows=8>
$poetry
</textarea>
<br>
Strictness: <select name=strictness>
FORM
;
@opts=("Pure hex, 0-9, A-F",
       "Less clean, 0-9, A-F, I, L, O",
       "Hex Craze, 0-9, A-G, I, G, L, O, S, T, Z");
$num=0;
for(@opts) {
printf("<option value=$num%s>$_</option>",
($num == $strict)?" selected":"");
$num++;
}
print <<FORM
</select>
<br>
<input type=submit value="Show Me Hex">
<input type=submit value="Download Binary" name=download>
</form>

FORM
        ;

print "<p>The output is <i>almost</i> od -x...  <p><table class=grey><tr><td><pre>\n";
}
else {
  print "Content-Type: application/octet-stream\n\n";
}

@weallow=("abcdef0123456789",
        "abcdefilo0123456789",
        "abcdefiglostz0123456789");

$allow=$weallow[$strict];

@poetry=split("\r\n", $poetry);
for(@poetry) {
    s/[\r\n ]//g; # strip off CRs and LFs and spaces
    tr/[A-Z]/[a-z]/; # lowercase

    $cut += length($_);

    s/[^$allow]//g; # cut off unknown letters

    $cut -= length($_);

    tr/oligstz/0116572/; # conversions

    $len = length($_);

    if($len && !$download) {
        printf("%08x ", $index);
    }
    for($i=0; $i< $len; $i++) {
        $ch = substr($_, $i, 1);
        $num = ord($ch);

        $num -= ord('0');
        if($num > 9) {
            $num = ord($ch)-ord('a')+10;
        }

    #    printf("$ch %02x\n", $num);

        if($hi) {
            $res = ($res << 4) | $num;
            $hi = 0;
      #      printf("$ch (0x%02x)", $res);
            if($download) {
                printf("%c", $res);
            }
            else {
                printf("%02x ", $res);
            }
            
        }
        else {
            $hi = 1;
            $res = $num;
        }
    }
    $index += $len;
    if($hi) {
        if($download) {
            printf("%c", $res<<4);
        }
        else {
            printf("%01x0", $res);
        }
        $hi = 0;
    }
    if($len && !$download) {
        print "\n";
    }

}
if(!$download) {
    print "</pre></td></tr></table>\n";
    
    if($cut) {
        print "<p> $cut illegal letters were cut off\n";
    }

    print "<p class=address>daniel at haxx dot se</p></body>\n";
}
