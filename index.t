#include "doctype.t"
#include "setup.t"

HEAD(Daniel Stenberg - daniel.haxx.se)
#include "body.t"
#include "daniel.t"

#define LINK(url,name) <a href="url">name</a>
#define MELINK(url,name) <a rel="me" href="url">name</a>

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
href="https://github.com/bagder/">my GitHub profile</a>. <a
href="my-name-in-products.html">My name appears in products</a>.

<p> <b>I participate</b> within the <a href="http://www.ietf.org/">IETF</a>,
primarily in the HTTPbis and QUIC working groups.

<p> <b>I speak</b> in public <a href="talks.html">every now and then</a>.

<p> <b>I stream</b> <a href="https://www.twitch.tv/curlhacker">curl
development on twitch</a> occasionally.

<p> <b>I work</b> for <a href="https://www.wolfssl.com/">wolfSSL</a> doing
commercial curl support. If you need help to fix curl problems, fix your app's
use of libcurl, add features to curl, fix curl bugs, optimize your curl use or
libcurl education for your developers... Then I'm your man. Contact us!

<p> <b>I write</b> <a href="https://lists.haxx.se/listinfo/daniel">weekly reports</a> you can follow

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
MELINK("https://csdb.dk/scener/?id=8084", CSDb) |
MELINK("https://www.facebook.com/stenberg.daniel", Facebook) |
MELINK("https://github.com/bagder/", GitHub) |
MELINK("https://stars.github.com/profiles/bagder/", GitHub Star) |
MELINK("https://www.internetmuseum.se/tidslinjen/curl-grundaren-daniel-stenberg-skapar-internets-budbarare/", Internetmusem) |
MELINK("https://keybase.io/bagder", Keybase) |
MELINK("https://www.linkedin.com/in/danielstenberg", LinkedIn) |
MELINK("https://mastodon.social/@bagder", Mastodon) |
MELINK("https://www.openhub.net/accounts/bagder", openhub) |
MELINK("https://www.slideshare.net/bagder/presentations", Slideshare) |
MELINK("https://stackoverflow.com/users/93747/daniel-stenberg", stackoverflow) |
MELINK("https://www.twitch.tv/curlhacker", Twitch) |
MELINK("https://twitter.com/bagder", twitter) |
MELINK("https://en.wikipedia.org/wiki/Daniel_Stenberg", Wikipedia) |
MELINK("https://www.youtube.com/user/danielhaxxse/", Youtube)

BOXBOT
</div>


#include "footer.t"
