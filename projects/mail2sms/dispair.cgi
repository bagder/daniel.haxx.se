#!/usr/bin/perl
#
# Copyright (C) 2000 Daniel Stenberg <daniel@haxx.se>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE AUTHORS AND
# CONTRIBUTORS ACCEPT NO RESPONSIBILITY IN ANY CONCEIVABLE MANNER.
#

require "CGI.pm";

use dispair;

$version ="0.2";

sub nicesize {
    my $insize = $_[0];

    if($insize < 50000) {
        return "$insize bytes";
    }
    if($insize < 5000000) {
        return sprintf("%.1fKB", $insize/1024);
    }
    return sprintf("%.1fMB", $insize/(1024*1024));
}

$req = new CGI;

$workfile = $req->param('file');

sub displaysingle {
    my $usetype="text/plain";
    for(keys %filetypes) {
        if($workview =~ /$_/) {
            $usetype = $filetypes{$_};
        }
    }
    print "Content-Type: $usetype\n\n";
    
    open(TAR, "$gtar -Oxzf $realfile $workview|");
    while(<TAR>) {
        print "$_";
    }
    close(TAR);
}

if($workfile =~ /(.*)\/(.*)/) {
    # cut off directories
    $workfile=$2;
    $workfilepath=$1;
}
$realfile="$filedir/$workfile";

$workdir = $req->param('dir');
$workview = $req->param('view');
$workdetails = $req->param('detail');

if($workview ne "") {
    # One single particular file has been selected
    &displaysingle();
    exit;
}

print "Content-Type: text/html\n\n";
print "<head><title>Dispair $version: $workfile</title></head>\n";
print "<body bgcolor=\"$bgcolor\">\n";

if($illegal) {
    print "<b>bad fiddling detected</h2>";
    exit;
}

if($workdetails eq "no") {
    $includedata = 0;
}
elsif($workdetails eq "yes") {
    $includedata = 1;
}
$workdetails=$includedata?"yes":"no";

#print "Input file: $workfile<br>\n";
#print "Show dir: $workdir<br>\n";
#print "View file: $workview<br>\n";


# (GNU tar) 1.13.11

# drwxr-xr-x tri/operator      0 1999-05-12 13:20:06 ssh-1.2.27/
# -rw-r--r-- tri/operator  16879 1999-05-12 13:18:50 ssh-1.2.27/COPYING
# -rw-r--r-- tri/operator  11504 1996-10-30 00:01:54 ssh-1.2.27/gmp-2.0.2-ssh-2/PROJECTS

# GNU tar version 1.10

# -rw-r----- dast/0  1325 Sep 16 11:03 1994 cpp-1.5/FPPBase.h


$title=$workdir;
print @tophtml;

if($workdir eq "") {
    print @firsthtml;
}

print "<h2>$workfile/$title</h2>";

