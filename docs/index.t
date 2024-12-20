#include "doctype.t"
#include "setup.t"
HEAD(Daniel Stenberg -- Documentation)
#include "body.t"
#include "daniel.t"

#define LINK(url,name) <a href="url">name</a>

<div class="content">

TITLE(Documentation)
<p>
 A probably incomplete collection.

SUBTITLE(Books)
<p>
 Books written by me:
<ul>
<li> <a href="https://everything.curl.dev/">Everything curl</a> - the curl book
<li> <a href="https://http2-explained.haxx.se/">http2 explained</a>
<li> <a href="https://http3-explained.haxx.se/">HTTP/3 Explained</a>
<li> <a href="https://un.curl.dev/">Uncurled</a> - everything I know and
 learned about running and maintaining Open Source projects for three decades.
</ul>

SUBTITLE(Random docs)

<ul>
<li>
 <a href="bittorrent-vs-http.html">Bittorrent vs HTTP</a> - a comparison of
 similarities and differences between the protocols

<li>
 <a href="curl-vs-libcurl.html">curl vs libcurl</a> - what are the different
 curl and libcurl really?

<li>
 <a href="curl-vs-wget.html">curl vs Wget</a> - a comparison of similarities
 and differences for ordinary humans

<li> <a href="curl-vs-httpie.html">curl vs HTTPie</a> - a comparison of
 similarities and differences

<li>
 <a href="encrypted-transfer-protocols-compared.html">Encrypted Transfer Protocols Compared</a> - FTPS vs HTTPS vs SFTP vs SCP

<li>
 <a href="ftp-vs-http.html">FTP vs HTTP</a> - a comparison of similarities
 and differences between the protocols

<li> <a href="/irchistory.html">IRC history</a> - how Internet Relay Chat took off

<li> <a href="/my-name-in-products.html">My name in products</a> - why my name and email appear at places

<li>
 <a href="poll-vs-select.html">poll vs select vs event-based</a> - a comparison of the syscalls and the event-based alternatives

<li>
 <a href="sshproxy.html">SSH Through or Over Proxy</a> - how to connect out
 to the Internet when locked in behind a HTTP proxy

<li> <a href="URL-interop.html">URL-interop</a> - problems in operability between the different URL/URI specifications.
</ul>

SUBTITLE(RFC credits)
<p>
 I participate within IETF and I am credited for my contributions to:

<ul>

<li> <a href="https://www.rfc-editor.org/rfc/rfc9110.html">RFC 9110</a> - HTTP Semantics (<a href="https://daniel.haxx.se/blog/2022/06/06/new-http-core-specs/">blog post</a>)

<li> <a href="https://tools.ietf.org/html/rfc8484">RFC 8484</a> - DNS Queries over HTTPS (DoH) (<a href="https://daniel.haxx.se/blog/2018/10/19/dns-over-https-is-rfc-8484/">blog post</a>)

<li> <a href="https://tools.ietf.org/html/rfc7616">RFC 7616</a> - HTTP Digest Access Authentication

<li> <a href="http://tools.ietf.org/html/rfc7230">RFC 7230 - 7235</a> - HTTP 1.1

<li> <a href="http://tools.ietf.org/html/rfc7151">RFC 7151</a> - File
Transfer Protocol HOST Command for Virtual Hosts

<li> <a href="http://www.rfc-editor.org/rfc/rfc6265.txt">RFC 6265</a> - HTTP
State Management Mechanism (On my blog: <a
href="https://daniel.haxx.se/blog/2011/04/28/the-cookie-rfc-6265/">The cookie
RFC 6265</a>)

<li> <a href="https://tools.ietf.org/html/rfc6249">RFC 6249</a> - Metalink/HTTP: Mirrors and Hashes

<li> <a href="http://www.rfc-editor.org/rfc/rfc5854.txt">RFC 5854</a> - The
Metalink Download Description Format

</ul>

SUBTITLE(Technical reviewer)

<p> I was technical reviewer for the following books:

<ul>
<li> <a
href="http://webbotsspidersscreenscrapers.com/">Webbots, Spiders and Screen
Scrapers</a> (see backside of 2nd edition)

<li> <a href="http://shop.oreilly.com/product/0636920052326.do">Learning HTTP/2
A Practical Guide for Beginners</a>
</ul>

SUBTITLE(Other acknowledgements)

<p> Acknowledgements (in books):
<ul>
<li> <a href="https://www.manning.com/books/http2-in-action">HTTP/2 in Action</a>
<li> <a href="https://www.amazon.com/dp/0578675862/">Working in Public</a>
</ul>


SUBTITLE(Presentations)
<p>
 You may like some <a href="/videos/">presentations</a> I've done.
</div>

#include "footer.t"

