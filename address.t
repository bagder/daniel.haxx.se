#include "doctype.t"
#include "setup.t"
#include "daniel.t"
HEAD(daniel.haxx.se -- Daniel Stenberg)
#include "body.t"

<style>
@media screen and (max-width: 480px) {
    img {
      max-width: 50%;
      max-height: 82px;
    } 
}
</style>


TITLE(Contact me)
BOXTOP
<p>

 If you want to contact me for asking technical questions, media reasons,
recruiting, arranging presentations, offering me money or any other reason
where you want to reach me privately: I prefer if you <b>send me an email</b>
and tell me what you want. Once done, we can arrange for other means of
communications.

<p>
<img src="my-email.png" alt="daniel at haxx dot se" />

<p> If you want me to do a presentation, chances are I will happily do so, but
 <a href="how-to-invite-me.html">do not assume that I can do so free of
 charge</a>!

SUBTITLE(Physical address)
<p>
<table cellpadding=10><tr><td valign="top">
<b>Daniel Stenberg
<br> Lindm&auml;tarv&auml;gen 22
<br> 141 37 Huddinge
<br> Sweden</b>
</td><td valign="top">
<b>Position:</b><br>
Longitude: 18.02372314245376<br>
Latitude: 59.24582691715614

</td></tr></table>

SUBTITLE(Other means)
<p>
Twitter: <a href="https://twitter.com/bagder">@bagder</a><br>
IRC: 'bagder' on libera.chat - in the #curl channel primarily.

SUBTITLE(Public Key)
<p>

My <a
href="https://pgp.mit.edu/pks/lookup?search=daniel%40haxx.se&op=index">GPG
key</a> as of April 7th, 2016: <a href="/mykey.asc">mykey.asc</a>

#if 0
<p>
 My previous one <a href="/old-mykey.asc">old-mykey.asc</a> (if you for any
reason need it)
#endif

<p>
 I typically sign at least all releases of <a
href="https://curl.se/">curl</a>, <a
href="https://www.libssh2.org/">libssh2</a> and <a
href="https://c-ares.haxx.se/">c-ares</a> using this key.

BOXBOT

#include "footer.t"
