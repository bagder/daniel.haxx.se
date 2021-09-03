#include "doctype.t"
<head>
<title>ipwhere: converts IP address to country and continent</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

TITLE(ipwhere)
BOXTOP
<p>

<i>ipwhere</i> is a command line tool that takes a single IPv4 dotted
 numerical address as argument, and shows in what country and continent that
 IP address lives. The output is <i>instant</i> since the command has the full
 translation table (covering more than 104,000 IP ranges holding some 850,000
 addresses) built-in and does blazingly fast binary searches in it.

<p> Now also hosted on <a
 href="http://sourceforge.net/projects/ipwhere">sourceforge</a>. Go there to
 get the latest code off <a
 href="http://sourceforge.net/svn/?group_id=225004">SVN</a>.

<p><big>
 This wouldn't exist without the wonderful service of <a
href="http://hostip.info/">hostip.info</a>.</big>

<p>
 License: MIT-style.

<p>
 Nov 9, 2005. This is brand new. If you provide feedback it might get better.

<p>
 <a href="ipwhere.tar.bz2">ipwhere.tar.bz2</a> (8KB)

<p> To keep this tool useful, you must update the data and rebuild the tool at
 a fair interval.

SUBTITLE(Requirements)
<p>
 To build this tool, it requires:
<ul>
<li> that you download a couple of hundred megabytes of data from hostip.info
 (see README in the package)
<li> have 'sort' and 'perl' installed
</ul>

BOXBOT

#include "footer.t"

