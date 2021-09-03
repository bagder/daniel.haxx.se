#include "doctype.t"
<head><title>Daniel Stenberg -- mail till Datateknik, 23 April 2001</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

<p>
 Scroll down to see follow-up.

TITLE(Angående bredbandstestet nr 6 2001)

BOXTOP
<pre>
Date: Mon, 23 Apr 2001 08:27:21 +0200 (MET DST)
From: Daniel Stenberg &lt;daniel at haxx.se&gt;
To: lennart.petterson at et.se
Subject: Angående bredbandstestet, nr 6 2001
&nbsp;
Hejsan
&nbsp;
Det vare med nöje jag läste ert bredbandstest i Datateknik 3.0 nummer 6,
2001.
&nbsp;
Hela testet fick förstås slagsida när jag läste ert påstående (citerat från
tidningen, mellanspalden sid 26): "en ftp-överföring till skillnad från en
http-dito levereras en kontinuerlig ström av data". Hur kan man ta något i ert
test på allvar när ni kan skriva något så plumpt?
&nbsp;
Jag vill påstå att jag har ganska lång erfarenhet av både HTTP och FTP, och
jag har ibland hört den här iden. Det är helt befängd. Kan du/ni förklara på
vilket sätt HTTP är sämre än FTP i prestanda-hänseende? På vilket sätt
levererar HTTP _inte_ data i "en kontinuerlig ström" ? Om ni inte förstår HTTP
eller FTP, varför skriver ni då såhär?
&nbsp;
Vid flera överföringar kommer HTTP att gå snabbare tack vare persistent
connections som FTP inte har. Visst, i HTTP 1.1 infördes en "chunked"
transfer-encoding som faktiskt kan ge en liten extra overhead, men som ju
inte används när servern på förhand vet vilken storlek filen har.
&nbsp;
Ni nämner dessutom att ni gjorde testet med wget, som inte använder HTTP 1.1
och därför faller även det argumentet.
&nbsp;
I sista stycket i artikeln skriver ni "Genomsnittssiffran för samtliga
http-körningar blev 8 Kbyte/s och för ftp 35,8 Kbyte/s". Jag betvivlar inte
alls att det är så, men det är isf pga av ni hämtar många fler mycket mindre
HTTP-dokument, och eftersom samtliga överföringar antagligen räknar in
DNS-uppslagningar etc så tar det förstås längre tid att överföra mindre data.
&nbsp;
Dessutom förvånar det mig inte ifall ni använt en wget-version som inte
stöder persistent connections och då är ju HTTP exakt lika dåligt som FTP.
Oftast är dock HTTP lite snabbare från connect till download eftersom den ju
inte har samma krav på kommando-sekvens som FTP. HTTP använder ju dessutom
bara ett koppel medan FTP använder två.
&nbsp;
Jag hoppas verkligen ni tänker till lite mer i framtiden. Det här var riktigt
klumpigt.
</pre>
BOXBOT

<p>
Lennart replied:
<br>
BOXTOP
<pre>
Date: Tue, 24 Apr 2001 08:27:45 +0200
From: lennart.pettersson at et.se
To: daniel at haxx.se
Subject: Re: Angående bredbandstestet, nr 6 2001
&nbsp;
01-04-23 08.27 skrev daniel@haxx.se:
&nbsp;
> Det vare med nöje jag läste ert bredbandstest i Datateknik 3.0 nummer 6,
> 2001.
&nbsp;
Kul att höra.
&nbsp;
När det gäller din kritik i övrigt så instämmer jag i att det är en slarvig
formulering i artikeln. Det som åsyftas är ju inte protokollen i sig utan de
sätt de normalt används på: http för websurfning (i kartext: många små filer
och ständiga DNS-uppslagningar) respektive ftp för att hämta enstaka stora
filer. Och då ger det senare ett bättre mått på maximala prestanda.
</pre>
BOXBOT

#include "footer.t"

