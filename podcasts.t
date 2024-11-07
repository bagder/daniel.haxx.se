#include "doctype.t"
#define OGDESC "Podcasts Daniel has been on"
#include "setup.t"
#include "daniel.t"
HEAD(Podcasts)
#include "body.t"

<style>
tr {
  height: 3em;
}
img {
  height: 2em;
  display: block;
  margin-left: auto;
  margin-right: auto;
}
td {
  background: #f0f0f0;
}

.year {
  font-size: 130%;
  font-style: bold;
  text-align: center;
}

</style>

#define AUDIO <img src="sound.svg">
#define VIDEO <img src="video.svg">

#define ENGLISH En
#define SWEDISH Sv

<div class="content">

#if 0
TITLE(Fossified)
BOXTOP
<p> Since the spring of 2023, I am co-hosting <a
 href="https://fossified.com/">the Fossified podcast</a> series with friends.
BOXBOT
#endif

TITLE(Podcast and show appearances)

<table>

<tr>
<th> # </th>
<th> Episode </th>
<th> Lang </th>
<th> Form </th>
<th> Published </th>
<th> Recorded </th>
<th width="50%"> Topic </th>
</tr>

#if 0
<tr>
<td> 0 </td>
<td> link </td>
<td> language </td>
<td> video </td>
<td> date </td>
<td> topic </td>
</tr>
#endif

<tr><td class="year" colspan="7">2024</td></tr>

<tr>
<td> 50 </td>
<td> <a href="https://hackaday.com/2024/11/06/floss-weekly-episode-808-curl-gotta-download-em-all/">FLOSS Weekly 808</a></td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Nov 7 </td>
<td> Nov 5 </td>
<td> How many curl installs are there?! What's the deal with CVEs? How has curl managed to not break its ABI for 18 years straight? And how did Daniel turn all this into a career instead of just a hobby? </td>
</tr>

<tr>
<td> 49 </td>
<td> <a href="https://kompilator.se/97">Kompilator 97</a></td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Nov 6</td>
<td> Nov 5 </td>
<td> curl, getting the curl.se domain, development, working with Open Source</td>
</tr>

<tr>
<td> 48 </td>
<td> <a href="https://focusonlinux.podigee.io/113-sovereign-tech-fund">Focus on Linux 113</a></td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Aug 16</td>
<td> Aug 1 </td>
<td> curl, Sovereign Tech Fund, funding, sustainability, open source</td>
</tr>

<tr>
<td> 47 </td>
<td> <a href="https://vpetersson.com/podcast/S01E17.html">Nerding out with Viktor #17</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Aug 12</td>
<td> Jul 30 </td>
<td> curl, C64, fun emails, used everywhere, open source sustainability, SBOMs, security</td>
</tr>

<tr>
<td> 46 </td>
<td> <a href="https://changelog.com/friends/49">Changelog and friends #49</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jun 21 </td>
<td> Jun 18 </td>
<td> Daniel Stenberg shares his guiding principles for BDFL'ing curl, gives us his perspective on the state of the internet, talks financial independence, ensuring curl won't be the next XZ & more! </td>
</tr>

<tr>
<td> 45 </td>
<td> <a href="https://corrode.dev/podcast/s02e01-curl/">Rust in Production s02e01</a></td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> May 2 </td>
<td> Feb 23 </td>
<td> on rust (components) in curl</td>
</tr>

<tr>
<td> 44 </td>
<td> <a href="https://kodsnack.se/572/">Kodsnack 572</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Mar 5 </td>
<td> Feb 27</td>
<td> FOSDEM and CVEs</td>
</tr>

<tr><td class="year" colspan="7">2023</td></tr>

<tr>
<td> 43 </td>
<td> <a href="https://opensourcesecurity.io/2023/10/29/episode-399-curl-security-and-daniel-stenberg/">Open Source Security #399</a> </td>
<td> ENGLISH </td>
<td>  AUDIO </td>
<td> Oct 29 </td>
<td> Oct 26</td>
<td> curl, creating software, testing, security, CVEs</td>
</tr>

<tr>
<td> 42 </td>
<td> <a href="https://youtu.be/YQgAc4wlG94?si=3tCS3L_88ZgGbhhm">Coffee with Developers</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Oct 13 </td>
<td></td>
<td> Creating cURL and maintaining the open infrastructure of the web</td>
</tr>

