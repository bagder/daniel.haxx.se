#include "doctype.t"
#include "setup.t"
HEAD(Daniel Stenberg -- skills and experiences)
#include "body.t"
#include "daniel.t"

<p>
 Here's a rough summary.

<p>
TITLE(Technical Experience)
BOXTOP
<span style="float: right;">
<b>Talks I've held</b><ul>
<li> HTTP/2
<li> IPv6
<li> Open Source Licensing
<li> Open Source Project Management
<li> Linux Device Driver Development
<li> Embedded Linux Introduction
<li> Reverse Engineering
<li> curl/libcurl walk-through
<li> ... mixes of the above
</ul>
</span>

List of Buzz Words
<ul>
 <li> <b>Unix</b> - SunOS, Linux, Solaris, DELL UNIX, UnixWare, HPUX, AIX,
   *BSD, programming and administration

 <li> <b>Linux</b> Ordinary linux admining, Linux app writing, embedded linux
  booting/startup, device drivers and experience with Linux on numerous
  architectures. Linux kernel hacking and porting on several platforms.

 <li> <b>Linux drivers</b> I've written/adjusted drivers for framebuffer, PCI
   controller, serial ports, USB EHCI, for various custom hardware and more.

 <li> <b>Network</b> - Ethernet, token ring, routers, gateways, DNS, NIS, ATM
   and DTM
 <li> <b>Datacomm</b> - Modems and all sorts of protocols
 <li> <b>TCP/IP/PPP</b> from sockets to bit-fiddling, portably on lots of platforms
 <li> <b>HTTP/HTTPS/FTP</b> many years of experience with protocol development, curl and libcurl, work in the IETF

 <li> <b>Drivers</b> hardware device drivers for many OSes, including
  Linux/uClinux (x86, AMD64, ARM9, StrongARM, XScale, PPC, MIPS, SH4,
  MicroBlaze, Nios II, m68k), OSE and pSOS

 <li> <b>RTOS</b> - OS-9/386, pSOS, VxWorks, OSE, Rockbox, homegrowns
 <li> <b>AmigaOS</b>
 <li> <b>C, C++</b> - very experienced in multi-platform and embedded development
 <li> <b>Assembler</b> 6502, m68k, x86, Hitachi SH703x, 8051, ARM, MIPS.
 <li> <b>curl/libcurl</b> main author
 <li> <b>SSH</b> involved in the libssh2 project
 <li> <b>Web</b> HTML, cgi-hacks (mainly perl)
 <li> <b>Script Languages</b> Bourne Shell, Perl, awk, tcl
 <li> <b>Java</b> minor experience: <i>Where Java goes in, I go out</i>
 <li> <b>Tools</b> Expect, gcc crosscompiler and native on many platforms,
      armcc, axd debugger, IAR's 8051 C compiler
 <li> <b>Version Control Systems:</b> Clearcase, RCS, CVS, Subversion, git, Mercurial

 <li> <b>Open Source:</b> takes part in numerous Open Source projects, both
   for fun and for hire, see details in the separate <a
   href="myopensource.html">My Open Source</a> document.
 <li> <b>Coffee:</b> black please
</ul>


SUBTITLE(Specialization)
BOXTOP

<p> Linux/Unix, network, hardware, real-time and embedded related
  programming. C or C++. Focus on implementation.

BOXBOT

