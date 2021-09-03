<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
#include "doctype.t"
<head><title>Working Without Copyleft</title>
<link rel="STYLESHEET" type="text/css" href="/daniel.css">
<meta content="text/html; charset=ISO-8859-1" http-equiv="Content-Type">
</head>
#include "body.t"
#include "setup.t"
#include "daniel.t"

<p>
 This is the original article <a
href="http://www.oreillynet.com/pub/a/policy/2001/12/12/transition.html">O'Reilly
published</a> on the 20th of December 2001. The O'Reilly one is slightly
edited.

<p>
<div class="titlepage">
<div><h2 class="title">
<a name="id2708141"></a>Working Without Copyleft</h2></div>
<div>
<h3 class="author">Bjørn Reese</h3>
<h3 class="author">Daniel Stenberg</h3>
</div>
<div><p class="copyright">Copyright © 2001 Bjørn Reese and Daniel Stenberg</p></div>
<div><div class="legalnotice">
This paper does not offer any legal advice.
 </div></div>
<hr>
</div>
<div class="section">
<a name="id2708202"></a><div class="titlepage"><div><h2 class="title" style="clear: both">
<a name="id2708202"></a>Introduction</h2></div></div>
<p>
We come in praise of voluntary contributions.
</p>
<p>
As the open source
<sup>[<a name="id2708215" href="#ftn.id2708215">1</a>]</sup>
phenomenon has manifested itself as a viable development model, commercial
corporations
<sup>[<a name="id2708265" href="#ftn.id2708265">2</a>]</sup>
should excogitate their position on the open source development
model, and the open source community should do vice versa.
Those who learn to cooperate will benefit the most.
We believe that this cooperation should be based on mutually acceptable terms,
and that the best basis is voluntary contributions.
</p>
<p>
We see
<a href="http://www.gnu.org/copyleft/copyleft.html" target="_top">
 <i>copyleft</i>
</a>
as a hindrance to this cooperation, as it only addresses the concerns of one
side.
It is our impression that copyleft licenses are selected much too often due to
an unfounded fear of exploitation by commercial corporations.
In the following we will explain why we choose not to release our open source
software under a copyleft license.
</p>
<p>
It is important to understand that we are not arguing against copyleft
per se; that we acknowledge the role of copyleft as a catalyst, and that we
believe that there continues to be a place for copyleft.
Instead we are arguing that copyleft should not be the default choice when
open source projects select a license; there are many different reasons for
contributing to open source software, and that these reasons should be
respected to the largest extend possible.
</p>
</div>
<div class="section">
<a name="id2708226"></a><div class="titlepage"><div><h2 class="title" style="clear: both">
<a name="id2708226"></a>The Transition</h2></div></div>
<table border="0" width="100%" cellspacing="0" cellpadding="0" class="blockquote" summary="Block quote">
<tr>
<td width="10%" valign="top"> </td>
<td width="80%" valign="top"><p>
The changes in our life must come from the impossibility to live otherwise
than according to the demands of our conscience [...] not from our mental
resolution to try a new form of life.
</p></td>
<td width="10%" valign="top"> </td>
</tr>
<tr>
<td colspan="2" align="right" valign="top">--<span class="attribution">Leo Tolstoy (1828-1910)
</span>
</td>
<td width="10%" valign="top"> </td>
</tr>
</table>
<p>
When we started contributing to the open source community nearly a decade ago,
we put all our source code under the
<a href="http://www.gnu.org/copyleft/gpl.html" target="_top">
 <i>GNU General Public License</i>
