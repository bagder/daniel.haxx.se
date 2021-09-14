#include "doctype.t"
<head>
<title>http2 explained - FAQ </title>
#include "head.t"
</head>
#include "body.t"
#include "setup.t"
#include "topmenu.t"

#define QUESTION(x) <h1> x </h1>

TITLE(http2 explained - Frequently Asked Questions)
BOXTOP
<p>
 This is a section about questions <i>about the document itself</i>. For
actual HTTP/2 questions and details, the document is meant to cover those!

QUESTION(Why is [...] missing from the document?)
<p>
 Please submit your ideas what you think is missing, I can only add what I've
figured out myself or someone helped me consider.
<p>
 This said, I of course have to make a selection of what to include and what
to exclude as I want the document to stay focused.

QUESTION(How do I report a bug in the document?)
<p>
 Comment on or help me fix errors in this document! Email daniel-http2@haxx.se
or even better: submit an <a
href="https://github.com/bagder/http2-explained/issues">issue</a>.

QUESTION(How do I translate the document into a new language?)
<p>
 Start out reading <a
href="https://github.com/bagder/http2-explained/blob/master/HOWTO-TRANSLATE.md">HOWTO-TRANSLATE.md</a>

QUESTION(Other good/better resources?)
<p>
 The <a
href="http://chimera.labs.oreilly.com/books/1230000000545/ch12.html">HTTP/2
section</a> from Ilya Grigorik's book, <a href="http://shop.oreilly.com/product/0636920028048.do">High Performance Browser Networking</a> is excellent on the protocol details and more.

BOXBOT

<p>
 This page was updated __TODAY__.

#include "footer.t"