<tr>
<td> 41 </td>
<td> <a href="https://podcast.sustainoss.org/203">Sustain #203</a> </td>
<td> ENGLISH </td>
<td>  AUDIO </td>
<td> Oct 13 </td>
<td> Sep 22</td>
<td> What's wrong with CVEs? Daniel Stenberg of cURL wants you to know</td>
</tr>

<tr>
<td> 40 </td>
<td> <a href="https://youtu.be/ClF0PFXnlFI?si=ZzIW5qkbQ0o4v9HU">Tech Over Tea #185</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Sep 15 </td>
<td> Aug 29</td>
<td> BDFL Of curl & libcurl</td>
</tr>

<tr>
<td> 39 </td>
<td> <a href="https://podcast.sustainoss.org/185">Sustain #185</a> </td>
<td> ENGLISH </td>
<td>  AUDIO </td>
<td> Jun 16 </td>
<td> May 16 </td>
<td> Daniel Stenberg on the cURL project</td>
</tr>

<tr>
<td> 38 </td>
<td> <a href="https://shows.acast.com/63640bb66087460011850610/episodes/64526721efff280011a6c0e8">Svenska Snillen S01E04</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> May 4 </td>
<td> Apr 3</td>
<td> curl, open source and Internet</td>
</tr>

<tr>
<td> 37 </td>
<td> <a href="https://pod.fossified.com/2023/03/19/s01e02.html">Fossified s01e02</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Mar 19 </td>
<td></td>
<td> curl 25 years</td>
</tr>

<tr>
<td> 36 </td>
<td> <a href="https://youtu.be/ZLtqHFxEDm8">Sourcegraph podcast S3E07</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Feb 16 </td>
<td> Jun 27</td>
<td> How I started. Commodore 64 programming, learning unix, doing network programming, f
inding IRC, creating curl.</td>
</tr>

<tr><td class="year" colspan="7">2022</td></tr>

<tr>
<td> 35 </td>
<td> <a href="https://youtu.be/gNWg2Wtxz-w">Fairlight TV #60</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Nov 18 </td>
<td> Nov 15</td>
<td> Commodore 64 hacking as a teenager in the late 80s, the demo group Horizon, copy par
ies, then FrexxEd, unix, curl, HTTP and Polhem Prize</td>
</tr>

<tr>
<td> 34 </td>
<td> <a href="https://kodsnack.se/488/">Kodsnack 488</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Aug 30 </td>
<td> Aug 24</td>
<td> How to run an Open Source project, what to expect, how to manage people, how to deal
 with issues etc.</td>
</tr>

<tr>
<td> 33 </td>
<td> <a href="https://podcasts.google.com/feed/aHR0cHM6Ly9mZWVkcy5zaW1wbGVjYXN0LmNvbS81SnpZcF9LcA/episode/NjVkM2ZhMjQtMDZhZC00MmNlLTllYTQtOWQ3YWI1MDQxZWQw?hl=en-SE&ved=2ahUKEwjejNvp-t75AhXGX_EDHazqDt4QieUEegQIBBAL&ep=6">The FOSS Pod - curl with Daniel Stenberg</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jun 24</td>
<td> Jun 13</td>
<td> History, development, used by everyone</td>
</tr>

<tr>
<td> 32 </td>
<td> <a href="https://www.se-radio.net/2022/03/episode-505-daniel-stenberg-on-25-years-with-curl/">Software Engineering Radio #505</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Mar 30, 2022 </td>
<td> Feb 8</td>
<td> lots of curl</td>
</tr>

<tr>
<td> 31 </td>
<td> <a href="https://trevligmjukvara.se/s10e04/">Trevlig Mjukvara s10e04</a></td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Mar 22 </td>
<td> Mar 17</td>
<td> curl, open source, development, Mozilla</td>
</tr>

<tr>
<td> 30 </td>
<td> <a href="https://anchor.fm/amplifiedandintensified/episodes/57---Daniel-Stenberg-Creator-of-cURL-and-libcurl-e1fdq43">Cybersecurity: Amplified and Intensified #57</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Mar 14 </td>
<td> Mar 8</td>
<td> curl - log4j, making money, supply chain, security, open source, curl support</td>
</tr>