</a>
(GPL), because
it was widely used and we somehow felt that the concept of
&quot;software freedom&quot; was important.
As software developers we were especially enchanted by the idea of unlimited
access to source code, as it provided an unparallelled opportunity to learn
from others.
Furthermore, we liked the protection against exploitation from commercial
corporations, and we felt it was only fair to expect that whoever modified or
expanded our software should return those changes;
<i>quid pro quo</i>
<sup>[<a name="id2708915" href="#ftn.id2708915">3</a>]</sup>.
</p>
<p>
When we initially chose the GPL as the license of our
projects, we did not fully comprehend the implications it had, and that we
were indirectly supporting a radical and vocal political movement.
Over the years we gradually became more and more uncomfortable about using the
GPL.
Our most fundamental problem with the GPLwas its extensive
scope.
The GPL required that the source code of everything that
went into the executable should be made publicly available under terms that
were compatible with the GPL.
There were no notion of proportional fairness; the
<i>quid pro quo</i> was in reality a
<i>quodque pro quo</i>
<sup>[<a name="id2708970" href="#ftn.id2708970">4</a>]</sup>.
We realized that it was unethical to impose our ideas on the efforts of others.
</p>
<p>
The first stage of our transition began when the
<a href="http://www.mozilla.org/MPL/" target="_top">
 <i>Mozilla Public License</i>
</a>
(MPL) was released. This copyleft license with a file-based
scope was much more in alignment with our perception of freedom, because it
allowed more fine-grained distinction between &quot;my work&quot; and
&quot;your work&quot;.
If nothing else had happened, we would still have been using the
MPL today.
</p>
<p>
But then another peculiarity of the GPL came back to haunt
us. The GPL disallows combinations of
GPL-covered code with code covered by other licenses, if
those licenses have &quot;further restrictions&quot; [GPL
section 6]. In the absense of legal precedence, the compatibility between the
GPL and other licenses is being decreed by the Free
Software Foundation.
To our dismay we found the MPL on the
<a href="http://www.gnu.org/licenses/license-list.html" target="_top">
list of incompatible licenses
</a>, even though we felt that they shared the same spirit, only deviating
in scope.
For us the compatibility problem was not a problem per se, because we had no
intentions about using GPL-covered code in our projects.
Instead we wanted to be forthcomming towards the GPL-covered
projects that wanted to use our MPL-covered code in their
projects.
So we started investigating alternatives.
</p>
<p>
The obvious alternative was to use a disjunctive
GPL/MPL dual-license, which had already
been endorsed by the Free Software Foundation.
Our problem with the existing disjunctive dual-licenses were that they
allowed the removal of one of the licenses.
This could mean that our code could be forked as GPL-only
code, which would re-introduce the compatibility problem by prohibiting the
combination of this new fork with MPL-covered projects;
or vice versa.
We then investigated the possibility of adding a clause to ensure that both
licenses would be an available option to anyone in the future.
The Free Software Foundation claimed this was incompatible with the
GPL, because (simply put) it was not possible to create
GPL-only forks of the software.
Although we disagreed, we decided not to proceed further with this idea.
</p>
</div>
<p>
The second stage of our transition came when we started looking into the more
amendable disclaimer licenses
<sup>[<a name="id2709133" href="#ftn.id2709133">5</a>]</sup>, such as the
<a href="http://www.opensource.org/licenses/bsd-license.html" target="_top">
 <i>modified BSD license</i>
</a>
and the
<a href="http://www.opensource.org/licenses/mit-license.html" target="_top">
 <i>MIT license</i>
