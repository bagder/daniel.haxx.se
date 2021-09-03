#include "doctype.t"
<head>
<title>C Source Code Portability</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
<link rel="STYLESHEET" type="text/css" href="port.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

TITLE(C Source Code Portability)
BOXTOP

<p>
 Functions (limited to libc and "system" ones), general often-used concepts and
variable types. Include known flaws, work-arounds, autoconf tests and general
comments from past experiences.

<p>
 If you find flaws or have additional data to offer, please mail me. My email
address is visible at the bottom of the page. This page is destined to always
be "under construction".

<p> Related useful resources: <a
href="http://predef.sourceforge.net/">predef.sf.net</a>, <a
href="http://www.unixpapa.com/incnote/index.html">Unix Incompatibility
Notes</a>, <a
href="http://sprg.ssl.berkeley.edu/~fastops/ITOS/portable/Top.html">Tips For
Writing Portable C</a>

BOXBOT

<p>

TITLE(Functions)
BOXTOP

<p>
<table cellspacing="1">
<tr><th>Function</th><th>Issues</th></tr>

<tr><td>basename</td><td>FreeBSD 3.4 does not include the standard function basename().</td></tr>

<tr><td>bcopy</td><td>Old-style BSD function, use memcpy() for portability</td></tr>

<tr><td>bzero</td><td>Old-style BSD function, use memset() for portability</td></tr>

<tr><td>gettimeofday</td><td>Not available on Windows, otherwise widely available. clock_gettime() is a newer POSIX/TSUSv2 function with higher resolution. </td></tr>

<tr><td>getaddrinfo</td><td>Only available in recent modern operating systems
(gethostbyname() must be used on the others). NI_WITHSCOPEID (not present in
mingw, glibc 2.3.2, Tru64 5.1, IRIX 6.5.22) and AI_NUMERICHOST (not present in
AIX 4.3) are not universally available even if the getaddrinfo() function is
present<p> Using the PF_UNSPEC option on Linux hosts that are ipv6-enabled
but that doesn't have the ipv6 kernel module loaded cause very slow name
resolves. This is usually worked around by first trying if a ipv6 socket can
be made and if not, no ipv6 resolves are attempted (PF_INET). </td></tr>

<tr><td>gethostbyaddr_r</td><td>Not needed on Windows, HP-UX 11 and AIX 5
(since gethostbyaddr() is then thread-safe on its own). Not existant on older
platforms. Three different APIs:<p>

5 arg version: <span class="proto">int gethostbyaddr_r(char *address, int
length, int type, struct hostent *he, struct hostent_data *data)</span><p>

7 arg version: <span class="proto">struct hostent *gethostbyaddr_r(char
*address, int length, int type, struct hostent *he, char *buffer, int bufsize,
int *errno)</span><p>

8 arg version: <span class="proto">struct hostent *gethostbyaddr_r(char
*address, int length, int type, struct hostent *he, char *buffer, int bufsize,
struct hostent **hep, int *errno)</span>

</td></tr>

<tr><td>gethostbyname_r</td><td>Not needed on Windows, HP-UX 11 and AIX 5
(since gethostbyname() is then thread-safe on its own). Not existant on older
platforms. <br>Three different APIs.<p>

AIX4, Digital Unix/Tru64, HPUX 10 use 3 arguments: <span class="proto">int
gethostbyname_r(char *hostname, struct hostent *hostent, struct hostent_data
*data) </span><p>

Solaris (needs to be linked with -lnsl) and IRIX use 5 arguments: <span
class="proto">int gethostbyname_r(char *hostname, struct hostent *hostent,
char *buffer, int buflen, int *h_errnop)</span><p>

Linux uses 6 arguments: <span class="proto">int gethostbyname_r(const char
*name, struct hostent *ret, char *buf, size_t buflen, struct hostent **result,
int *h_errnop)</span>

</td></tr>

