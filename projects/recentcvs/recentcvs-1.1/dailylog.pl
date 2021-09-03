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

$time=time();
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
 localtime($time);
$mon+=1;
$year+=1900;

$date=sprintf("%04d%02d%02d", $year,$mon, $mday);
$dateto=sprintf("%04d-%02d-%02d 06:00", $year,$mon, $mday);

$time = time() - 24*3600; # yesterday
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
    localtime($time);
$mon+=1;
$year+=1900;

$datefrom=sprintf("%04d-%02d-%02d 06:00", $year,$mon, $mday);

`cvs -Q log -d "$datefrom<$dateto" | ./cvslogreport.pl > daily-build/changes-$date.txt`;


