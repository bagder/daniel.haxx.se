
# background colour of the page
$bgcolor="#ffffff";

$folderimg="/icons/folder.gif";
$fileimg="/icons/generic.gif";
$parentdirimg="/icons/back.gif";

# regex => image
# image may be 'undef' to prevent using an image
%filetypeimg=( '\.[ch]$' => '/icons/c.gif',
               '\.htm(l|)$' => '/icons/layout.gif',
               '\.p(l|m)$'   => '/icons/p.gif',
               '\.sh$'   => '/icons/script.gif',
               '\.(png|gif|jpg)$' => '/icons/image2.gif',
               '\.txt$' => '/icons/text.gif',
               'README' => '/icons/hand.right.gif');

# when selecting a single file, we send content-type text/plain by
# default or else we use types as the following list defines
%filetypes=(   '\.htm(l|)$' => 'text/html',
               '\.jpg$'     => 'image/jpeg',
               '\.gif$'     => 'image/gif',
               '\.png$'     => 'image/png');

# the colours to use in index listings, must be at
# least one colour
@linecolors=("#ffffff",
             "#cccccc");

# text to display on top of every page dispair shows
@tophtml=("<a href=\"/~dast/mail2sms/\">back to mail2sms</a>");

# this text is displayed under the tophtml on the first (entry) page
# of an archive
@firsthtml=("<p> Browse the archive by clicking the links...");

# text to display at the bottom of every page dispair shows
@bothtml=("<hr><p> Archive browsed with <a href=\"http://www.contactor.se/~dast/dispair/\">dispair</a> by Daniel Stenberg.");

# where to find a recent gnu tar executable
$gtar="/home/dast/public_html/dispair/tar";

# Set up the PATH to include 'gzip'
$ENV{'PATH'}.=":/usr/gnu/bin/";

# set if the file list should include size+date by default
$includedata=0;

# set number of columns to be attempted, without and with
# 'includedata'
@usecolumns=(4, 2);

# the least number of lines in the left-most column
$leftcolumn=10;

# what dir the tar.gz-files are located in, relative the cgi
# . being current
$filedir="../stuff";

1;
