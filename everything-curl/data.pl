#!/usr/bin/perl

use POSIX 'strftime';

for my $a (@ARGV) {
    my $f = $a;
    $a =~ s/[-.]/_/g;
    $a = uc($a);

    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks)
        = stat($f);

    printf "#define ${a}_MB %.2f\n", $size/(1024*1024);

    my @t = gmtime $mtime;
    $d = strftime('%Y-%m-%d %H:%M UTC', @t);
    printf "#define ${a}_STAMP %s\n", $d;
    print "\n";
}
