#include "doctype.t"
<head>
<title>http2 explained - The HTTP/2 book</title>
#include "head.t"
</head>
#include "body.t"
#include "setup.t"
#include "topmenu.t"

#define SECTION(x) <h1> x </h1>

#if 0
/* https://http2-explained.haxx.se/
 */
#endif

TITLE(http2 explained)
BOXTOP
<table><tr><td valign="top">
<p>

<a href="https://http2-explained.haxx.se/">http2 explained</a> describes the
protocol HTTP/2 at a technical and protocol level. Background, the protocol,
the implementations and the future. Written by <a href="/">Daniel
Stenberg</a>.

<p>
 <a href="https://http2-explained.haxx.se/">This</a> is a "living document" in
the sense that I keep posting updates, and I care about and value feedback,
questions and comments I get about it. This document improves over time thanks
to a joint effort. Full credits to all helpers at the end of the document.

<p> <a href="https://http2-explained.haxx.se/">This
 document</a> has been <b>downloaded more than 200,000 times</b> and has been
 given praise widely. Give it a shot! It is provided free of charge under a
 Creative Commons license.

<p> It is being provided in both PDF and web versions.

<a name="translations"></a>
SECTION(Translations)
<p>
 All the translations are offered if you click the image on the right:
<ul>
<li> <b>Chinese</b> by Calvin Zhang and Simon Xia
<li> <b>English</b> by Daniel Stenberg (original version)
<li> <b>French</b> by Olivier Cahagne
<li> <b>Italian</b> by Massimiliano Fantuzzi
<li> <b>Japanese</b> by Tatsuhiro Tsujikawa
<li> <b>Persian</b> by Ehsaan
<li> <b>Portuguese</b> by Bruno Lellis and Filipe Boleto
<li> <b>Russian</b> by Vladimir Lettiev
<li> <b>Spanish</b> by Javier Infante
<li> <b>Swedish</b> by Daniel Stenberg
<li> <b>Turkish</b> by Zeynep Sanliturk
</ul>

<p>
 All translations are of course also subject to bug fixes and improvements!

SECTION(Help out!)
<p>
 Comment on, add sections, fix typos or correct errors in this document!
Submit an <a href="https://github.com/bagder/http2-explained/issues">issue
or a pull-request</a>, or just email daniel-http2@haxx.se.

SECTION(Source)
<p>
 The full document is available on <a
href="https://github.com/bagder/http2-explained">github</a>.

SECTION(Network capture samples)
<p>

<a href="h2-14-plain-nghttp2.pcapng">h2-14-plain-nghttp2.pcapng</a> is a
Wireshark capture of curl talking http2 draft-14 in plain text with <a
href="http://nghttp2.org/">nghttp2.org</a>.

<p> <a href="h2-akamai.zip">h2-akamai.zip</a> is a 949KB zip with a bundled
SSL key. It is a full stream showing Firefox downloading around 380 different
images from the <a href="https://http2.akamai.com/demo">Akamai HTTP/2
demo</a>, thus over HTTPS.

<p> Get <a href="https://www.wireshark.org/">Wireshark</a> 2.0 to dissect
 HTTP/2 frames.

<p>
 If you have more and better sample stream captures, please send them my way!

</td><td valign="top">

<a href="https://http2-explained.haxx.se/"><img border="1" src="cover.jpg" height="600" width="424"></a>

</td></tr></table>

SECTION(See Also)
<p>
 <a href="https://http3-explained.haxx.se/">HTTP/3 Explained</a> for all details of version 3!

<p>
 This page was updated __TODAY__.

#include "footer.t"
