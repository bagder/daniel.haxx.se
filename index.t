#include "doctype.t"
#include "setup.t"

HEAD(Daniel Stenberg - daniel.haxx.se)
#include "body.t"
#include "daniel.t"

#define LINK(url,name) <a href="url">name</a>

<style>
div.minibox {
    padding: 5px 15px 5px 15px;
    margin-right: 10px;
    margin-bottom: 10px;
    margin-top: 10px;
    border: 1px solid black;
    text-align: center;
    border-radius: 25px;
    float: left;
    font-size: 110%;
    max-width: 10em;
}

.rand {
    float: left;
    margin-right: 20px;
    margin-left: 20px;
}

.talk {
    float: left;
    width: 30%;
}

.elsewhere {
    float: left;
    width: 30%;
}

    .daniel {
      border: 3px solid black;
      margin: 30px 30px 30px 30px;
      padding: 10px;
      float: right;
    } 
@media screen and (max-width: 480px) {
    .daniel {
      max-width: 50%;
      max-height: 250px;
      border: 1px solid black;
      margin: 10px 10px 10px 10px;
      padding: 0px;
      float: right;
    } 
}
</style>

<img class="daniel" src="final-12-400-gray.jpg" width=400 height=400 alt="Daniel Stenberg">

TITLE(Daniel Stenberg)

<p> <b>I am</b> the founder and lead developer of <a
href="https://curl.se/">cURL and libcurl</a>. An internet protocol geek, an
open source person and a developer. I've been programming for fun and profit
since 1985. You'll find lots of info about my various <a
href="projects/">projects</a> on these web pages and on <a
href="https://github.com/bagder/">my GitHub profile</a>.

<p> <b>I participate</b> within the <a href="http://www.ietf.org/">IETF</a>,
primarily in the HTTPbis and QUIC working groups.

<p> <b>I speak</b> in public <a href="talks.html">every now and then</a>.

<p> <b>I stream</b> <a href="https://www.twitch.tv/curlhacker">curl
development on twitch</a> occasionally.

<p> <b>I live</b> and work in <a href="address.html">Huddinge</a>, just south
of Stockholm, Sweden.

<p> <b>I treasure</b> my wife and two kids.

<p> <b>I work</b> for <a href="https://www.wolfssl.com/">wolfSSL</a> doing
commercial curl support. If you need help to fix curl problems, fix your app's
use of libcurl, add features to curl, fix curl bugs, optimize your curl use or
libcurl education for your developers... Then I'm your man. Contact us!

<p> My <a href="https://bagder.github.io/log/">weekly reports</a> can be <a href="https://github.com/bagder/log/discussions">commented</a>.

<div style="clear: both;"/>
SUBTITLE(Rewards)

<table><tr valign="top">
<td> <img src="trophy.svg" height="120"> </td>
<td>

<div class="minibox">
 <a href="https://daniel.haxx.se/blog/2021/08/11/a-github-star/">GitHub Star 2021 - 2022</a>
</div>

<div class="minibox">
 <a href="https://daniel.haxx.se/blog/2020/09/23/a-google-grant-for-libcurl-work/">Google Patch Reward 2020</a>
</div>

<div class="minibox">
 <a href="https://daniel.haxx.se/blog/2020/04/03/google-open-source-peer-bonus-award-2020/">Google Open Source Peer Bonus 2020</a>
</div>

<div class="minibox">
 <a
 href="https://daniel.haxx.se/blog/2017/10/20/my-night-at-the-museum/">The Polhem
 Prize 2017</a>
</div>

<div class="minibox">
 <a href="https://daniel.haxx.se/blog/2016/12/01/2nd-best-in-sweden/">2nd best developer in Sweden 2016</a>
</div>

<div class="minibox">
 <a href="https://daniel.haxx.se/blog/2009/11/14/i-won-it-you-guys-are-the-best/">Nordic Free Software Award 2009</a>
</div>

</td></tr></table>

<div style="clear: both;"/>

<div class="talk">
#include "talk.inc"
</div>

<div class="rand">
SUBTITLE(rand&#40;&#41;)
<p>
 LINK("/docs/", docs)
<br> LINK("http://www.haxx.se/matrix/", Matrix Maker)
<br> LINK("/computers.html", my computers)
#if 0
<br> LINK("/stuff/", old code)
<br> LINK("/hexpoetry/", hexadecimal poetry)
<br> LINK("/travel/", travel stuff)
LINK("/http2/", http2 explained) - the HTTP/2 book
<br> LINK("/myopensource.html", my open projects) - projects I am or was involved with
<br> LINK("/skills.html", CV) - a short description of what I know
<br> LINK("/rockbox-sandisk-connection.html", Rockbox SanDisk Connection) - the story behind
<br> LINK("/opensource.html", open source) - old post by me on what it takes to do open source
<br> LINK("/photos/", photos) - random photos from the past
<br> LINK("/transition.html", &quot;Working Without Copyleft&quot;) - the article
#endif
</div>

<div class="elsewhere">

SUBTITLE(Me elsewhere)
<p>
LINK("https://www.facebook.com/stenberg.daniel", Facebook) |
LINK("https://github.com/bagder/", GitHub) |
LINK("https://www.internetmuseum.se/tidslinjen/curl-grundaren-daniel-stenberg-skapar-internets-budbarare/", Internetmusem) |
LINK("https://keybase.io/bagder", Keybase) |
LINK("https://www.linkedin.com/in/danielstenberg", LinkedIn) |
LINK("https://mastodon.social/@bagder", Mastodon) |
LINK("https://www.openhub.net/accounts/bagder", openhub) |
LINK("https://www.slideshare.net/bagder/presentations", Slideshare) |
LINK("https://stackoverflow.com/users/93747/daniel-stenberg", stackoverflow) |
LINK("https://www.twitch.tv/curlhacker", Twitch) |
LINK("https://twitter.com/bagder", twitter) |
LINK("https://en.wikipedia.org/wiki/Daniel_Stenberg", Wikipedia) |
LINK("https://www.youtube.com/user/danielhaxxse/", Youtube)

BOXBOT
</div>


#include "footer.t"