<tr><td>gethostbyname</td><td>Found in different libs in different operating
systems. Could be one of these: -lnsl (Solaris), -lsocket, -lws2_32 (Windows),
and -lnet (BeOS). See also gethostbyname_r</td></tr>

<tr><td>localtime_r</td><td>Not present in all unixes. Broken implementation
in HPUX 10.20 (it returns an 'int' instead of a pointer - is that 0 for
success?)</td></tr>

<tr><td>strerror_r</td><td>Not present everywhere (like Windows, Solaris
7). But when it is, there's a POSIX way (<span class="proto">int
strerror_r(int errnum, char *buf, size_t n)</span>) and there's a glibc way
(<span class="proto">char *strerror_r(int errnum, char *buf, size_t
n)<span>)</td></tr>

<tr><td>inet_ntoa_r</td><td>Not present in all unixes.</td></tr>

<tr><td>strtok_r</td><td>Not present in all unixes. Standardized in UNIX98
(aka SUSv2)</td></tr>

<tr><td>getpass_r</td><td>Not present in all unixes. In fact, this is rarely
available. (SCO Unix has it) </td></tr>

<tr><td>gmtime_r</td><td>Broken implementation in HPUX 10.20 (it returns an
'int' instead of a pointer - is that 0 for success?)</td></tr>

<tr><td>select</td><td>Windows quirks: you can only select on sockets. You
cannot know if a FD_SET() would overflow the buffer since the file descriptor
numbering starts way above 0 and comparisons against FD_SETSIZE are not
working. FD_SETSIZE is typically set very low (64) by default. <p>

Many unix versions allow FD_SETSIZE to be re-defined at compile time, but
Linux does not.

<p> Linux has odd semantics, the following is from the BUGS section of select(2)
<p>
       Under Linux, select() may report a socket file descriptor as "ready for
       reading",  while nevertheless a subsequent read blocks.  This could for
       example happen when data has arrived but  upon  examination  has  wrong
       checksum and is discarded.  There may be other circumstances in which a
       file descriptor is spuriously reported as ready.  Thus it may be  safer
       to use O_NONBLOCK on sockets that should not block.

</td></tr>

<tr><td>poll</td><td>Not existing on old unixes. Broken implementation in Mac
OS X at least up to 10.4 and earlier. Up to 10.3 you could check for a poll()
that works with all arguments zeroed. The 10.4 bug is more obscure an I don't
know of any way to detect it without checking for OS.</td></tr>

<tr><td>snprintf</td><td>Essential function that is lacking in older unixes
(SunOS) and Windows. Different implementations return differen values in case
of prevented overflow. <a
href="http://autoconf-archive.cryp.to/ac_func_snprintf.html">autoconf macro
for C99-compliant snprintf</a> <a href="/projects/trio/">trio *printf
code</a></td></tr>

<tr><td>sprintf</td><td>Returns either a 'char *' as a pointer to the output
buffer (SunOS, 4.3 BSD) or an int as the length of the output data (most
others, POSIX).</td></tr>

<tr><td>strcasecmp</td><td>Some platforms (Reliant and UnixWare) have this in
the resolve lib, requiring -lresolve to link fine.</td></tr>

<tr><td>socket</td><td> Needs -lnsl -lsocket in LDFLAGS to link on
Solaris

<p> On Win64 it returns a SOCKET which is 64 bits, while (all?) other systems
return an int, 32 bits.

</td></tr>

<tr><td>sigaction</td><td>HPUX doesn't have SA_RESTART, but instead it
defaults to the same behaviour as other systems that do have gets when ANDing
out the SA_RESTART bit from sigact.sa_flags</td></tr>

</table>

BOXBOT

<p>
TITLE(Concepts)
BOXTOP

<p>
<table cellspacing="1">

<tr><th>Concept</th><th>Description</th></tr>

