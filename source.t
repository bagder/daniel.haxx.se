#include "doctype.t"
<head><title>Daniel Stenberg -- Sources</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"
<p>

TITLE(Source Codes by Daniel)
BOXTOP
  Sources written by me, Daniel Stenberg, alone or together with
  others. They're all written in C. Use whatever you want, but telling me
  you're using my stuff would be greatly appriciated!
<center><a href="/stuff/">Directory "View And Pick!"</a></center>

<table>
<tr>
<td width=50% bgcolor=#eeeeee valign=top>
<b>mail2sane</b><br>
  A MIME decoder for mails to plain text. Ignores all attachments etc that
  can't be made "sane". Understands base64, multipart/mixed, uuencoded, etc.
  Intended as a part in our mail => sms program.
</td>
<td>
<b>mail2sms</b><br>
  A MIME mail to short text converter. Allows regex search/replace, conditional
  replaces, date/time awareness, output format configs and lots more.<br>
  <a href="/mail2sms/">Official Webpage</a>
</td>
</tr>
<tr>
<td>
<b>set</b><br>
  My object-oriented-styled generic config-file functions for your program. I
  made this to create a system for general config/data files, where the file
  format is hidden from the program and the config/data is hierarchic. Its
  hard to explain in a few words, if you need a generic config file engine,
  you might consider borrow something from this...!
</td>
<td width=50% bgcolor=#eeeeee valign=top>
<b>dscanf</b><br>
  A full *scanf() clone package. Features all sscanf() format flags and more.
</td>
</tr>
<tr>
<td width=50% bgcolor=#eeeeee valign=top>
<A HREF="/stuff/">FWrap</A><br>
        Frexx Wrapper. This works as a word wrap filter. It makes sure the
        text sent in via stdin comes out nicely 'wrapped' at the specified
        column. It is (or at least has been) used by several mail programs to
        (re-)format mail, and for adding "quote-prefixes" to the left of all
        quoted lines. 
</td><td>
<a href="/stuff/">FPL</a><br>
        Frexx Programming Language - an interpreting programming language very
        similar to C. It has been written to get used by programs that want to
        be 'scriptable' / controlable with a scripting language. This has been
        ported to more than 10 different OSes. (Unixes, Amiga, OS/2, Win32,
        OS-9, ...)
        <br><a href="/fpl/">Official webpage!</a>
</td></tr>
<tr><td>
<a href="http://dancer.sourceforge.net/">Dancer</a><br>
        An IRC bot. It offers loads of services for an IRC channel. TCP/IP-
        programming and client/server solutions for everyone ;) Been ported to
        a large amount of unixes.

</td><td bgcolor=#eeeeee>
<a href="/stuff/">dprintf</a><br>
        A printf()-clone. Supports $&lt;num&gt;-parameters, arguments using
        different sizes, long long (in GNU) etc. No internal floating point
        support, the regular sprintf() is used for that.
</td></tr>
<tr><td bgcolor=#eeeeee valign=top>
<a href="/stuff/">dsplay</a><br>
        My implementation of a splay tree. It is a very handy way to
        automatically sort nodes of a "linked list" when adding and removing
        nodes. (I.e to prevent the need for linear search when a particular
        item is later requested.)
</td><td>
<a href="/stuff/">dbestfit</a><br>
        A full memory handler (malloc, free, realloc and the whole
        story). Written to be able to replace the operating system's own
        handler. It uses the best-fit algorithm (with splay-sorted free
        blocks) and a separate block-handling for small blocks. The functions
        for small blocks can be (and already has been) used separately. It
        gave a fair performance boost of the pSOS operating system when
        applied.
</td></tr>
<tr><td valign=top>
<a href="/stuff/">dhash</a><br>
        Generic hash table functions. Insert data using a certain key, and get
        it back at a later time using the same key the fastest possible way.
        This is written to deal with LARGE amounts of data, and uses splay-
        sorted lists on each hash table entry.
</td><td bgcolor=#eeeeee>
<a href="https://curl.haxx.se/">curl and libcurl</a><br>

        A tiny program and library for client-side URL transfers.  Understands
        HTTP, HTTPS, FTP, GOPHER, LDAP, DICT, TELNET. It handles binaries,
        full URLs, proxies, different ports and user/passwd in ftp-URLs. Later
        versions feature FTP upload, HTTP POST, SSL and more.

</td></tr>
<tr><td bgcolor=#eeeeee valign=tyop>
<a href="/stuff/">week</a><br>
        A very small program that shows todays week number according to the
        ISO 8601 standard. Converts to and from dates and week numbers.
</td><td>
<a href="/stuff/">evaluate</a><br>
        Evaluates a mathematical (C-style) expression. A generic function with
        support for all C-operators including the unary ones, octal and
        hexadecial numbers, defined variables and unlimited nested
        parentheses and more.
</td></tr>
<tr><td>
<a href="/stuff/">winrdate</a><br>
        My port of the unix command 'rdate' to win32. It sets the time of your
        PC to the same time a unix server has. Very practical within i.e
        Frontec where the unix machines are set against an atomic watch.
</td>
<td bgcolor=#eeeeee valign=top>
        <a href="/stuff/">dmatch</a><br>
        My tiny little implementation of a ? and *-supporting wildcard matching
        function.
</td>
</tr>
<tr><td bgcolor=#eeeeee valign=top>
        <b>base64</b><br>
        A tiny source for some quick n' easy convertions to and from base64.
</td><td>
        <b>cpp</b><br>
        I've written this full blown, 100% ANSI C compliant preprocessor. It
        features a bunch of neat extensions that are handy to use, for both
        C and HTML processing!
</td>
</tr>
</table>

BOXBOT
#include "footer.t"
