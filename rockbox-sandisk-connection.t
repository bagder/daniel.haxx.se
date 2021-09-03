#include "doctype.t"
#include "setup.t"
#include "daniel.t"
HEAD(The SanDisk Rockbox Connection)
#include "body.t"
#include "sansa/topmenu.t"

TITLE(SanDisk Initial Contact)
BOXTOP
<p> On May 26th 2006, a person from SanDisk USA contacted the <a
 href="http://www.rockbox.org/">Rockbox</a> team, asking about our interest to
 port Rockbox to their Sansa e200 series.

<p>
 I responded and we exchanged a few mails about what we want and a little about
 what Rockbox is and how Rockbox is developed (open source, spare time
 hacking, reverse engineering, and all that), and what we really could
 use (== docs, schematics, source code etc) and would need to make a proper
 port to their players.

<p> Eager fans obviously take every chance to submit very premature stories to
news sites, proven by this <a title="Slashdot: SanDisk Baits Apple And Woos Rockbox"
href="http://apple.slashdot.org/article.pl?sid=06/06/02/166210">Slashdot on
June 2nd 2006</a> entry that pointed out a <a title="cnet.co.uk: SanDisk goes after the iPod iPuppets"
href="http://crave.cnet.co.uk/digitalmusic/0,39029432,49273890,00.htm">cnet.co.uk</a>
article which is based on a <a title="Rockbox Forum: Re: Sandisk Sansa E200"
href="http://forums.rockbox.org/index.php?topic=3225.msg33625#msg33625">forum
post</a> I did in which I confirmed we talked to SanDisk. And that's all I
confirmed. They made quite some hen out of that feather...

<p> <b>October 2006:</b> SanDisk does not provide any help, docs or
 anything else that help us with this effort. They donated some hardware but
 then their part ended.

<p> <b>December 2006:</b> Rockbox now has a working dual-boot bootloader that
can start Rockbox or the original firmware. Rockbox starts and runs. LCD
works, buttons work, scroll wheel works, accessing NAND flash works, playing
games/running plugins work. There's still <i>no sound</i>, no USB and no
battery charge level support etc.

<p> <b>March 10 2007:</b> Rockbox now has sound on the SanDisk Sansa e200
series.

<p> <b>September 3 2007:</b> Rockbox now works on the e200R <i>Rhapsody</i>
models as well.


BOXBOT

TITLE(A Package Received from SanDisk)
BOXTOP
<p>
 Our SanDisk friend put together a package and sent us.

<a title="Archos Recorder, iriver h140, iAudio X5 and Sansa e200" href="/sansa/sansa1.jpg"><img align="right" src="/sansa/t_sansa1.jpg" border"0" alt="Archos Recorder, iriver h140, iAudio X5 and Sansa e200"></a>

<p> In spite of UPS doing their best at throwing their lousy service at me, I
 managed to get the package in my hands.
<p> I received the box with great hopes but with a suspicion things won't be as
great as we'd like them to be.
<p>
 At about 10 am on June 14th 2006 I opened the box and it contained:
<ul>
<li> one Sansa e250 player (2GB)
<li> one Sansa e260 player (4GB)
<li> a printed user's manual (there's only PDF versions provided with the players, on the bundled CD)
<li> an article from San Jose Mercury News from feb 9 2006 about SanDisk and their sansa players.
</ul>

<p>
 Yes, there's a certain lack of... docs or any other developer's material.

<p>
 In August I received a <a href="sansa/e200-devboard.html">Sansa Devboard</a>.

BOXBOT

TITLE(What We Did Not Get)
BOXTOP

I just want to stress this since people continue to ask:

<p> We didn't get anything to help us actually make Rockbox to these
players. We got two players, yes, but we got no info, no docs. No help at all.

BOXBOT

TITLE(First Impressions Sansa e200 Hardware)
BOXTOP
<a title="Archos Recorder, iriver h140, iAudio X5 and Sansa e200" href="/sansa/sansa2.jpg"><img align="right" src="/sansa/t_sansa2.jpg" border"0" alt="Archos Recorder, iriver h140, iAudio X5 and Sansa e200"></a>

<p>
 <a href="/sansa/e200/pics/">e200 internals</a>, and <a
href="http://www.rockbox.org/twiki/bin/view/Main/SandiskE200HardwareComponents">Rockbox's
SandiskE200HardwareComponents</a>

<p> The box comes wrapped in amazingly endurable plastic that took quite some
 effort to break through.

