#!/usr/bin/perl
#
# Copyright (C) 2002, Daniel Stenberg, <daniel@haxx.se>
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution.
# 
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#

# Example output ("# " prefixed lines):

# RCS file: /cvsroot/rockbox/apps/credits.c,v
# Working file: apps/credits.c
# head: 1.4
# branch:
# locks: strict
# access list:
# symbolic names:
# keyword substitution: kv
# total revisions: 4;	selected revisions: 1
# description:
# ----------------------------
# revision 1.4
# date: 2002/05/28 12:10:12;  author: zagor;  state: Exp;  lines: +3 -3
# Adapted to modified button_get() call
# =============================================================================

my @out;

my $file;
my $change=0; # state
while(<STDIN>) {
    my $line = $_;
    if(!$change) {
        if($line =~ /^Working file: (.*)/) {
            $file = $1;
        }
        elsif($line =~ /^----------------------------/) {
            $change=1;
            push @files, $file;
        }
    }
    else {
        if($line =~ /^=============================================================================/) {
            $change = 0; # no more changes
        }
        else {
            $log{$file} .= $line;
        }
    }

}

sub singlechange {
    my ($num, $file, $rev, $date, $author, $lines, @comment) = @_;
    my $count=0;

    if(!$num) {
        push @out, "\n===[ $file ]===\n";
    }
    push @out, "  $rev ($author) ";
    for(@comment) {
        if($count) {
            push @out, "               ";
        }
        push @out, "$_\n";
        $count++;
    }
}

my $firsttime;
my $firstval;

my $lasttime;
my $lastval;
sub datemonger {
    my ($date)=@_;

    if($date =~ /(\d\d\d\d)\/(\d\d)\/(\d\d) (\d\d):(\d\d):(\d\d)/) {
        my ($year, $month, $day, $hour, $min, $sec)=($1,$2,$3,$4,$5,$6);

        my $val = $sec + $min*60+$hour*3600+ $day*3600*24 +
            $month*31*24*3600 + $year*366*24*2600;

        if($val > $lastval) {
            $lastval = $val;
            $lasttime = $date;
        }
        if(!$firstval || ($val < $firstval)) {
            $firstval = $val;
            $firsttime = $date;
        }
    }
}

sub showlog {
    my ($file, $log) = @_;
    my @log = split("\n", $log);

    my ($rev, $date, $author, $lines, @comment);
    my $num=0;
    for(@log) {
        $line = $_;
        
        if($line =~ /^revision (.*)/) {
            $rev = $1;
        }
        elsif($line =~ /^date: ([^;]*);  author: ([^;]*);  state: ([^;]*);(.*)/) {
            ($date, $author)=($1,$2);

            if($4 =~ /lines: (.*)/) {
                $lines = $1;
            }

            datemonger($date);
        }
        elsif($line =~ /^----------------------------/) {
            # multiple commit separator
            singlechange($num, $file, $rev, $date, $author, $lines, @comment);
            $num++; # count changes done to this single file
            $changecount++; # count total changes
            undef $rev, $date, $author, $lines;
            undef @comment;
        }
        else {
            push @comment, $line;
        }
    }
    singlechange($num, $file, $rev, $date, $author, $lines, @comment);
    $changecount++; # count total changes
}

for(@files) {
    if($_ =~ /^www/) {
        # ignore changes to this module
        next;
    }
    else {
        $changefiles++;
        showlog($_, $log{$_});
    }
}

if( $changecount) {
    print "First change:      $firsttime (GMT)\n",
    "Last change:       $lasttime (GMT)\n",
    "Files changed:     $changefiles\n",
    "Number of changes: $changecount\n";
    for(@out) {
        print "$_";
    }
}
else {
    print "No changes\n";
}