</a>.
Initially we felt apprehensive about abandonning copyleft completely,
and we did not start looking at these disclaimer licenses because we felt
attracted by them, but rather because we felt repelled by the uncooperative
nature of the GPL.
However, upon further reflection we came to the realization that our
perception of
software freedom did not harmonize with the copyleft enforcement mechanism.
We believed in the freedom of developers to make their own choices about their
own efforts. Contributors, not the original author, should decide if and how
their own contributions should be made available.
Copyleft would preclude such a choice.
Our fear of exploitation was overcome by observing that there is surprisingly
little evidence of commercial exploitation, and that commercial corporations
actually do contribute voluntarily.
</p>
<p>
Let us investigate the fear of exploitation in further detail.
</p>
<div class="section">
<a name="id2709215"></a><div class="titlepage"><div><h2 class="title" style="clear: both">
<a name="id2709215"></a>Exploitation</h2></div></div>
<p>
We find it instructive to start by considering whether our motives for
developing open source software is compromised by exploitation.
Whether or not exploitation takes place, we did scratch our itch, we did have
fun during development, we did learn something, and we did get ample feedback.
Although &quot;free riding&quot; does nothing to further our motives, it does
nothing to hinder them either.
We are not on a crusade against proprietary software.
Economics is not a motive for us either, and
even if it were, copyleft would not offer any protection as we could easily be
ousted by any entity with more marketing experience, better financial backing,
or better branding.
</p>
<p>
Most commercial corporations do understand the need for contributions. They are
well aware that &quot;scorched earth&quot; tactics will hurt themselves in
the long run.
Even from a purely cynical point of view, it makes sense to contribute
modifications back to the open source project, as it becomes easier to
upgrade with future baselines of the open source software. This makes it
possible to let the open source project take care of maintenance and future
development, and thus to leverage on the work of the open source contributors.
Closed source forks do not gather as many contributors as open source forks.
</p>
<p>
Fortunately, our experience is that most corporations are not purely cynical,
and that they do contribute voluntarily unless there are strategical reasons
against. We have received more corporate contributions, which generally are
submitted by experienced developers and are of a high quality, on projects
without copyleft.
There are plenty of other examples where commercial corporations have
contributed voluntarily (with or without copyleft) - the
<a href="http://www.mozilla.org/" target="_top">
 <i>Mozilla</i>
</a> web browser, the
<a href="http://www.openoffice.org/" target="_top">
 <i>OpenOffice</i>
</a> office suite, the
<a href="http://www.apache.org/" target="_top">
 <i>Apache</i>
</a> web server, the BSD operating systems (
<a href="http://www.freebsd.org/" target="_top">
 <i>FreeBSD</i>
</a>,
<a href="http://www.netbsd.org/" target="_top">
 <i>NetBSD</i>
</a>,
<a href="http://www.openbsd.org/" target="_top">
 <i>OpenBSD</i>
</a>), and the
<a href="http://www.enhydra.org/" target="_top">
 <i>Enhydra</i>
</a> application server to name some.
</p>
<p>
There are two more issues to take into consideration, namely the costs and
benefits of exploitation.
</p>
<div class="section">
<a name="id2709414"></a><div class="titlepage"><div><h3 class="title">
<a name="id2709414"></a>The Exploitation Hurdle</h3></div></div>
<p>
Using open source software has an inherent cost for commercial corporations. It
is not simply a matter of downloading the software, plugging it into a project,
and laughing all the way to the bank. Using open source software in another
project is akin to software or component reuse. This involves
<div class="variablelist"><dl>
<dt>
<a name="id2709433"></a><span class="term">Assessment</span>
</dt>
<dd>
A thorough survey is needed to find the software, and assess that it fulfills
a given set of requirements.
   <p>
</dd>
<dt>
<a name="id2709450"></a><span class="term">Validity</span>
</dt>
<dd>
The corporation must validate the correctness and quality of the
software. This is usually a major task, because they have no intimate knowledge
about the software, and thus is forced to construct more elaborate test suites.
   <p>
</dd>
<dt>
<a name="id2709470"></a><span class="term">Integration</span>
</dt>
<dd>
Once the software has been chosen, the corporation must learn to use and
integrate it into their project.
   <p>
<div class="variablelist"><dl>
<dt>
<a name="id2709489"></a><span class="term">Development Environment</span>
</dt>
<dd>
A tight integration requires that their development environment and tools are
compatible with that of the open source software.
     <p>
</dd>
<dt>
<a name="id2709509"></a><span class="term">Non-Functional Requirements</span>
</dt>
<dd>
It must be determined if the software is sufficiently reliable, responsive,
scalable, configurable, etc. Error handling and other cross-cutting concerns
must be compatible with the requirements of the commercial products.
     <p>
</dd>
</dl></div>
</dd>
<dt>
<a name="id2709533"></a><span class="term">Maintenance</span>
</dt>
<dd>
Because the corporation has contractual obligations for their products, they
must ensure the future maintenance of the software, even if the open source
project is abandonned.
   <p>
