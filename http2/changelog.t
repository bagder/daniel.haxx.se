#include "doctype.t"
<head>
<title>http2 explained - Changelog </title>
#include "head.t"
</head>
#include "body.t"
#include "setup.t"
#include "topmenu.t"

TITLE(http2 explained - Changelog)
BOXTOP

<p>
 Since September 11 2015, it is better to read the <a
href="https://github.com/bagder/http2-explained/commits/master">commit log</a>
to follow the changes in detail.

<p> September 11, 2015<p>

<ul>
<li> Converted the master version of this document to Markdown syntax, with
new formatting and lots of tiny edits all over.
<li> 13: mention more resources, updated links and descriptions
<li> 12: Updated the QUIC description with reference to draft
<li> 8.5: refreshed with current numbers
<li> 3.4: the average is now 40 TCP connections
<li> 6.4: Updated to reflect what the spec says
</ul>

<p> Version 1.12: May 21, 2015
<ul>
<li> 1.1: HTTP/2 is now in an official RFC
<li> 6.5.1: link to the HPACK RFC
<li> 9.1: mention the Firefox 36+ config switch for http2
<li> 12.1: Added section about QUIC
</ul>

<p> Version 1.11: March 12, 2015
<ul>
<li> Lots of language improvements mostly pointed out by friendly contributors
<li> 8.3.1: mention nginx and Apache httpd specific acitivities
</ul>

<p> Version 1.10: February 18, 2015
<ul>
<li> 1: the protocol has been "okayed"
<li> 4.1: refreshed the wording since 2014 is last year
<li> front: added image and call it "http2 explained" there, fixed link
<li> 1.4: added document history section
<li> many spelling and grammar mistakes corrected
<li> 14: added thanks to bug reporters
<li> 2.4: (better) labels for the HTTP growth graph
<li> 6.3: corrected the wagon order in the multiplexed train
<li> 6.5.1: HPACK draft-12
</ul>

<p> Version 1.9: February 11, 2015
<ul>
<li> Updated to HTTP/2 draft-17 and HPACK draft-11
<li> Added section "10. http2 in Chromium" (== one page longer now)
<li> Lots of spell fixes
<li> At 30 implementations now
<li> 8.5: added some current usage numbers
<li> 8.3: mention internet explorer too
<li> 8.3.1 "missing implementations" added
<li> 8.4.3: mention that TLS also increases success rate
</ul>

<p> Version 1.8: January 15th, 2015
<ul>
<li> Compressed the images better, leading to a <i>much</i> smaller PDF
<li> Updated to draft-16 and hpack-10
<li> Replaced several images
<li> Linkified many URLs
<li> Added a few questions in 8.4
<li> Mentions IETF Last Call
</ul>

<p> Version 1.7: November 18th, 2014
<ul>
<li> Updated to draft-15 details
<li> Minor edits
</ul>

<p> Version 1.6: August 13th, 2014
<ul>
<li> Updated to draft-14 details
<li> Firefox Nightly runs with it by default
<li> clarified NPN details
</ul>


<p> Version 1.5: June 18th, 2014
<ul>
<li> Updated to draft-13 details
<li> Mention extensions and the two first discussed ones
</ul>

<p> Version 1.4: May 7th, 2014
<ul>
<li> Updated Firefox network trace screenshot
<li> clarify that the spec won't be "out" in June
<li> clarify that HTTP <b>1.1</b> had the two TCP connection restriction, it wasn't there in 1.0
</ul>

<p> Changes in 1.3:
<ul>
 <li> Restored the chapter numbering that somehow got lost in 1.2
</ul>

<p> Changes in 1.2:
<ul>
 <a href="https://github.com/bagder/http2-explained/issues?milestone=2&page=1&state=closed">more language fixes</a>, added explanation for "bis" in HTTPbis.
</ul>
<p> Changes in 1.1:
<ul>
 10+ language fixes of funny wording or bad grammar.
</ul>

BOXBOT

<p>
 This page was updated __TODAY__.

#include "footer.t"

