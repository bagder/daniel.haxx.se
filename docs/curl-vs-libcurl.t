#include "doctype.t"
#include "setup.t"
HEAD(curl vs libcurl)
#include "body.t"
#include "daniel.t"

Related: <a href="ftp-vs-http.html">FTP vs HTTP</a>,
 <a href="bittorrent-vs-http.html">bittorrent vs HTTP</a> and
 <a href="curl-vs-wget.html">curl vs Wget</a>
<p>
TITLE(curl vs libcurl)
BOXTOP
<p>
 Differences between curl and libcurl.

SUBTITLE(The different curls)
<p>
 The word 'curl' currently stands for about three different things (that is
 related to this subject), and I'll explain them in the order I think makes
 sense.

<ul>

<li> <b>curl</b> is a <a href="http://curl.haxx.se/">command line
  tool</a>. You run it from a shell command line or from within shell scripts
  or batch files. curl is made to transfer files to and from servers "on the
  internet" using any of the large amount of protocols curl supports. curl has
  existed since 1998 and offers more than one hundred command line options to
  control it.

<li> <b>cURL</b> (using one lowercase and three uppercase letters) is the name
  of a <a href="http://curl.haxx.se/">software project</a>. This project
  produces two different "things". The curl tool and the <a
  href="http://curl.haxx.se/libcurl/">libcurl library</a>, both being open
  source.

<li> <b>CURL</b> is usually used as a name for the libcurl binding for
 PHP. This binding is what PHP users to access libcurl functions from within
 their PHP programs. Some PHP programs even say they use 'libcurl' when they
 in fact use this binding. In the cURL project, we try to refer to the PHP
 binding as <a href="http://curl.haxx.se/libcurl/php/">PHP/CURL</a> to make a
 clear distinction.

</ul>

SUBTITLE(curl - the command line tool)
<ul>
 <li> command line tool, you run it from a shell prompt or within a script
 <li> offers more than 230 different command line options
 <li> often scripted to simulate browsers etc
 <li> provided for most operating systems
</ul>

SUBTITLE(libcurl - the library)

<ul>
 <li> development library for use in other programs
 <li> used by many bindings for just about any language to can think of
 <li> compiles and runs on just about all operating systems
 <li> offers several different APIs and ways to use it
</ul>

#if 0
SUBTITLE(Thanks)
<p>
  Feedback and improvements by: Micah Cowan, Olemis Lang

SUBTITLE(Updates)
<p>
<ul>
<li> Apr 2010 - added more protocols, and corrected the SSL library count. Minor language fix.
</ul>

#endif

BOXBOT
<p>
Updated: __TODAY__ __NOW__ (Central European, Stockholm Sweden)

#include "footer.t"

