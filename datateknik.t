#include "doctype.t"
<head><title>Daniel Stenberg -- mail till Datateknik, 23 April 2001</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

<p>
 Scroll down to see follow-up.

TITLE(Ang�ende bredbandstestet nr 6 2001)

BOXTOP
<pre>
Date: Mon, 23 Apr 2001 08:27:21 +0200 (MET DST)
From: Daniel Stenberg &lt;daniel at haxx.se&gt;
To: lennart.petterson at et.se
Subject: Ang�ende bredbandstestet, nr 6 2001
&nbsp;
Hejsan
&nbsp;
Det vare med n�je jag l�ste ert bredbandstest i Datateknik 3.0 nummer 6,
2001.
&nbsp;
Hela testet fick f�rst�s slagsida n�r jag l�ste ert p�st�ende (citerat fr�n
tidningen, mellanspalden sid 26): "en ftp-�verf�ring till skillnad fr�n en
http-dito levereras en kontinuerlig str�m av data". Hur kan man ta n�got i ert
test p� allvar n�r ni kan skriva n�got s� plumpt?
&nbsp;
Jag vill p�st� att jag har ganska l�ng erfarenhet av b�de HTTP och FTP, och
jag har ibland h�rt den h�r iden. Det �r helt bef�ngd. Kan du/ni f�rklara p�
vilket s�tt HTTP �r s�mre �n FTP i prestanda-h�nseende? P� vilket s�tt
levererar HTTP _inte_ data i "en kontinuerlig str�m" ? Om ni inte f�rst�r HTTP
eller FTP, varf�r skriver ni d� s�h�r?
&nbsp;
Vid flera �verf�ringar kommer HTTP att g� snabbare tack vare persistent
connections som FTP inte har. Visst, i HTTP 1.1 inf�rdes en "chunked"
transfer-encoding som faktiskt kan ge en liten extra overhead, men som ju
inte anv�nds n�r servern p� f�rhand vet vilken storlek filen har.
&nbsp;
Ni n�mner dessutom att ni gjorde testet med wget, som inte anv�nder HTTP 1.1
och d�rf�r faller �ven det argumentet.
&nbsp;
I sista stycket i artikeln skriver ni "Genomsnittssiffran f�r samtliga
http-k�rningar blev 8 Kbyte/s och f�r ftp 35,8 Kbyte/s". Jag betvivlar inte
alls att det �r s�, men det �r isf pga av ni h�mtar m�nga fler mycket mindre
HTTP-dokument, och eftersom samtliga �verf�ringar antagligen r�knar in
DNS-uppslagningar etc s� tar det f�rst�s l�ngre tid att �verf�ra mindre data.
&nbsp;
Dessutom f�rv�nar det mig inte ifall ni anv�nt en wget-version som inte
st�der persistent connections och d� �r ju HTTP exakt lika d�ligt som FTP.
Oftast �r dock HTTP lite snabbare fr�n connect till download eftersom den ju
inte har samma krav p� kommando-sekvens som FTP. HTTP anv�nder ju dessutom
bara ett koppel medan FTP anv�nder tv�.
&nbsp;
Jag hoppas verkligen ni t�nker till lite mer i framtiden. Det h�r var riktigt
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
Subject: Re: Ang�ende bredbandstestet, nr 6 2001
&nbsp;
01-04-23 08.27 skrev daniel@haxx.se:
&nbsp;
> Det vare med n�je jag l�ste ert bredbandstest i Datateknik 3.0 nummer 6,
> 2001.
&nbsp;
Kul att h�ra.
&nbsp;
N�r det g�ller din kritik i �vrigt s� inst�mmer jag i att det �r en slarvig
formulering i artikeln. Det som �syftas �r ju inte protokollen i sig utan de
s�tt de normalt anv�nds p�: http f�r websurfning (i kartext: m�nga sm� filer
och st�ndiga DNS-uppslagningar) respektive ftp f�r att h�mta enstaka stora
filer. Och d� ger det senare ett b�ttre m�tt p� maximala prestanda.
</pre>
BOXBOT

#include "footer.t"