<p> I tested this on three techy persons: I put the player in their hand and
 said something about this is my new toy. All three had the same reaction:
 "wow, its heavy!". The unit certainly is strikingly heavy, but that also
 gives it a solid and reliable feeling. Review sites on the net claims it
 weights 2.6 oz (~75 grams). (Compare with iPod Nano's 42 grams, or Archos
 Ondio's 60 grams).

<p>
 It can only be charged over USB since there's no other cable provided.

<p> A nice detail is the user replacable battery, which also means the player
 seems easy enough to open up. I'll do that within shortly to get a better
 look of this toy. SanDisk claims the unit does 20 hours run-time.

<p> The scroll wheel, while cool looking since it can glow, feels a bit
 plastic (in the negative sense).

BOXBOT

TITLE(First Impressions Sansa e200 Firmware)
BOXTOP
<a title="Archos Recorder, iriver h140, iAudio X5 and Sansa e200" href="/sansa/sansa3.jpg"><img align="right" src="/sansa/t_sansa3.jpg" border"0" alt="Archos Recorder, iriver h140, iAudio X5 and Sansa e200"></a>

<p> Anyway, after inserting the cable I had troubles getting my computer to
 see the player in UMS mode all the way until I figured out I had to change
 the USB settings on the player which otherwise defaults to MTP mode...

<p> It is a neat little thing. The screen is rotated (220x176 portrait mode
 1.8") and there's a wheel thing that can light up. Both me and Linus liked
 the "WPS scroller" thing the firmware shows in all non-WPS screens when a
 song or radio is on, displaying what's currently playing.

<p> Upgrading the firmware is done with an .exe file and I didn't check just
 yet exactly what it did, but it could figure out the version number of the
 player's firmware and it said "upgrading..." and while it said that the
 player's "connected" screen (which it says while in USB mode) changed to
 "writing".

<p> ... when it completed and I yanked the cable, the player rebooted itself
 and it said "upgrading firmware..." blabla and then rebooted again and came
 up fine.

<p> The player indexed all my (new) music files on boot, and it <b>only</b>
 allows browsing the music using that mode.

<p> It plays MP3, WMA and "secure WMA" according to the manual.

<p> I could also mention that the CD that comes with the player contains the
 user's manual, a windows program for converting images/movies to the player
 (Sansa Media Converter) and Rhapsody which is said to be a "music management
 application".

BOXBOT

TITLE(First Objdumping the Firmware)
BOXTOP
<p>
 To upgrade the player's firmware, you need to run a Windows exe and it stores
four files in the root of the player's file system:
<pre>
  Size   Name
  392248 BL_SD_boardSupportSD.rom
 5420032 PP5022.mi4
     512 VERSION.TXT
     512 version.sdk
</pre>
<p>
<pre>
$ cat VERSION.TXT
Version Info: Product Rev.: PP5022AF-05.51-S301-00.12-S301.00.12A-D
Base Code: 05.51-S301-00.12-S301.00.12A-D
ODM Ver.: S301-00.12-S301.00.12A-D
OEM Ver.: S301.00.12A-D
Build Type: -D
Build Date: 2006.03.29
Build Number: (Build 169.20)
</pre>
<p>
<pre>
$ cat version.sdk
#DO NOT EDIT OR REMOVE THIS FILE

Product: e260
FW: 01.00.12A
Region: America
Build Date: 2006.03.29
Serial:
</pre>

<p> Both the version.* files were padded with zero-bytes to 512 bytes.

<p> During the installation, the installer writes two slightly different .mi4
files to a temp directory. One called SKU_E and one called SKU_A. The SKU_A
one is what gets installed on my player. Possibly America/Europe? Note above
how my player is 'Region: America'.

<p>
 The <b>mi4</b> file seems to be a format commonly used by other (PortalPlayer
based) players. For the fun of it, I compared the Sansa mi4 file with one for
Philips HDD6320, for iriver H10 and for <a
href="http://www.paul.sladen.org/toys/samsung-yh-925/">Samsung-925GS</a> and
they all indeed have many similarities.

<p>
 The BL* files seems to have the ARM exception vectors already at offset 0,
while in the .mi4 ones they start at offset 0x200. (iriver h10 uses BL_H10.rom
and the Samsung uses BL_YH925.rom.)

<p>
 Here's our <a href="sansa/mi4.html">mi4 research page</a>. We've nailed it!

<p>
 BL just have to stand for Boot Loader.

<p> Funny detail: the file name above says PP50<b>22</b>, and the same string
 appears in all the four files. Nowhere does it say <a
href="http://www.portalplayer.com/products/documents/5024_Brief_Mar05.pdf">5024</a>,
although <a
href="http://www.anythingbutipod.com/archives/2006/03/sandisk-sansa-e200-series-review.php">this
anythingbutipod review</a> and <a
href="http://seekingalpha.com/article/9848">this PP conference transcript</a>
claim the e200s feature a 5024. To verify, I pulled it apart and had a look
for myself. "PP5024B-TCF" says the chip markings.

BOXBOT

TITLE(Database details)
BOXTOP
<p>
 Another interesting note on this firmware in comparison with other PP-based
ones: checking the sansa's file system there's a folder called SYSTEM/DATA
that at the time I checked it looked like this:
<pre>
$ ls -l
total 170
-rw-r--r-- 1 user group   8414 Feb 17  1980 PP5000.DAT
-rw-r--r-- 1 user group 144024 Jun 15 09:26 PP5000.HDR
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_@DEV.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_BUYF.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_FNAM.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_FPTH.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_FRMT.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_MGEN.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_MODF.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_MTPF.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_PCNT.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_RATG.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_TALB.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_TCON.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_TIT2.IDX
-rw-r--r-- 1 user group    396 Feb 17  1980 PP5000_TPE1.IDX
</pre>
<p>
 This is clearly the firmware's music/file database. It is <b>strikingly</b>
similar to how the <a
href="http://www.paul.sladen.org/toys/samsung-yh-925/">Samsung YH-925GS</a>
stores it and indeed also as the <a
href="http://solonweb.free.fr/tech.htm">Philips. HDD 100/120</a> does... And
iriver H10, for which there's gathered <a
href="http://www.misticriver.net/wiki/index.php/H10_Database_Specification">db
format documented</a>.

BOXBOT

<p>
 Linked to by this <a href="http://lwn.net/Articles/187662/">LWN article</a>

<p> I intend to update this page as I go.<br>
Updated: __TODAY__ __NOW__ (Central European, Stockholm Sweden)

#include "footer.t"

