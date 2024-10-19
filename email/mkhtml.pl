#!/usr/bin/perl

my $n = $ENV{'NEXT'};
my $p = $ENV{'PREV'};

# read the email on stdin
my $email;
while(<STDIN>) {
    my $l = $_;
    if(length($l) < 2) {
        $l = "&nbsp\n";
    }
    if($l =~ /^<h2.*links/i) {
        last;
    }
    $email .= "${l}";
}

open(E, "<emailtemplate.t");
while(<E>) {
    my $l = $_;
    $l =~ s/%EMAIL%/$email/;
    $l =~ s/%PREV%/$p/;
    $l =~ s/%NEXT%/$n/;
    print $l;
}
close(E);
