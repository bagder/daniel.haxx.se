#include "doctype.t"
<head>
<title>Building a PVR on Linux</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

TITLE(Building a PVR with Linux on EPIA M10000)
BOXTOP

<p>A silent and not too ugly piece of equipment that can fit and be used in
the living-room for watching movies (downloaded and DVD) and TV and listen to
music. It should also be possible to record TV to disk, on demand and using a
timer. Maneuverable using a remote.

<p>
 This project has been put on hold due to high work-load and other things. The
info is from and work was made in 2003.

SUBTITLE(Work)

<p>
 I ordered a TV-tuner card from <a href="http://www.dustin.se/">Dustin</a> on
2003-07-31 (SEK 595) that arrived on August 4. I'll start experimenting with
that on a plain Linux computer first.

<p>
 I put the TV-card in a P3 600Mhz machine with 128MB ram at work, and
installed a fresh Redhat Linux 9 on it. 'modprove bttv' loaded the correct
drivers at once, and '<a href="http://bytesex.org/xawtv/">xawtv</a>' could
show the local swedish TV channels after a while. <a
href="http://freevo.sf.net/">Freevo</a> did too after a little persuading and
understanding that 'europe-west' needs to be set for the 'chanlist' setting.
<p>
 <a href="tv/snap-SVT1-20030806-161554-1.jpeg"><img src="tv/snap-SVT1-min.jpg"
border="0"></a> <a href="tv/snap-SVT2-20030806-161532-1.jpeg"><img
src="tv/snap-SVT2-min.jpg" border="0"></a>

<pre>
$ /sbin/lspci | grep Bt878
01:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
</pre>
<p>
Driver logging in <a href="dmesg.txt">/var/log/messages</a>.
<p>
<pre>
$ cat /proc/video/dev/video0 
name            : BT878(Hauppauge (bt878))
type            : VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_TELETEXT|VID_TYPE_OVERLAY
hardware        : 0x1
</pre>

SUBTITLE(TV tuner)

<p>
 TV-tuner card: <a
href="http://www.hauppauge.com/html/wintv_pci_datasheet.htm">Hauppauge WinTV
Nicam Stereo PCI card</a> because it has a chip set (Brooktree Corporation
Bt878) <a href="http://www.hauppauge.com/html/linux.htm">supported by
Linux</a> <a href="http://bytesex.org/bttv/">drivers</a>, it is cheap and has
a remote control that seems to be <a
href="http://www.lirc.org/tv_cards.html">supported by Linux</a>.

SUBTITLE(Motherboard and CPU)
<p>
<a
href="http://www.viavpsd.com/product/epia_m_spec.jsp?motherboardId=81">VIA
EPIA M10000 1GHZ C3</a>, Mini-ITX.<br> <a href="epia-m.jpg"><img
src="epia-m_s.gif" border="0"></a>
<p>
 There's an effort going on to <a
href="http://unichrome.sourceforge.net/">reverse engineer the CLE266 MPEG
library</a> needed to use the built-in MPEG circuit of the motherboard.  <p>
 Via's own page: <a href="http://www.viaarena.com/?PageID=188">Linux on the
M-series</a>.

SUBTITLE(Case)
<p>
(<a
href="http://www.casetronic.com/Product/PCcase/2699/CS-2699.html">Casetronic
2699R</a>), fanless and neat. External power. PCI riser card included.
<br>

<a href="case.html"><img src="2699R.jpg" width="200" height="150"
border="0"></a>

<br> Width: 292mm / Height: 63.5mm / Depth: 273 mm

SUBTITLE(Memory)
<p>
  256 MB low-profile DIMM

SUBTITLE(DVD)
<p>
 Teac DVD-ROM 8x/24x Slimline IDE

SUBTITLE(Hard disk)
<p>
 Seagate Barracuda 160GB 7200RPM ATA100

SUBTITLE(Wireless)
<p>
 Requires an external "access point".

BOXBOT

#include "footer.t"

