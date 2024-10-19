#!/usr/bin/perl

# where to find them
my $emails="emails";
my $index = $ARGV[0];
my $makefile = $ARGV[1];
my $outputs = $ARGV[2];

sub fentries {
    my ($d)= @_;
    opendir(my $dh, $d) || die "Can't opendir $emails: $!";
    my @f = grep { /^\d\d\d\d-.*.md\z/ && -f "$d/$_" } readdir($dh);
    closedir $dh;
    return @f;
}

opendir(my $dh, $emails) || die "Can't opendir $emails: $!";
my @years = grep { /^\d\d\d\d/ && -d "$emails/$_" } readdir($dh);
closedir $dh;

for my $y (sort @years) {
    my @f = fentries("$emails/$y");
    for my $f (sort @f) {
        push @a, "$y/$f";
    }
}

sub md2html {
    my ($f) = @_;
    $f =~ s:(.*)/::; # cut off to the last slash
    $f =~ s/\.md\z/.html/;
    return $f;
}

sub fixup {
    my ($i) = @_;
    my $f = $a[$i];
    my @n;
    my $blank;
    my $title;
    open(F, "<$emails/$f");
    while(<F>) {
        chomp;
        if(/^# (.*)/ && !$title) {
            $name{$f} = $1;
            $title = 1;
        }
        if(/^## Links/) {
            last;
        }
        push @n, "$_\n";
        $blank = length($_);
    }
    close(F);
    if($blank) {
        push @n, "\n";
    }
}


for $i (0 .. $#a) {
    fixup($i);
}

sub dateit {
    my ($path) = @_;
    # remove the leading year dir
    $path =~ s/\d\d\d\d\///;
    # remove the extension
    $path =~ s/\.md\z//;
    # remove letters (like 'b')
    $path =~ s/[a-z]//g;
    return $path;
}

open(INDEX, ">$index");

print INDEX <<HEAD
<table>

<tr>
<th>num</th>
<th>name</th>
<th>date</th>
</tr>
HEAD
    ;
for $i (0 .. $#a) {
    my $f = $a[$i];
    printf INDEX "<tr class=\"%s\"><td>%d</td><td><a href=\"%s\">%s</a></td><td>%s</td></tr>\n",
        $i & 1 ? "even" : "odd",
        $i + 1,  md2html($f), $name{$f}, dateit($f);
}

print INDEX <<HEAD
</table>
HEAD
    ;

close(INDEX);

open(MAKE, ">$makefile");

my @outputs;
for $i (0 .. $#a) {
    my $f = $a[$i];
    my $n = md2html($a[$i+1]);
    if(!$n) {
        # make the last point back to the first
        $n = md2html($a[0]);
    }
    my $p = md2html($a[$i-1]);
    printf MAKE "%s: $emails/%s \$(MAINPARTS) $index \$(EMAILDEP)\n\t\$(MARKDOWN) \$< | env NEXT=%s PREV=%s \$(EMAIL2HTML)\n",
        md2html($f), $f, $n, $p;
    push @outputs, md2html($f);
}

close(MAKE);

open(OUT, ">$outputs");

print OUT "EMAILS = ";
for my $o (@outputs) {
    print OUT "$o ";
}

print OUT "\n";
close(OUT);
