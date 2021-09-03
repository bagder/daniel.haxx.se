#include "doctype.t"
<head>
<title>dbestfit: Best-Fit Memory Allocation</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>

#define DBESTFIT_MAIN

#include "body.t"
#include "setup.t"
#include "daniel.t"
#include "menu.t"

TITLE(dbestfit: Best-Fit Memory Allocation)
BOXTOP

<p> dbestfit is a complete and fast malloc-replacement that features a
 best-fit algoritm with special small-block treatment, to maximize memory
 usage. This is particularly suitable for embedded systems.

<p> dbestfit has been used to replace the pSOS-provided malloc system several
 times. dbestfit performs a magnitude faster and of course doesn't force a
 task switch when used - and it doesn't fragment the memory as much. But this
 code is not pSOS-specific.

<p>
 CVS and other services hosted by:<br>

<a title="sourceforge.net" href="http://sourceforge.net/projects/dbestfit/"><img border="0" src="http://sourceforge.net/sflogo.php?group_id=202924&type=1"></a>

SUBTITLE(Download)
<p> <a href="dbestfit-3.3.tar.gz">dbestfit 3.3</a> 19KB

SUBTITLE(Feedback - Improvements - Bug reports)
<p> Please email them to me to the address as shown in the web page footer. In
 case of interest I'll start a mailing list.

SUBTITLE(Changelog)
<p> 3.3
<ul>
 <li> Updated, works fine!
</ul>
<p> 3.2
<ul>
 <li> Written a long time ago, never actually proven in real life, even if
      dmalloc() (for the small parts) has.
</ul>

BOXBOT

#include "footer.t"

