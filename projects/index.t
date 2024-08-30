#include "doctype.t"
<head>
<title>Daniel Stenberg's Projects</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

#define LINK(url,name) <a href="url">name</a>

#define IMDEAD I no longer work on this.

TITLE(Projects)
BOXTOP
<p>
 Everyone always has lots of projects going on. So do I. Here's where I intend
 to collect pointers to new and old projects of mine. See also <a
href="/opensource.html">my open source projects</a>.

<table><tr valign="top"><td>

SUBTITLE(curl)
<p>
 I am the main author and maintainer of cURL and libcurl. I always spend a lot
of time reading and replying to LINK("http://curl.haxx.se/", curl), mails, as
well as fixing bugs and improve things.

#if 0
SUBTITLE(Rockbox)
<p>
 LINK("http://www.rockbox.org/", Rockbox) is a multi-platform open source
firmware for portable music players. See the Swedish magazine M3's <a
href="../m3.html">article about us</a>. IMDEAD
#endif

SUBTITLE(c-ares)
<p>

 LINK("http://c-ares.org/", c-ares) is an asynch name resolver library. I am a
project maintainer.

SUBTITLE(Roffit)
<p>
 I needed a man page to HTML converter tool that makes nice-looking web
pages. I found none I liked, so I wrote <a href="roffit/">roffit</a>.

SUBTITLE(portability)
<p>
 LINK("portability/", C code portability) is a subject I'm often involved in,
one way or another. This is my take at gathering and summarizing info about
it. IMDEAD

#if 0
SUBTITLE(ipwhere)
<p> <a href="ipwhere/">ipwhere</a> is a nifty tool that tells in what country
 and continent a given IP address resides. IMDEAD

SUBTITLE(trio)
<p>
 Portable and extendable printf and string functions: <a href="trio/">trio</a>!
#endif

</td><td>

#if 0
SUBTITLE(mail2sms)
<p>
 Convert a mail to a short plain-text: LINK("mail2sms/", mail2sms). IMDEAD

SUBTITLE(fcpp)
<p>
 An ANSI C preprocessor: LINK("fcpp/", fcpp)

SUBTITLE(dbestfit)
<p>
 LINK("dbestfit/", dbestfit) is a complete and stand-alone memory system
(malloc, realloc, free etc) replacement using a best-fit algorithm. IMDEAD

SUBTITLE(PVR)
<p>
 I and a few friends were gonna build ourselves a nice media computer/PVR. I
collected some details and bits <a href="pvr/">here</a>. IMDEAD
#endif

SUBTITLE(Subversion List Archives)
<p>
 I run a few web archives of some Subversion-related mailing lists:
 LINK("http://svn.haxx.se/", Subversion Mailing List Archives)

SUBTITLE(libssh2)
<p>
 I'm active in the LINK("http://www.libssh2.org/", libssh2) project
and I co-admin it.


</td></tr></table>

BOXBOT

TITLE(Idling or Simply Inactive in These Open Source Projects)
BOXTOP
<p>
These are projects that I have been participating in, but I haven't been doing
much lately or that I have abandoned completely:
<p>

LINK("http://www.rockbox.org/", Rockbox),
LINK("http://subversion.tigris.org/", subversion),
LINK("http://daniel.haxx.se/hypermail/", hypermail),
openpackages,
LINK("http://smash.sourceforge.net/", smash),
Dispair,
Blockspam,
LINK("http://dancer.sourceforge.net/", dancer),
LINK("http://libdenise.sourceforge.net/", denise),
LINK("/frexxed/", frexxed),
FPL,
LINK("http://spam.sourceforge.net/", spam.pl),
Netracer,
Triacle,
LINK("http://www.gnu.org/software/wget/wget.html", wget),
<a href="ipwhere/">ipwhere</a>,
<a href="trio/">trio</a>,
LINK("mail2sms/", mail2sms),
LINK("fcpp/", fcpp),
LINK("dbestfit/", dbestfit)

BOXBOT

#include "footer.t"

