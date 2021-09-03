#!/usr/bin/perl

open(W, "<weekly-episodes.txt");
my $max=0;
while(<W>) {
    if(/^([^ ]*) (\d+)/) {
        my ($id, $num)=($1, $2);
        $ep[$num]=$id;
        if($num > $max) {
            $max = $num;
        }
    }
}

my $id = $ep[$max];
        print <<MOO
<iframe width="1280" height="720" src="https://www.youtube.com/embed/$id" frameborder="0" allowfullscreen></iframe>

<h2>12 earlier episodes</h2>
MOO
;


for my $i (0 .. 11) {
    my $num = $max -$i-1;
    my $id = $ep[$num];
        print <<MOO
 <iframe width="300" height="169" src="https://www.youtube.com/embed/$id" frameborder="0" allowfullscreen></iframe>
MOO
;

    }
