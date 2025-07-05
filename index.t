#include "doctype.t"
#include "setup.t"

HEAD(Daniel Stenberg)
#include "body.t"
#include "daniel.t"

#define LINK(url,name) <a href="url">name</a>
#define MELINK(url,name) <a rel="me" href="url">name</a>

<style>
div.minibox {
    padding: 5px 15px 5px 15px;
    margin: 0px 5px 10px 0px;
    border: 2px solid black;
    text-align: center;
    position: relative;
    border-radius: 35px;
    float: left;
    font-size: 80%;
    width: 10em;
    height: 4em;
    background: #202060;
}

a.minibox {
    color: #ffff80;
}

.rand {
    float: left;
    margin-left: 20px;
}

.talk {
    float: left;
    width: 25em;
    max-width: 95%;
}

.elsewhere {
    padding-top: 10px;
    clear: both;
}

    .daniel {
      border: 3px solid black;
      margin: 30px 30px 30px 30px;
      padding: 10px;
      float: right;
    }

@media screen and (max-width: 480px) {
    .daniel {
      max-width: 150px;
      max-height: 150px;
      border: 0px solid black;
      margin: 5px 5px 5px 5px;
      padding: 0px;
      float: right;
    }
    .nophone {
      display: none;
    }
    div.minibox {
        margin-right: 2px;
        margin-left: 2px;
        border: 0px solid black;
        text-align: center;
        border-radius: 25px;
        float: left;
        font-size: 80%;
        max-width: 10em;
        background: #202060;
    }
}
@media (prefers-color-scheme: dark) {
    div.minibox {
        background: #e0e0ff;
    }
    a.minibox {
        color: #0000ff;
    }
}
</style>

<div class="content">

TITLE(Daniel Stenberg)
#if 0
<p style="max-width: 30em; text-align: center; font-size: 120%; margin-left: auto;
margin-right: auto;"> <i>One of life's greatest sources of satisfaction is the
knowledge that something you have created is contributing to the progress or
welfare of society</i> / Donald Knuth
</p>
#endif
<img class="daniel" src="final-12-400-gray.jpg" width=400 height=400 alt="Daniel Stenberg">

<p> <b>I am</b> the founder and lead developer of <a
href="https://curl.se/">cURL and libcurl</a>. An internet protocol geek, an
Open Source person and a developer.

<p><b>I create</b> software. You find information about my various <a
href="opensource.html">Open Source projects</a> on these web pages and on <a
href="https://github.com/bagder/">my GitHub profile</a>.

<p> <b>I participate</b> within the <a href="http://www.ietf.org/">IETF</a>,
primarily in the HTTPbis and QUIC working groups.

<p> <b>I speak</b> in public <a href="talks.html">every now and then</a>.
#if 0
and podcast on <a href="https://github.com/fossified/podcast">Fossified</a>
#endif

<p> <b>I stream</b> <a href="https://www.twitch.tv/curlhacker">curl
development on twitch</a> occasionally.

<p> <b>I work</b> <a href="job.html">full-time on curl</a> from <a
href="workplace.html">home</a>.

<p> <b>I write</b> <a href="https://lists.haxx.se/listinfo/daniel">weekly email reports</a> you can read. Almost like a newsletter.

<p> <b>I receive</b> a fair amount of <a href="/email/">curious emails</a>. <a
href="my-name-in-products.html">My name appears in many products</a>.

<div style="clear: both;"/>
SUBTITLE(Committees)
<ul>
 <li> <a href="https://europeanopensource.academy/">The European Open Source Academy</a>
 <li> <a href="https://daniel.haxx.se/blog/2023/05/24/polhemsradet/">Polhemsrådet</a>
</ul>

</div>

<div style="clear: both;"/>
SUBTITLE(Recognition)

<div>

<div class="minibox">
<a class="minibox" href="https://daniel.haxx.se/blog/2025/02/03/european-open-source-achievement-award/">European Open Source Achievement Award 2025</a>
</div>

<div class="minibox">
<a class="minibox" href="https://daniel.haxx.se/blog/2024/10/02/im-a-professional/">Microsoft Most Valuable Professional 2024</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2021/08/11/a-github-star/">GitHub Star 2021 - 2025</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2021/04/19/mars-2020-helicopter-contributor/">Mars Helicopter Contributor 2021</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2020/09/23/a-google-grant-for-libcurl-work/">Google Patch Reward 2020</a>
</div>

<div class="minibox">
 <a class="minibox"
 href="https://daniel.haxx.se/blog/2017/10/20/my-night-at-the-museum/">The Polhem
 Prize 2017</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2016/12/01/2nd-best-in-sweden/">Second best developer in Sweden 2016</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2024/05/24/google-peer-bonus-number-five/">5 times Google Open Source Peer Bonus 2011 - 2024</a>
</div>

<div class="minibox">
 <a class="minibox" href="https://daniel.haxx.se/blog/2009/11/14/i-won-it-you-guys-are-the-best/">Nordic Free Software Award 2009</a>
</div>

</table>

<div style="clear: both;"/>

<div class="talk">
#include "talk.inc"
</div>

<div class="rand">
SUBTITLE(rand&#40;&#41;)
 LINK("http://www.haxx.se/matrix/", Matrix Maker)
<br> LINK("/computers.html", My computers)
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
MELINK("https://mvp.microsoft.com/en-US/MVP/profile/8ec06c9e-b9d0-4bd8-a19c-0a3f819aa637", Microsoft MVP) |
MELINK("https://www.openhub.net/accounts/bagder", openhub) |
MELINK("https://www.slideshare.net/bagder/presentations", Slideshare) |
MELINK("https://stackoverflow.com/users/93747/daniel-stenberg", stackoverflow) |
MELINK("https://www.twitch.tv/curlhacker", Twitch) |
MELINK("https://en.wikipedia.org/wiki/Daniel_Stenberg", Wikipedia) |
MELINK("https://www.youtube.com/user/danielhaxxse/", Youtube)

BOXBOT
</div>

</div>

#include "footer.t"