</dd>
</dl></div>
</p>
</div>
<div class="section">
<a name="id2709554"></a><div class="titlepage"><div><h3 class="title">
<a name="id2709554"></a>Benefits of Exploitation</h3></div></div>
<p>
There are some positive effects of such an exploitation. We are not trying to
justify the exploitation, but are simply trying to make the best of the
situation.
</p>
<div class="variablelist"><dl>
<dt>
<a name="id2709571"></a><span class="term">Interoperability</span>
</dt>
<dd>
   If the corporate application is based upon our code, it has a better
   chance of being compatible with our application. This makes it
   significantly easier for us to maintain interoperability between their
   application and ours.
   <p>
</dd>
<dt>
<a name="id2709592"></a><span class="term">Reverse-Engineering</span>
</dt>
<dd>
   If a corporation uses our code in its product and adds their own extensions,
   it is easier for us to reverse-engineer those extensions, than if the
   corporation had written their code from scratch. This is because we are
   intimately familiar with our code, and thus a portion of the corporate code.
   <p>
</dd>
<dt>
<a name="id2709613"></a><span class="term">Reverse Exploitation</span>
</dt>
<dd>
   Corporations often spent many resources trying to enhance product
   functionality or usability. Because our source code is similar to theirs,
   and thus our applications are likely to be alike, it is easier for us to
   reuse their ideas in our project, and thus leverage on their investments.
   Keep in mind that reuse is not limited to code; we can also reuse ideas,
   designs, and functionality.
   <p>
</dd>
<dt>
<a name="id2709637"></a><span class="term">Standardization</span>
</dt>
<dd>
   As our code becomes more widespreadly used, it increases the chance that
   our interface or protocol becomes a <i>de facto</i>,
   and maybe eventually a <i>de jure</i>, standard. An
   example of this is the TCP/IP protocol.
   <p>
</dd>
<dt>
<a name="id2709665"></a><span class="term">Endorsement</span>
</dt>
<dd>
   A corporation has deemed our code good enough to be included in a product
   that they have to vouch for. We could put that on our
   <i>curriculum vitae</i>, or maybe even consider
   applying for a job there.
   <p>
</dd>
</dl></div>
</div>
</div>
<div class="section">
<a name="id2709691"></a><div class="titlepage"><div><h2 class="title" style="clear: both">
<a name="id2709691"></a>Conclusion</h2></div></div>
<p>
Our experience with developing open source software without copyleft offers
no support for the pervasive fear of exploitation.
To the contrary, we have gained more in terms of contributions and
collaborations by replacing copyleft with voluntariness.
</p>
<p>
Based on our experience, we advice open source developers to use the least
amount of copyleft necessary.
<div class="itemizedlist"><ul>
<li>
<a name="id2709719"></a>
Use a license with the smallest copyleft scope that suits the project.
For example, in an increasing order we have disclaimer licenses with no scope,
the MPL with a file-based scope, the LGPL
with a library-based scope, and the GPL with an
executable-based scope.
</li>
<li>
<a name="id2709740"></a>
If copyleft is necessary, put only the application specific code under
copyleft.
For instance, a hash table or socket wrapper is not application specific and
can be reused in other projects. Therefore it should have less copyleft than
the application specific code to prevent indirectly determining the copyleft
scope of projects where this code is going to be reused.
If you are going to use a mix of licenses, please note that
GPL covered code can only be combined with code covered by
<a href="http://www.gnu.org/licenses/license-list.html" target="_top">
GPL-compatible
</a> licenses.
</li>
</ul></div>
</p>
<p>
Although we believe that you are more likely to receive contributions from
commercial corporations if you abandon copyleft, we can make no guarantees
that this is going to happen.
However, the use of copyleft does not guarantee contributions to your project
either, as the commercial corporations may decide not to use your project
because the scope of the copyleft is too extensive
(<i>quodque pro quo</i>).
</p>
<p>
Intriguingly, when we changed the license of our software to be compatible
with the GPL, we did not receive any contributions from
the open source people who had requested this change.
We did receive contributions from commercial corporations, because our
license allowed contributions to be made by their own volition.
</p>
</div>
<div class="section">
<a name="id2709805"></a><div class="titlepage"><div><h2 class="title" style="clear: both">
<a name="id2709805"></a>Appendix: Why not LGPL?</h2></div></div>
<p>
We are almost always asked why we do not use the
<a href="http://www.gnu.org/copyleft/lesser.html" target="_top">
 <i>GNU Lesser General Public License</i>