<tr><td>Non-blocking sockets</td><td>Done in lots of different ways:
<p>
The POSIX approach (known to not work on SunOS 4, AIX v3 and BeOS - although
the function and defines are present) <span class="proto">fcntl(socket,
F_SETFL, flags | O_NONBLOCK)</span><p>

BSD-style <span class="proto">ioctl(socket, FIONBIO, &flags)</span><p>

Windows-style <span class="proto">ioctlsocket(socket, FIONBIO, &flags)</span>
<p>

AmigaOS-style <span class="proto">IoctlSocket(socket, FIONBIO, (long)1)</span>
<p>

BeOS-style <span class="proto">setsockopt(socket, SOL_SOCKET, SO_NONBLOCK, &b, sizeof(b))</span>

 </td></tr>

<tr><td>Avoiding SIGPIPE</td><td>Done in several ways:<p> Ignore signal (using
sigaction() or signal(), the latter more widely available)<p>
Mac OS X 10.2 and later (at least): <span
class="proto">setsockopt(sockfd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&onoff,
sizeof(onoff))</span><p>Most other systems support <span
class="proto">send/recv(x,y,z, MSG_NOSIGNAL)</span> </td></tr>

<tr><td>Building thread-safe</td><td>-D_THREAD_SAFE -D_REENTRANT (Solaris,
HPUX) and more? [FILL IN]</td></tr>

<tr><td>libc</td><td>Windows quirks: the libc is provided by the compiler, not
by the operating system. Thus, various libc function calls may differ between
compilers.</td></tr>

<tr><td>case insensitive string comparisons</td>
<td>Most systems: <span class="proto">int strcasecmp()</span><br>
Windows: <span class="proto">int strcmpi()</span> or <span class="proto">int stricmp()</span>
</td></tr>

<tr><td>writeable argv[]</td> <td>Many systems allow programs to overwrite the
argv[] strings to hide data from appearing in ps outputs (Linux, Solaris 7,
HP-UX 11, Tru64 V5, IRIX 6.5)</td></tr>

<tr><td>inline</td> <td>Was not a standard keyword until C99. Before that,
compilers provided various own approaches (<a
href="http://gcc.gnu.org/onlinedocs/gcc-4.0.0/gcc/Inline.html#Inline">gcc
supports inline</a> since very long).</td></tr>

</table>

BOXBOT

<p>
TITLE(Variable Types)
BOXTOP

<p>
<table cellspacing="1">
<tr><th>Type</th><th>Issues</th></tr>

<tr><td>time_t</td><td>Often a signed 32bit type, sometimes unsigned 32bit
(OpenVMS), and sometimes still 32bit even when running in a 64bit arch (AIX)
and even sometimes 64bit on 32bit systems (VS2005) </td></tr>

<tr><td>size_t</td><td>POSIX type not always present on old systems. strlen()
and family returns size_t in POSIX</td></tr>

<tr><td>ssize_t</td><td>Commonly used signed version of size_t. Not present on
numerous systems.</td></tr>

<tr><td>in_addr_t</td><td>Not present on many pre-POSIX systems. Functions
that otherwise use in_addr_t usually use int on those.</td></tr>

<tr><td>socklen_t</td><td>Not present on many pre-POSIX systems. Functions
that otherwise use socklen_t usually use int on those.

<p> AIX 4.2 curiously uses an unsigned type for this. (AIX -4.1 was int, AIX
 4.3+ is socklen_t)

</td></tr>

<tr><td>struct sockaddr_storage</td><td>Not present in AIX 4.3 even though it
has getaddrinfo() and other IPv6-ready functions</td></tr>

<tr><td>off_t</td><td>POSIX type for file sizes. Not present on older
systems. Usually 32 or 64 bit.</td></tr>

</table>

BOXBOT

<p>
TITLE(Contributions by)
BOXTOP

 Bjorn Reese, Magnus Fromreide
<p>
 Thanks!
BOXBOT


Latest update: __TODAY__

#include "footer.t"

