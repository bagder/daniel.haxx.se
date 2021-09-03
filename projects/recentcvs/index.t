#include "doctype.t"
#include "setup.t"
HEAD(recentcvs)
#include "body.t"
#include "daniel.t"

<p>
TITLE(RecentCVS)
BOXTOP

This package contains scripts with 2 functions:
<ol>
<li> one script fetches the most recent actions in a CVS repository and
  displays a little HTML table with it. Useful to allow many people to browse
  CVS activity in very active projects.
<li> one script gets the changes done in the last 24 hours and produce
  an ASCII-file with all the changes, fine to accompany daily builds etc.
</ol>

<p>
 These scripts have been developed and used extensively within the <a
href="http://rockbox.haxx.se/">Rockbox</a> and <a
href="http://curl.haxx.se/">curl</a> projects.

<p>
 Download <a href="recentcvs-1.1.tar.gz">recentcvs version 1.1</a> (5KB)
<p>
 Download <a href="recentcvs-1.0.tar.gz">recentcvs version 1.0</a>
<p>
 Please mail me any improvements you make!
BOXBOT

#include "footer.t"