</a> (LGPL).
Although the LGPL is much more in alignment with our views,
so much that we
feel it ought to be called the Liberated General Public License, there are a
number of issues regarding the LGPL that we find
sufficiently problematic to prefer other licenses:
</p>
<div class="itemizedlist"><ul>
<li>
<a name="id2709855"></a>
The scope of the LGPL is too coarse-grained.
The scope is furthermore open to interpretation. It is limited to some fuzzy
notion of functional entities (&quot;a collection of software functions and/or
data prepared so as to be conveniently linked with application programs&quot;).
What if an LGPL covered library is used by another library
or a software component such as an embedded web browser?
[LGPL, section 0]
</li>
<li>
<a name="id2709879"></a>
The LGPL contains a provision for anybody, at any time, to
convert the license irreversibly to GPL, effectively
creating a the GPL-only fork of the converted code.
[LGPL, section 3]
</li>
<li>
<a name="id2709902"></a>
The Free Software Foundation controls the license.
They can release a new version of the license, which then will automatically
apply to our software.
Although we do not suspect the Free Software Foundation of making changes that
deviate from the spirit of the current versions, they could make clarifications
that are contrary to our intentions.
For example, they may clarify that the result of Aspect-Oriented weaving is
subject to the terms of the LGPL, whereas we had intended
that it is not. Another concern is, who is in charge of the Free Software
Foundation ten years from now, or what happens if the Free Software Foundation
is discontinued?
[LGPL, section 13]
</li>
<li>
<a name="id2709927"></a>
Patent issues and restrictions imposed by law are dealt with by the
LGPL in the usual GPL &quot;my way or
no way&quot; style, namely that such restrictions automatically terminates all
your rights to use the LGPL covered software.
[LGPL, section 11]
</li>
<li>
<a name="id2709955"></a>
Object files must be made available, when distributing executables.
This may seem like a mere inconvenience, but it can impose a serious
configuration management overhead, which can render the term impractical.
[LGPL, section 6a]
</li>
</ul></div>
<p>
We would like to emphasize that we do understand the reasoning behind the
various issues, but that we feel the disadvantages outweights the advantages.
</p>
</div>
<div class="footnotes">
<br><hr width="100" align="left">
<div class="footnote"><p>
<sup>[<a name="ftn.id2708215" href="#id2708215">1</a>] </sup>
For convenience we use &quot;open source&quot; (note the lower casing) to encompass
<a href="http://www.opensource.org/" target="_top">
 <i>Open Source</i>
</a>,
<a href="http://www.gnu.org/philosophy/free-sw.html" target="_top">
 <i>Free Software</i>
</a>, and similar endeavours.
</p></div>
<div class="footnote"><p>
<sup>[<a name="ftn.id2708265" href="#id2708265">2</a>] </sup>
Throughout this paper we will mainly assume commercial corporations with
business models based on selling software as goods.
</p></div>
<div class="footnote"><p>
<sup>[<a name="ftn.id2708915" href="#id2708915">3</a>] </sup>
<i>quid pro quo</i>: (Latin) One thing in return for
another.
</p></div>
<div class="footnote"><p>
<sup>[<a name="ftn.id2708970" href="#id2708970">4</a>] </sup>
<i>quodque pro quo</i>: (Latin) Everything in return
for something.
</p></div>
<div class="footnote"><p>
<sup>[<a name="ftn.id2709133" href="#id2709133">5</a>] </sup>
We use the term &quot;disclaimer license&quot;, because it most accurately
describes the purpose of the license.
These licenses consist of three parts:
(1) a copyright notice,
(2) a clause which says that the license must remain intact, and
(3) a warranty disclaimer.
The last part is intended to protect against legal actions if the software
fails.
These licenses are sometimes called &quot;academic licenses&quot; because of
their origin.
</p></div>
</div>
</div>

#include "footer.t"