#if 0

  <table><tr valign="top"><td>

  TITLE(2010)
  BOXTOP

    <p> Made sure that the Linux 2.6.31 kernel with the RT patched applied
    worked flawlessly and that latency was kept to minimum. On Freescale's
    P4080-platform.

    <p> July: started project with unrevealed details (so far)

  BOXBOT

  TITLE(2009)
  BOXTOP

   <p> Worked on u-boot and Linux device drivers for a Collibri PXA270
   based system with touchscreen, running Qt and more.

   <p> Extended SSL certificate support for libcurl

   <p> Debugged, developed and designed software for video subtitling on
   a target running a Nios2 CPU completely bare without operating system.
   TCP/IP provided by an external Epson S1S60000 chip and graphics by
   in-house FPGA.

  BOXBOT

  TITLE(2008)
  BOXTOP

   <p> January - March, parental leave.

   <p> April, started for real working with the "System Platform Team" on
   Polystar to do a 10 gigabit ethernet platform for monitoring and load
   generating. 

  BOXBOT

  TITLE(2007)
  BOXTOP
   <p> January, qt3/embedded on Linux frame buffer on a sh4-linux for Tilgin.

   <p> February, AT91RM9200-linux in two projects. Writing software design for
    Fiberson and adjusting frame buffer driver for Bitsim.

   <p> March, MicroBlaze uclinux

   <p> April, uclinux on Nios II

   <p> May - September, Linux drivers and applications writing at TagMaster

   <p> October - end of year. Parental leave, taking care of my son.

  BOXBOT

  TITLE(2006)
  BOXTOP

  <p> ... continued my Tagmaster assignment until June 30th.

  <p> August: Doing curl work funded by IIS and Hillcrest Inc.

  <p> Some Linux hacking on a board equipped with NEC's MIPS-based EMMA2SW
   microcontroller.

  BOXBOT

  TITLE(2005)
  BOXTOP

   <p> Wrote a framebuffer device driver for Bitsim's Badge display
   controller, running on Linux 2.6.11 PowerPC 402.

   <p> Wrote device drivers, linux apps, protocols, u-boot adjustments and
   more for Tagmaster and their AT91RM9200-equipped board.

   <p> Spent December working on libcurl hiper project, funded by IIS.

  BOXBOT

  TITLE(2004)
  BOXTOP

   <p> Spring: Assignment on Trimble continues...

   <p> Autumn: paternity leave. Taking care of my <a
   href="/agnes/">daughter</a> full time.

  BOXBOT

  TITLE(2003)
  BOXTOP

   <p> Spring: wrote a web based application for Stockholms Läns Landsting,
   to help them organize a huge move and reorganization.

   <p> Produced a web based planner-tool to help Kulturhuset handle and book
   rooms and events.

   <p> September: doing embedded programming for Trimble. Working with OSE on
   an ARM7 CPU. 24MHz 2MB ram. C++. Development on Windows. Armcc, AXD
   debugger. Hush hush product.

  BOXBOT

  TITLE(2002)
  BOXTOP

  <p> At Net Insight still. Design and development of the low-level DTM
   protocols. Multiple platforms, speed efficiency, robustness. Lots of
   debugging.

  <p> In April, a separate project, still at Net Insight. Ported the embedded
   web server to Linux, did some general cleanups and code improvements in the
   web server code.

  <p> In August, started porting the SNMP server to Linux to make a similar
  test and development environment for that server as I already did for the
  web server before the summer.

  <p> September: (after 2.5 years at Net Insight I'm out).

  <p> October: Project with embedded Linux on ARM (Intel Xscale PXA250). 10"
  touch-screen, ethernet, running mainly a browser. Qt/E + konq/E.

  BOXBOT

  TITLE(2001)
  BOXTOP
  <p>
   Continuing on Net Insight. Doing more digging around in the NetBSD kernel.

  <p> For almost the whole year, I've been working on debugging. I sort out
   other people's hard-to-solve problems, system level errors, sever memory
   leaks, compiler bugs, OS bugs and more. I use probe (pSOS' built-in very
   raw and basic system "debugger"), assembler level digging and common sense.

  BOXBOT

  TITLE(2000)
  BOXTOP
  <p>
   January: Linux kernel hacking, PPP extensions, modifying samba, modem and
   ISDN drivers and more for Direct2Internet's Access Switch based on a Linux
   2.2 platform.

  <p> March: Writing switch layer protocols and software for Net Insight, on a
   platform (a DTM switch) based on a StrongARM running pSOS and NetBSD.

  BOXBOT

  </td><td valign=top>
 
  TITLE(1999)
  BOXTOP
  <p>
   January: Back to network job with Frontec's LAN and WAN for a short while.

  <p> February: Autodiagnos, Fittja. Writing software for a car testing
   tool. More specifically, the little device tested a car's ignition
   system. Target CPU: Siemens 8051. 

  <p> September: Writing drivers at Ericsson, ERA, Kista. It is a GSM switch
   based on a PPC 403 running OSE.

  <p> November/December: I helped two different projects at Ericsson Telecom
   and Siemens Elema to debug and bugtrack errors with their native IP-stacks
   and IP related problems.

  <p> Quit Frontec. Started working for Contactor.
  BOXBOT

  TITLE(1998)
  BOXTOP
  <p>
   Spring: a second project at ERA, Nacka. Working within the same application
   with hardware initialization and port-selecting(!)

  <p> March: helped Frontec consultants in need, in Nice, France. ARM
   assembler, C debugging and general unix admining.

  <p> April: work for Ericsson Telecom (ETX) in Nacka. Building, designing and
   structuring a "system test lab" (unix setup, routing, network
   design). Test-tool developing. Lots of CGI / web based trouble report and
   logging system.

  <p> August: Ericsson Radio Systems (ERA). Back with the SSCOP (protocol
   stack) work.  Extending, and changing the interface.

  BOXBOT

  TITLE(1997)
  BOXTOP
  <p>
   Started: at Ericsson from the previous year's project.
  <p>
   Summer: worked as unix/network admin with the Frontec Tekniksystem's unix
   network. The previous admin quit during the spring and I spent the summer
   getting the network up again to a satisfyable level.

  <p> Autumn: work for Ericsson Radio Systems (ERA) in Nacka, implementing a
   "secure transmission" protocol layer (SSCOP - ITU-T recommendation Q.2110)
   in a Wideband CDMA telephone base station, an ATM switch. The platform is a
   PPC603 running OSE.
  BOXBOT

  TITLE(1996)
  BOXTOP
  <p> August 1996: Started working as a consultant at Frontec Konsulter
   Stockholm (which later became Frontec Tekniksystem).
  <p>
   September to May 1997: Bugfixed and extended a PPP-driver under pSOS
   (68360) at Ericsson Business Networks (EBC) in Nacka. I also wrote a memory
   handler that replaced pSOS' internal one.
  BOXBOT

  TITLE(1993-1996)
  BOXTOP
  <p>
   Started working for Frontec in August 1993
  <p>
   Worked a few years for Frontec Railway Systems with real-time (lots of
   OS-9/386 stuff and some Hitachi 703X assembler), Unix (DELL UNIX, TeleUSE,
   X11) and datacomm. Hardware intense and uptime critical programming.

  BOXBOT

  TITLE(1991-1993)
  BOXTOP
  <p>
   Worked for IBM with their RS/6000 systems. Installation, programming and
   more. Learned unix and C for the first time.
  BOXBOT

  TITLE(1990)
  BOXTOP

  <p> Did my military service. 10 months in Strängnäs. Learned MC68000
  assembler on my Amiga.

  BOXBOT

  TITLE(1989)
  BOXTOP

  <p> Finished school. 3 years of 'Naturvetenskaplig linje'
  ("science"). Learned pascal.

  BOXBOT

  TITLE(1985)
  BOXTOP
  <p>

   Bought my first computer, the C64, learned to program. Wrote games and demos
   using 6510-assembler.

  BOXBOT

</td></tr></table>

#endif

#include "footer.t"
