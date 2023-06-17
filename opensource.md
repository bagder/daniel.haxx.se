## FPL - 1992

I started once upon the time, around 1992, to write a script language that we
planned to use in our text editor FrexxEd which we wrote at the time. Frexx
Programming Language grew pretty much without control and we changed direction
many times during the first years of development. Eventually it turned out to
become a <b>very</b> C-like interpreted language that was designed to let a
program be able to add functions to the interpreter so that the language could
be easily embedded and customized to applications. We also wrote a compiler
that converted the ASCII-based source code into a byte-coded format for
increased speed. The project was a closed-source one for a very long time but
was later turned into an entirely open source project.

## FrexxEd - 1991

I and Kjell Ericson felt unhappy with the text editors we had on the Amiga
back in 1991. We decided it couldn't be that hard to write a better one, one
that would fit our needs a bit more. We wrote that text editor during the
years 1991 and 1996. It was a highly customizable and programmable editor
designed for programmers. We released it as shareware during the time we
developed it, but when we got bored and stopped developing it, we changed the
license so that it became free and open.
     
## Dancer - 1993

I played around with IRC and wrote a first basic IRC bot sometime during
1993-1994. Bjorn Reese approached me when he had written his first bot embryo
and together we developed Dancer to become one of the better defense-bots in
the IRC world. The source was free and open from the start. Dancer got a rich
set of commands and configurable features. It could hold a channel from being
taken or harassed by attack bots and scripts fairly well. I was the maintainer
of the project during around 1997 and 1998 until it was passed on to Tero
Jänkä. Today, Dancer is decaying somewhat due to the lack of interested
developers but there is still people involved in the project although both I
and Bjorn have stopped.

## Hypermail - 1997

When we (me and my friends at Frontec where we worked back then) first started
to play with web serving for real, sometime around 1996, we quickly discovered
a need for a tool that could convert a mailing list archive into nice-looking
HTML pages. We found hypermail v1.02 pretty soon and it didn't take long until
we noticed hypermail's limitations; the biggest one being that it didn't
handle MIME at all. I added some simple patches to make it deal with 8-bit
Swedish characters at first, and later when hypermail v2 development took
speed I wrote a whole MIME decoder for hypermail that not only dealt with the
8bit characters but also saved attachments properly and more. I also did some
major cleanups in the hypermail v2 sources to make it deal with dynamic
strings all over instead of the previous silly habit of static length buffers
with buffer overrun risks and my config file parser replaced the former one.

## mail2sms - 1998

My brother Björn Stenberg wrote a TCP/IP-based server for sending messages to
GSM phones already 1995 something. He also wrote a client that could submit
messages to the server and that client could interpret MIME mails, although
with some problems. I wrote a script pretty soon that would take a message in
a mail and send it as an SMS to Björn's server to all telephone numbers
specified in the subject.  You could make groups that enabled easy sending to
a whole range of telephones. After a while, the limits of Björn's MIME parsing
code started to appear more and more often and I wrote mail2sms, based on some
code I already wrote for the hypermail project. mail2sms offers not only full
MIME decoding but also regex search/replace, conditional replacing, time/date
dependent actions and more.

## curl - 1996

In late 1996 when I was involved in Dancer development I started to think
about getting currency rates off the web to collect them in a database to
offer bot users to exchange currencies online. To get the web pages, I wanted
a small utility that could fetch a web page and nothing more. I found httpget
by Rafael Sagula. It did exactly what I wanted. I soon found a very cool
currency site on a gopher server so I added gopher to httpget too. When up to
speed I later added FTP too and renamed the project to urlget since that
seemed to be more appropriate then. As time passed, more and more things got
into urlget and when I added the capability of uploading too I changed the
project name again, this time to curl. Curl is now a stand-alone tiny tool
that gets or sends data using URL syntax from and to a whole range of
different protocols. It supports HTTP, HTTPS, GOPHER, FTP, TELNET, DICT, FILE
and LDAP. The core of curl is now used in the separate library named libcurl
that is now being by other programs as well!

## spam.pl - 1997

I've been active on the Internet since 1993 and I think that especially in the
beginning it seemed as if many spammers picked email addresses from the Usenet
newsgroups. I wrote a lot of posts there and the more time that passed, the
more spam I got. In 1997 I decided that I'd finally write a script that could
extract all relevant information by itself from offending mails and send a
complaint to the correct receivers. So, I wrote it, using plain Bourne
shell. It turned out to be rather slow and in 1998 I rewrote it using perl and
not only did it get faster but I also improved the parsing a lot. The script
has evolved since, but has been used for hundreds if not thousands of spam
complaints, many of those have been heard and have been the cause of closed
accounts.

