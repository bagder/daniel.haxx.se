#include "doctype.t"
#define OGDESC "Daniel uses"
#include "setup.t"
#include "daniel.t"
HEAD(Daniel uses)
#include "body.t"

<div class="content">
<p>
See also <a href="computers.html">My computers</a> - <a href="/workplace.html">My workplace</a>

TITLE(Daniel uses)

#define ITEM(x) <tr><td style="background:#e0e0e0;"> x </td>
#define WHICH(x) <td><b> x </b></td></tr>
<p>

<table cellspacing="2" cellpadding="5">

ITEM(Operating System)
WHICH(Linux)

ITEM(Linux Distribution)
WHICH(Debian)

ITEM(Debian flavor)
WHICH(unstable/sid)

ITEM(Mobile Phone System)
WHICH(Android)

ITEM(Mobile Phone)
WHICH(Google Pixel 9 Pro)

ITEM(Linux desktop)
WHICH(KDE Plasma)

ITEM(Display system)
WHICH(X11)

ITEM(Browser)
WHICH(Firefox)

ITEM(Text Editor)
WHICH(Emacs)

ITEM(Interactive shell)
WHICH(bash)

ITEM(Terminal)
WHICH(Konsole)

ITEM(git)
WHICH(command-line)

ITEM(Default compiler)
WHICH(gcc)

ITEM(Preferred debugger)
WHICH(gdb)

ITEM(Keyboard layout)
WHICH(Nordic/Swedish)

ITEM(Private messaging)
WHICH(Signal)

ITEM(Linux email client)
WHICH(Alpine)

ITEM(Phone email client)
WHICH(Aqua mail)

ITEM(Email hosting)
WHICH(Self-hosted)

ITEM(Email server)
WHICH(Postfix)

ITEM(Blog system)
WHICH(Wordpress)

ITEM(Blog hosting)
WHICH(Self-hosted)

ITEM(Mouse)
WHICH(Logitech M500)

ITEM(Keyboard)
WHICH(Logitech G915)

ITEM(...with numerical keypad)
WHICH(No)

ITEM(CPU)
WHICH(Intel Core i7-13700K 5.3GHz)

ITEM(Screens)
WHICH(2: Dell U2720Q + P2715Q)

</table>
</div>

#include "footer.t"
