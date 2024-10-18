#include "doctype.t"
#include "setup.t"
HEAD(SSH Over Proxy)
#include "body.t"
#include "daniel.t"

<div class="content">
Related pages: <a href="http://shsc.info/SSHThroughHTTPProxy">SSHThroughHTTPProxy</a>
<p>

TITLE(SSH Through or Over Proxy)

<p>
 In today's cruel networked world, we're too often hampered behind (evil)
company proxies that restricts how we can use the internet while at work, at a
customers' place or even in some cases while at home or at friends'.

<p> Not only do proxies restrict what you can do, what protocols that are
 accepted, what sites you can visit and what TCP ports that are let through,
 it also allows your company or friend to log and supervise you.

<p> <b>Note</b> that even when you use HTTPS through the proxy, the server
 name is exposed so a logging proxy will see what HTTPS servers you connect
 to.

<p>
 I'll show you some easy steps that help you circumvent the boundaries of most
 proxy setups, and that also will bring you more freedom and prevent peeking
 eyes to investigate your browsing habits!


SUBTITLE(What You Need)

<p> You need software installed and running in a location outside of where you
 are. I call that place 'home' in this document.

<p> The place you want to get out <i>from</i> is what I call 'work' in this
 document. At 'work' you're behind the evil proxy.

SUBTITLE(At Home)

<p> <b>You need a HTTP proxy running</b>, and you really only need it to
accept connections to proxy from localhost. Lots of people already have an
Apache running and making it load the proxy module and configure it for
localhost is very easy and quickly done. Of course you can opt for another
proxy software, such as squid if you prefer that. In this example, we assume
that the proxy runs on port 80 - the same as the typical apache install uses.

<p> You may want to enable HTTPS and FTP and other protocols in the proxy
config.

<p> <b>You need sshd running on port 443</b>. Almost everyone already have
sshd running already, you just need to make it also listen for connections on
port 443. 443 is typically used for HTTPS and that's why we use it - most
proxies are configured to allow connections to 443 since companies want to
allow their employees to be able to use banks and other HTTPS web services on
the net.

<p> Perhaps needless to say, but you must make sure that your Apache or other
httpd server doesn't use the 443 port for HTTPS.

SUBTITLE(At Work)
<center><img src="sshproxy.jpg" alt="picture trying to show the desrcibed scenario" title="picture trying to show the desrcibed scenario"></center>

<p> You need an SSH client that can issue CONNECT requests through the company
HTTP proxy. If you're on Windows, using <a
href="http://www.chiark.greenend.org.uk/~sgtatham/putty/">Putty</a> is fine as
it has built-in support for tunneling through a HTTP proxy. If you're on
unix/linux (or cywgin) you can use <a
href="http://www.openssh.org/">openssh</a> with <a
href="http://www.agroman.net/corkscrew/">corkscrew</a> to go through the proxy
to your home computer's port 443.

<p> If using openssh, you'd add the following line to your
<tt>~/.ssh/config</tt> file:

<div class="grey">
<pre>
ProxyCommand /usr/local/bin/corkscrew proxy.work.com 80 %h %p
</pre>
</div>

<p> You config the ssh client to <b>port-forward a local port</b>, say 8080,
to the remote's localhost:80. Now you have a channel established to your home
computer, over a securely encrypted connection. Of course you also get a SSH
login and you can start your X-programs from home to pop up at work etc...

<div class="grey">
<p> The openssh command line to connect and port-foward the proxy could then look like this:
<p>
<tt>
ssh -L 8080:localhost:80 user@server.at.home -p 443
</tt></div>

<p> <b>Configure your browser</b> at work to use "localhost:8080" as proxy, for
all the protocols you have enabled in your proxy at home.

<p> All subsequent browser requests are then sent over the SSH connection,
through the proxy, to the ssh server at home and from there to your proxy, and
out in the world...

SUBTITLE(The SOCKS proxy way)
<p>
 Instead of running a HTTP proxy at home to reach the internet with, you can
use the tunnel as a SOCKS proxy. This basically allows you to not run anything
at all at home apart from the ssh server.

<p>
If you have openssh in both ends, you can opt to use this simpler approach. It
lets you fire up the tunnel to your home machine and use that tunnel as a
SOCKS proxy rather than using a HTTP one at the other end of the tunnel. This
way, you don't need to run any other software at home than the ssh server
itself.

<div class="grey">
<p>
 You can start up the tunnel/SOCKS proxy from the work side by issuing a
command like:
<p>
<tt>
ssh -D 8080 user@server.at.home -p 443
</tt></div>
<p>
 You may still need the "ProxyCommand" line mentioned above to make sure your
ssh client can reach your ssh server at home.

<p>
 Subsequently, you need to configure your work browser to use the SOCKS proxy
now running at localhost port 8080.

SUBTITLE(Without CONNECT)
<p>
 For cases when CONNECT is not allowed to port 443 of your home computer, you
can of course try another port - if any at all are allowed, and then you may
need to move your proxy/web server from 80 if that's the only way for you.

<p> If you cannot find any useful port or if CONNECT is not allowed at all,
you need to establish a tunnel using normal HTTP, using for example <a
href="https://tools.kali.org/maintaining-access/httptunnel">httptunnel</a>.
httptunnel is a client/server application, and you want the server ("hts") to
run on your home computer, listening on port 80, and you run the client
("htc") on your work computer setting up the tunnel.

<div class="grey">
<p>
At home, take an incoming connection on port 80 and forward it to port 22 (ssh):
<pre>
hts -F localhost:22 80
</pre>
</div>

<div class="grey">
<p>
At work, connect to home over the company proxy and forward a local port (8022
in this example) to SSH to home over:

<pre>
htc -P proxy.corp.com:80 -F 8022 server.at.home:80
</pre>
</div>

SUBTITLE(Additional Comments)
<p>
 For other protocols you can of course just make sure that your work-ssh
session forwards more ports to your home machine. It then differs between the
protocols how you get them to work. If you want to IRC at work through this
setup, you need a "IRC bouncer" (like <a href="http://muh.sf.net/">muh</a>)
running on your home machine since IRC cannot work properly otherwise.

<p>
 For cases when your work doesn't actually lock you behind a proxy, you can
still use this approach (although you can skip the part with doing CONNECT and
your home computer doesn't have to run ssh on port 443) to prevent your work
admins from snooping on your network traffic.

<p>
 Changelog: I added the SOCKS proxy details in June 2010.

</div>

#include "footer.t"