## Triacle - 1999

When Bjorn Reese and I had written Dancer for several years and made a huge
program out of it, it suffered from a slightly bad design. We wanted to add
new features to it, but the basic design of the bot was so that it became
terribly hard to do so without breaking a lot of old stuff or making very ugly
kludges necessary. We decided the only sane thing to do was to write a new
bot, all from the start and do a lot of design correct from the start this
time. We knew what writing a bot means after years of experience. We got as
far as to a pretty good ground and something to build on, a core that did most
of the networking layer when we gave up. We found out that we just didn't IRC
much any more nor did we run any bots actively. If you don't run a bot, how
could we develop a good one? We did some nice work for triacle that has later
been possible to re-use in other projects, so it wasn't all in vain.

## Trio/dprintf - 1999

Involved as I have been in several projects including portable Unix software,
it is obvious that not even the printf() series of functions are truly
portable to the extent you'd want them to be. Being aware of this and wanting
this to improve in the projects I'm involved in, I and Bjorn Reese initially
wrote an implementation of the printf() functions and I called the package
dprintf() (the name came from that my original package was daniel-printf and
when I merged with Bjorn's stuff I just kept my name). The package was not
really complete and after the triacle work had been done, we stood with a set
of useful string functions for C and a set of incomplete printf() functions.
Bjorn did most of the job of incorporating all those into the single package
trio which now has a complete set of printf() functions, scanf() functions and
a few other string-functions meant for portable Unix programming.

## Netracer - 1998

In 1998 I and friends started to think about writing a game. It should be a
game in which you compete by writing agents/clients that then fight against
the ones your friends have written. The best programmed client wins. We soon
landed on the car-game idea and netracer was born. A server keeps the track
and car information and all clients that connect get a selected amount of
information and can tell the server how it wants to run.  Ambitious as we were
we even attempted to make it reality in the real world! We got an R/C car and
we were supposed to add a CPU-board, PCMCIA-based code in java, sonars,
laser-things for distance-measuring, live video from the car and
more. However, it soon turned out that the happy bunch what were to make this
reality was lacking something essential: hardware skill. We didn't manage to
attract any of the hardware builders at our company to join our project and
soon the project died again. We went back to netracer, we redesigned it. we
wrote a new protocol, practically a new server and now in November 1999, we
are on track again and hopefully we'll be able to compete within a few months!

## smash - 2000

Several years ago my brother wrote the SMS server I wrote about above. Now,
the second generation of that is getting developed. We've designed a neat
ASCII-based HTTP-like protocol that enables us to write clients easily on any
platform using the language you want. There should be a plug-in system to
enable many different protocols and engines for different operators and we do
use an entirely new and better file storage syntax. This project is GPL
licensed.

## Subversion - 2000

In the mid-year 2000 people on collab.net started hacking on a replacement for
CVS. I joined the project in the early autumn and I've been a contributor to
the project since. I'm not any main player in this project, I mainly lurk in
the background and commit odd fixes every now and then. This project really
has the odds of becoming the future number one version control system, at
least for open source development...

## fcpp - 1995

I once found a public domain cpp source code floating around. I developed it
further and turned it into a full-blown ANSI-compliant C preprocessor. I also
added enough options to make it useful to preprocess web pages and still
today, most web pages I create are preprocessed using this tool.

## RockBox - 2001

Archos makes hard-disk based MP3-players. Rockbox is the open source project
initiated in late year 2001 by my brother Björn to write an open source
firmware for their products.  I'm an avid supporter, participant and
contributor since before I bought my own <i>Archos Recorder</i>. We write
everything from scratch. The Archos target hardware is a SH7034 at 12MHz, mp3
decoding is done by a MAS3507D or MAS3587F.

Rockbox expanded to cover lots of more music players, including brands named
iriver, iAudio and iPod.

## c-ares - 2004

During the summer 2002 Bjorn Reese and I once again joined up and started
planning and organizing project 'Denise'. We intended to write a fine,
multi-platform asynchronous name resolver library with a liberal license.

My own participation in this project made me instead adopt and fork the ares
project to produce c-ares. My own involvement in c-ares is primarily to
provide a good and solid asynch resolve library for libcurl.

