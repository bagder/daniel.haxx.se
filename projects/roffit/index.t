#include "doctype.t"
#include "body.t"
#include "setup.t"

HEAD(roffit: converts man pages to HTML)
#include "daniel.t"

TITLE(roffit)
BOXTOP
<p>
 roffit converts input nroff man pages to output HTML pages.
<p>
 Example conversions (possibly not generated with the latest version):
<ul>
<li> the '<a href="http://curl.haxx.se/docs/manpage.html">curl</a>' man page
<li> the '<a href="http://curl.haxx.se/libcurl/c/curl_easy_setopt.html">curl_easy_setopt</a>' man page
</ul>

#if 0
<p>
 Random services hosted by:<br>

<a title="sourceforge.net" href="http://sourceforge.net/projects/roffit/"><img border="0" src="http://sourceforge.net/sflogo.php?group_id=202894&type=1"></a>

#endif

SUBTITLE(Download roffit)
<p>
 Get roffit directly from git, we don't have any recent download archives.

#if 0
<p>
<a href="roffit-0.6.tar.gz">roffit-0.6.tar.gz</a>, 5255 bytes (2004-feb-27)
<br><a href="roffit-0.5.tar.gz">roffit-0.5.tar.gz</a>, 4472 bytes (2004-feb-3)

#endif

SUBTITLE(Bug Reports)
<p>

 We use the <a href="https://github.com/bagder/roffit/issues">github issue
tracker</a>

SUBTITLE(source code)
<p>
 <a href="http://github.com/bagder/roffit">Browse git</a>
<p>
 Checkout from git:
<pre>
 $ git clone git://github.com/bagder/roffit.git
</pre>
<p>
 See further on <a href="http://github.com/bagder/roffit">github</a>.

SUBTITLE(Changelog)

<p>
 We do releases very seldom. Check the <a href="https://github.com/bagder/roffit/commits/master">commitlog</a> for the most recent changes.

#if 0
<p> 0.6
<ul>
 <li> added --mandir and --hrefdir that generates nice cross-manpage links
 <li> made it convert http:// URLs to &lt;a href&gt; links
 <li> added --version
</ul>
<p> 0.5
<ul>
 <li> Added support for more &amp;-combos
 <li> Better treatment of .nf to make &lt;pre&gt; sections, and we now do newlines
   better within such a &lt;pre&gt; section
 <li> .IR is now treated equally as .I
 <li> keywords and their data can be tab-separated
 <li> .SS is now treated as .SH
</ul>
<p> 0.4
<ul>
<li> now deals with help2man man pages better
<li> added man page
</ul>
#endif

BOXBOT

#include "footer.t"