<tr>
<td> 29 </td>
<td> <a href="https://www.softwareatscale.dev/p/software-at-scale-42-daniel-stenberg">Software at Scale 42</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Feb 20 </td>
<td> Nov 18, 2021 </td>
<td> curl </td>
</tr>

<tr><td class="year" colspan="7">2021</td></tr>

<tr>
<td> 28 </td>
<td> <a href="https://www.almsec.se/inside-security-17-interview-with-curl-creator-daniel-stenberg/">Inside Security #17</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Oct 20</td>
<td></td>
<td> The story of curl and more</td>
</tr>

<tr>
<td> 27 </td>
<td> <a href="https://youtu.be/X5SGO8cUG8o">Eddie Jaoude's livestream</td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Oct 11</td>
<td></td>
<td> Open source project Curl, geek out with the creator Daniel Stenberg</td>
</tr>

<tr>
<td> 26 </td>
<td> <a href="https://popcast-d9f7b6dc.simplecast.com/episodes/episode-81-total-recurl-with-curl-founder-daniel-stenberg">The Popcast - Episode 81 - Total ReCURL</a> </td>
<td> ENGLISH </td>
<td> VIDEO </td>
<td> Sep 8 </td>
<td></td><td> curl, how I got into computers [<a href="https://www.youtube.com/watch?v=PaA95jWPJ-M">video</a>]</td>
</tr>

<tr>
<td> 25 </td>
<td> <a href="https://rustacean-station.org/episode/035-daniel-stenberg/">The Rustacean Station Podcast #35</a></td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Sep 3 </td>
<td></td>
<td> curl, rust, memory safety, development </td>
</tr>

<tr>
<td> 24 </td>
<td> <a href="https://github.com/readme/curl-25-years">The ReadME Podcast #8</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jun 22 </td>
<td></td>
<td> life as a maintainer, curl, open source and development </td>
</tr>

<tr>
<td> 23 </td>
<td> <a href="https://anchor.fm/barcoding/episodes/Episode-18---Curl-the-ins-and-outs-on-developing-a-world-wide-used-command-line-tool-e11i636">Barcoding 18</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> May 25 </td>
<td></td>
<td> curl and open source </td>
</tr>

<tr>
<td> 22 </td>
<td> <a href="https://www.changelog.com/podcast/436">Changelog 436</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Mar 29 </td>
<td></td>
<td> curl, life, development, HTTP/3 </td>
</tr>

<tr><td class="year" colspan="7">2020</td></tr>
<tr>
<td> 21 </td>
<td> <a href="https://blog.firosolutions.com/2020/09/security-headlines-curl-special/">Security Headlines Podcast curl special</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Sep 18 </td>
<td></td>
<td> curl, development, HTTP/3 </td>
</tr>

<tr>
<td> 20 </td>
<td> <a href="https://foss-north.se/pod/episodes.html#ep12">foss-north #13</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jul 19 </td>
<td></td>
<td> the curl license - part 2 </td>
</tr>

<tr>
<td> 19 </td>
<td> <a href="https://foss-north.se/pod/episodes.html#ep12">foss-north #12</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jul 19 </td>
<td></td>
<td> the curl license - part 1 </td>
</tr>

<tr>
<td> 18 </td>
<td> <a href="https://digitalsamtal.se/215-mot-curl-verktyget-du-anvander-varje-dag/">Digitalsamtal 215</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Feb 19 </td>
<td></td>
<td> curl, open source, sustainability, balance </td>
</tr>

<tr><td class="year" colspan="7">2019</td></tr>
<tr>
<td> 17 </td>
<td> <a href="https://kodsnack.se/331/">Kodsnack 331</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Sep 24 </td>
<td></td>
<td> curl, development, HTTP/3, protocols and more </td>
</tr>

<tr>
<td> 16 </td>
<td> <a href="https://kompilator.se/008/">Kompilator 8</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Apr 24 </td>
<td></td>
<td> HTTP/2 and HTTP/3 </td>
</tr>

<tr>
<td> 15 </td>
<td> <a href="https://kompilator.se/005/">Kompilator 5</a> </td>
<td> SWEDISH  </td>
<td> AUDIO </td>
<td> Apr 3 </td>
<td></td>
<td> curl, the Polhem prize and more </td>
</tr>

