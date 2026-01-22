#include "doctype.t"
#define OGDESC "How to contact Daniel"
#include "setup.t"
#include "daniel.t"
HEAD(daniel.haxx.se -- Daniel Stenberg)
#include "body.t"

<div class="content">
TITLE(Contact me)
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

SUBTITLE(Geolocation)

<p> I live and work in Sweden in the Central European time zone. UTC + 1 in
 winters, UTC + 2 in summers.

SUBTITLE(Other means)
<p>
#if 0
Twitter: <a href="https://twitter.com/bagder">@bagder</a><br>
#endif
Mastodon: <a href="https://mastodon.social/@bagder">@bagder@mastodon.social</a><br>
IRC: 'bagder' on libera.chat - in the #curl channel primarily.<br>
Signal: yes

SUBTITLE(Public Key)
<p>

My <a href="https://keys.openpgp.org/search?q=daniel@haxx.se">PGP key</a> as
of April 7th, 2016: <a
href="/mykey.asc">27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2</a>

<p> I typically sign releases of <a href="https://curl.se/">curl</a> and <a
 href="https://www.libssh2.org/">libssh2</a> using this key.

</div>

#include "footer.t"
