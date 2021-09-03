#include "doctype.t"
#include "setup.t"
HEAD(Daniel Stenberg -- Open Source Experiences)
#include "body.t"
#include "daniel.t"

<p> In the separate document <a href="myopensource.html">My Open Source
 Projects</a> I describe more detailed what Open Source projects I've spent
 the most time and energy on.
<p>
 Also, the article <a href="transition.html">Working Without Copyleft</a> that
I co-wrote with Bjorn Reese should make my position on BSD vs GPL clear.

TITLE(Open Source Experiences)
BOXTOP

<pre>
Author:  Daniel Stenberg
Version: 0.3
Date:    9 May 2000
</pre>
<p>
 I started back on the 25th of March 1999 to write this document which is meant
to grow and evolve in time. I plan to gather my thoughts around Open Source
projects here. What makes them succeed, what makes them fail and what makes
them pleasent to be part of. From a user's view, from a "contributor's" (not
being one of the main developers) view and from a project maintainer's view.
<p>
 As much as it may bring some lights to others, it is very much a way for me
to truely clear my head and understand it myself!
<p>
 I do assume some already achieved knowledge in this area.

SUBTITLE(Release Often and Public is Required)
<p>
 Many words have been spoken around this since the beginning of time and
especially since Eric Raymond's article series. I can't but agree and stress
that this item is vital for a project to strive.

<p class="big">Makes good patches</p>
<p>
 With very recent source files available at all times, contributors can always
make patches to very late sources, and thus they are less likely to cause
problems when the maintainer attempts to apply them to his latest
version. Many are those patches that have caused grief to overloaded Open
Source programmers just because they were made before X large modifications
to the source base.

<p class="big">Current bugs</p>
<p>
 Ever got a reply from someone involved in a project, to a bug report you
posted, that said something about this is already fixed in their "in-house"
version? Bug reporters get annoyed, developers get obstructed.

<p class="big">Automate!</p>
<p>
 One of the first things I do nowadays when I start a new (open) project, is
to make an automatic archive build script. It creates a release-archive
automatically. I use only that to create release archives, and thus it must be
correct or people will complain. If it works well, there's nothing that
prevents you from using that script as frequent as you please. It is good to
remove all involved obstacles that might prevent you from the "release often"
paragraph. Of course keeping the source on a publicly available CVS server is
a great service and even better. Just make sure the repository is kept as
updated as you can! You can although not limit yourself to the CVS server
since the amount of people unwilling or unable to use cvs is quite large.

SUBTITLE(Bazaar with No People?)
<p>
 The world is full of Open Source projects. Sometimes you are lead to believe
that once you start an open project people will come knocking on your door
asking to join and do their part. That's not how it works out there in the
real life. Many many projects are initiated, created, built and programmed by
a very small core of people, or even by a single person. Mostly, the
contribution from other people is limited to a steady stream of bug reports,
ideas and suggestions. I'm not saying those are bad. Those are really useful
and very often the stream of ideas from other people shapes the product into
something that perhaps the original author(s) did not have in mind. I am
merely pointing out that you won't find seriously creating main contributors
easily.

<p class="big">Is it still a Bazaar then?</p>
<p>
 Yes, it is not limited to people actually submitting code or creative work,
being open to ideas, new angles and visions is part of an open source and it
sure proves to be Bazaar-style if you are.

SUBTITLE(Attracting People to Your Project)
<p class="big">Programming is What Drives</p>
<p>

 It is very hard to run an open source project if there's no source! I think
 the term "open source" really serves its purpose when put in this light. If
 your project is not involving code and source to download, try, fix and
 patch, you are much more likely to lose projects participants faster than if
 you did. Evidently, we who participate in open projects very very often do
 that because we like programming. If there isn't enough programming involved,
 a huge share of us dissappear to somewhere else where there is source!

<p class="big">Acknowledge contributions</p>
<p>

 It is important to give credit where credit is due. To get credit is the main
 driving force for many people to do anything at all in an open source
 project, and therefore it is utterly important to point out who did what and
 to carefully avoid taking the honour from someone else's hard work. It is
 better to overdo this than to forget people.

<p>

 This goes all the way from bug reports and tiny patches to big changes and
 new functionality.  Remember that it may be hard for you to judge which
 changes that actually are "hard work" since even smaller changes may be
 tricky and that we all have different experiences and levels of skill. Don't
 underestimate the power of keeping even the small contributors happy.

<p class="big">Sharing is Caring</p>
<p>
 No open source project can live and prosper without a decent web page and
 mailing list. I don't know how many projects I've started in the small, that
 receives a lot of attention and interested people as soon as it appears on a
 web site.
<p>
 The mailing list option is quickly a good thing. As soon as you start having
 a private conversation with two, three other interested parties about how
 things could be done, improvements or entirely new things, it is better to
 have that chat in a more public way so that others can pop in and share their
 ideas more easily while being able to read all the others'.
<p>
 Projects won't get known until they're public enough for other people to pop
 in by mistake or to find your project using a normal search engine.

SUBTITLE(Docs is Doomed to Lag)
<p>
 I do not know the answer to this, but maybe it is a global programmer
syndrome: the "Writedocophobia". We don't like to write documentation,
manuals, howtos, descriptions, explanations. Or if we do, we always put focus
on the development of the product itself, leaving the documentation for
"later", for "a rainy day" or something. Few are those open projects who are
well documented. The older the projects get, the larger amount of docs there
is of course, but very often large parts of that docs is oudated too...

SUBTITLE(Complete Release Archives)
<p>

 I am a firm believer that <i>all</i> files that are required to make a
 release archive should themselves be included in the archives (of course this
 doesn't include tools or things you can download freely from somewhere
 else). When the maintainer takes a long vacation, gets sick, drops interest
 or whatever, it is great value that others have the opportunity to continue
 the development without having to rewrite even a single file.
<p>
 Therefore, the automatic archive builder, the tiny help-scripts or whatever
 that is done to build releases should be included.
BOXBOT

#include "footer.t"