if($workdir ne "") {
    @parts=split("\/", $workdir);
    $parts[$#parts]="";
    $parent = join("\/", @parts);
    if($parentdirimg) {
        print "<img src=\"$parentdirimg\"> ";
    }
    print "<a href=\"dispair.cgi?file=$workfile&dir=$parent&detail=$workdetails\">parent dir</a> ($parent)\n";
}

open(TAR, "$gtar -vtzf $realfile |");

for(<TAR>) {
    if($_ =~ /([^ ]+) ([^\/]+)\/([^ ]+) *(\d+) (\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) (.*)/) {
        $mode = $1;
        $user = $2;
        $group = $3;
        $size = $4;
        $date = $5;
        $time = $6;
        $file = $7;
    }
    elsif($_ =~ /([^ ]+) ([^\/]+)\/([^ ]+) *(\d+) (\w\w\w *\d+) (\d\d:\d\d) (\d\d\d\d) (.*)/) {
        $mode = $1;
        $user = $2;
        $group = $3;
        $size = $4;
        $date = $5." ".$7;
        $time = $6;
        $file = $8;
       
    }
    else {
        # unrecognized line format!
        print "<pre>\n",
        "$_",
        "</pre>\n";
        next;
    }
    $present=0;
    if($file =~ s/^$workdir//g) {
        # yes, this file is present in this dir
        $present=1;
    }
    else {
        # print "<br> [HIDDEN] ";
    }
    
    if($file =~ /^([^\/]+\/).+/) {
        # print "<br> [DEEPER] ($workdir) $mode $file\n";
    #    $atleast=$1;
    }
    else {
        if($file =~ /^([^\/]+\/$)/ ) {
            $newdir=$workdir.$1;
        }

           if(($file ne "") && $present) {

               $info{$file, "n"}=$newdir; # for the dirs
               $info{$file, "m"}=$mode;
               $info{$file, "u"}=$user;
               $info{$file, "g"}=$group;
               $info{$file, "s"}=$size;
               $info{$file, "d"}=$date;
               $info{$file, "t"}=$time;

               if($mode =~ /^d/) {
                   push @dentries, $file;
               }
               else {
                   push @fentries, $file;
               }
           }
       }

    }

    close(TAR);

    if(($dentries[0] eq "") &&
       ($atleast ne "")) {
        push @dentries, $atleast;
        $info{$atleast, "n"}=$atleast;
        $info{$atleast, "m"}="d-----"; # fake directory mode
    }

    @fentries = sort { $a cmp $b} @fentries;
    @dentries = sort { $a cmp $b} @dentries;

    # switch order if the directories should come last
    @all = (@dentries, @fentries);

    if($all[0] ne "") {
        $totalentries=$#all+1;
    }
    else {
        $totalentries=0;
    }

    $usecolumns=$usecolumns[$includedata];
    if($usecolumns && ($totalentries > $leftcolumn)) {
        if($totalentries/$leftcolumn > $usecolumns) {
            # it would make too many columns, raise the amount
            # of entries per column
            $leftcolumn = $totalentries/$usecolumns;
        }
    }
    else {
        $usecolumns=0; # switch off, too few entries
    }

    $colorindex=0;
    $linespercol=0;

    $table=0;
    if($usecolumns) {
        # all columns table
        print "<!-- master table start -->\n";
        print "<table><tr><td valign=top>\n";
        $table++;
    }

    # one column table
    print "<!-- single col table start -->\n";
    print "<table cellspacing=0 cellpadding=2>\n";

    $table++;

    for(@all) {

        print "<tr bgcolor=\"".$linecolors[$colorindex]."\">\n";

        $colorindex++;
        if($colorindex > $#linecolors) {
            $colorindex=0;
        }

        $file = $_;

        if($info{$_,"m"} =~ /^d/) {
            $newdir = $info{$_, "n"};
            if($folderimg) {
                print "<td><img src=\"$folderimg\"></td>\n";
            }
            else {
                print "<td>DIR</td>\n";
            }
            print "<td><tt><a href=\"dispair.cgi?file=$workfile&dir=$newdir&detail=$workdetails\">$file</a></tt></td>\n";
            
            if($includedata) {
                print "<td colspan=2><i>directory</i></td>";
            }

        }
        else {
            $useimg = $fileimg; # default image
            for(keys %filetypeimg) {
                if($file =~ /$_/) {
                    $useimg = $filetypeimg{$_};
                }
            }

            if($useimg) {
                print "<td><img src=\"$useimg\"></td>\n";
            }
            else {
                print "<td>FILE</td>\n";
            }
            print "<td><tt><a href=\"dispair.cgi?file=$workfile&dir=$workdir&view=$workdir$file\">$file</a></tt></td>\n";

            if($includedata) {
                print "<td align=right>".&nicesize($info{$_, "s"})."</td>\n";
                print "<td>".$info{$_, "d"}." ".$info{$_, "t"}."</td>\n";
            }
        }

        print "</tr>\n";

        $linespercol++;
        if($usecolumns && ($linespercol > $leftcolumn)) {
            print "<!-- single col table end -->\n";
            print "</table>\n"; # end of column table
            
            print "<!-- new col cell start -->\n";
            print "</td><td valign=top>\n"; # new column in master table
            # print "<tr><td></td><td> <b>column break</b></td></tr>\n";
            # next column table coming up!

            print "<!-- new col table start -->\n";
            print "<table cellspacing=0 cellpadding=2>\n";
            $linespercol =0;
        }

    }
    # end of single table OR all-columns table!
    # close all open tab
    if($usecolumns) {
        print "<!-- end of master table TR -->\n";
        print "</td></tr>\n"; # close the master TR line
    }
    while($table) {
        print "</table>\n";
        $table--;
    }

print "<p> <small>Download archive: <a href=\"$realfile\">$workfile</a></small>\n";
print "<form action=\"dispair.cgi\" method=\"GET\">\n";
print "<input type=hidden name=file value=\"$workfile\">\n";
print "<input type=hidden name=dir value=\"$workdir\">\n";
if($includedata) {
    print "<input type=hidden name=detail value=\"no\">\n";
    print "<input type=submit name=show value=\"hide details\">\n";
}
else {
    print "<input type=hidden name=detail value=\"yes\">\n";
    print "<input type=submit name=show value=\"show details\">\n";
}
print "</form>\n";



print @bothtml;