<tr><td class="year" colspan="7">2018</td></tr>
<tr>
<td> 14 </td>
<td> <a href="https://changelog.com/podcast/299">Changelog 299</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> May 31 </td>
<td></td>
<td> curl turning 20 years old, HTTP/2 and QUIC </td>
</tr>

<tr>
<td> 13 </td>
<td> <strike><a href="https://www.vuc.me/2018/vision-4-daniel-stenberg-curl/">Visions under construction, vision 4</a></strike></td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jan 26 </td>
<td></td>
<td> curl and open source </td>
</tr>

<tr><td class="year" colspan="7">2017</td></tr>

<tr>
<td> 12 </td>
<td> <a href="https://archive.org/details/LinuxpoddenAvsnitt47">Linuxpodden 47</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Nov 5 </td>
<td></td>
<td> curl and related stuff </td>
</tr>

<tr>
<td> 11 </td>
<td> <a href="https://juneday.podbean.com/e/interview-with-daniel-stenberg/">Juneday Interview </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Sep 14 </td>
<td></td>
<td> </td>
</tr>

<tr>
<td> 10 </td>
<td>  <a
href="https://radiopublic.com/between-screens-podcast-6nkdZ8/ep/s1!7f407">Between
screens 146</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jan 23 </td>
<td></td>
<td> curl, open source, the future and more. </td>
</tr>

<tr><td class="year" colspan="7">2016 and earlier</td></tr>

<tr>
<td> 9 </td>
<td>  <a href="https://ma.ttias.be/syscast/4-curl-libcurl-future-web-daniel-stenberg/">Syscast 4</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jun 22, 2016 </td>
<td></td>
<td>  curl, open source, QUIC and more. </td>
</tr>

<tr>
<td> 8 </td>
<td> <a href="https://kodsnack.se/120/">Kodsnack 120</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Sep 15, 2015 </td>
<td></td>
<td> HTTP/2 </td>
</tr>

<tr>
<td> 7 </td>
<td> <a href="https://changelog.com/podcast/153">Changelog 153</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> May 1, 2015 </td>
<td></td>
<td> curl turning 17 years old </td>
</tr>

<tr>
<td> 6 </td>
<td> <a
href="https://packetpushers.net/podcast/show-224-http2-its-the-biggest-network-thing-happening-on-the-internet-today-repost/">Packet Pushers 224</a>  </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Feb 19, 2015 </td>
<td></td>
<td> HTTP/2 </td>
</tr>

<tr>
<td> 5 </td>
<td> <a href="https://web.archive.org/web/20210514235230/https://player.fm/series/ping/ping-10-80-talets-copyparty-blev-dagens-lan-party-gst-daniel-stenberg-2013-10-31"">Ping 10</a> </td>
<td> SWEDISH </td>
<td> AUDIO </td>
<td> Oct 31, 2013 </td>
<td></td>
<td> Open Source, curl, C64, copy parties etc</td>
</tr>

<tr>
<td> 4 </td>
<td> <a href="https://web.archive.org/web/20101113201108/http://knowledgecaps.com/2009/11/29/open-sourcehow-to-get-involved/">KnowledgeCapsule: How to get involved</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Dec 1, 2009 </td>
<td></td>
<td> How to get involved in Open Source</td>
</tr>

<tr>
<td> 3 </td>
<td> <a href="https://twit.tv/shows/floss-weekly/episodes/51">FLOSS weekly 51</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Jan 10, 2009 </td>
<td></td>
<td> the curl project </td>
</tr>

<tr>
<td> 2 </td>
<td> <a href="https://web.archive.org/web/20090226005247/http://knowledgecaps.com/2008/08/29/fos-fresh-online-servicesftp-vs-http/">KnowledgeCapsule: FTP vs HTTP</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> Aug 29, 2008 </td>
<td></td>
<td> FTP vs HTTP </td>
</tr>

<tr>
<td> 1 </td>
<td> <a href="https://web.archive.org/web/20090221024201/http://knowledgecaps.com/2008/07/18/fos-fresh-online-servicescurl/">KnowledgeCapsule: cURL</a> </td>
<td> ENGLISH </td>
<td> AUDIO </td>
<td> July 18, 2008 </td>
<td></td>
<td> curl and Rockbox </td>
</tr>

</table>
</div>

#include "footer.t"
