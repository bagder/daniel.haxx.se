#include "doctype.t"
#include "setup.t"

HEAD(Time it took for Daniel to get a US visa)
#include "body.t"
#include "daniel.t"

#if 0
<script>
  window.onload=function() {
    // Month,Day,Year,Hour,Minute,Second
    upTime('apr,17,2018,10:00:00');
  }
  function upTime(countTo) {
    now = new Date();
    countTo = new Date(countTo);
    difference = (now-countTo);

    days=Math.floor(difference/(60*60*1000*24)*1);
    hours=Math.floor((difference%(60*60*1000*24))/(60*60*1000)*1);
    mins=Math.floor(((difference%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
    secs=Math.floor((((difference%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

    document.getElementById('days').firstChild.nodeValue = days;
    document.getElementById('hours').firstChild.nodeValue = hours;
    document.getElementById('minutes').firstChild.nodeValue = mins;
    document.getElementById('seconds').firstChild.nodeValue = secs;

    clearTimeout(upTime.to);
    upTime.to=setTimeout(function(){ upTime(countTo); },1000);
  }
</script>
#endif

<style>
.time {
  font-style: bold;
  font-size: 180%;
  color: #ff0000;
}
.answer {
  width: 40em;
  background: #f0f0f0;
  margin-left: 30px;
}
.question {
  font-style: italic;
  font-size: 120%;
}
</style>

TITLE(Time it took for Daniel to get a US visa)

#if 0
<span class="time">
  <span id="days">00</span> days, <span id="hours">00</span> hours,
  <span id="minutes">00</span> minutes and <span id="seconds">00</span> seconds</big>
</span>
#else
<span class="time">
 937 days
</span>
#endif

<p>

SUBTITLE(Background)
<p>

 On June 26th 2017, Daniel was denied to travel to the US - while still having
 a valid ESTA and passport. He was then denied ESTA on April 3, 2018. When
 subsequently applying for a visa instead, there has been no response for over
 two years. (To <i>visit</i>, not to apply for permanent residency.)

<p> This page was edited with <a href="#got-it">new content</a> on:
 <b>November 9, 2020</b>

SUBTITLE(Blog posts)

<p> First blog post: <a
 href="https://daniel.haxx.se/blog/2018/07/28/administrative-purgatory/">Administrative
 purgatory</a>

<p> The one year anniversary: <a
href="https://daniel.haxx.se/blog/2019/04/17/one-year-in-still-no-visa/">One
year in still no visa</a>.

<p> <a href="https://daniel.haxx.se/blog/2020/04/17/two-years-in/">Two years in</a>

SUBTITLE(Q&A)
<a name="got-it"></a>
<p class="question">
<a href="#got-it">Visa approved</a>
<div class="answer">
<p>
 937 days since my application, I have a visa in my passport. Valid for 10 years.

<p> As an unexpected bonus, there's also a 30 days "NIE" (National Interest
 Exception) that allows me a single entry to the US during "PP" (Presidential
 Proclamations) - which is restricting travels to the US from the European
 Schengen zone.

</div>

<a name="parcel"></a>
<p class="question">
<a href="#parcel">"There's a package being delivered to you"</a>
<div class="answer">
<p>
 934 days into the process (10:30 November 6, 2020) I received this
 text on my phone, saying there's a parcel sent to me from "the
 Embassy of the United State".
<p>
<img src="/media/embassy-text.png" width="600">
</div>

<a name="send-in"></a>
<p class="question">
<a href="#send-in">Please send in your passport</a>
<div class="answer">

<p> On October 13, 2020 (910 days in), the embassy emailed me again,
asking me to "Please send in your passport for further processing."

<p> On October 16, I mailed it to the embassy.

</div>

<a name="plans"></a>
<p class="question">
<a href="#plans">Updated travel plans please!</a>
<div class="answer">

<p> On September 22, 2020 (889 days in), the US Embassy emailed me, and I will
quote verbatim from the email below.

<pre>
Dear Sir,
&nbsp;
Your visa application is still in administrative processing. However, we regret to
inform you that because you have missed your travel plans, we will require updated
travel plans from you. If you intend to proceed with your visa application, we
therefore ask you to kindly send your updated travel plans, including any relevant
supporting documents (such as  an official invitation letter and financial support
letter/other financial supporting documents). Thank you.
</pre>

<p> So I need to provide updated plans and "invitation letters"...

<p> It seems reasonable to suspect that the embassy woke up and realized this
 after having being prodded by the <a href="#officials">congressman's
 email</a> a few days ago. The travel plans have been outdated for the last
 800 days or so and they only email to ask this now?

<p> On October 2, 220 (898 days in) I responded to the email with an
 invitation letter with an offer to visit my colleagues at wolfSSL in the US
 at two different future dates (one in December 2020, one in March 2021) and
 "All expenses, hotel, airfare, transportation and food will be paid for him".
 Signed by Larry Stefonic, CEO of wolfSSL.

</div>

<a name="long"></a>
<p class="question">
<a href="#long">Do you know why this takes so long?</a>

<div class="answer">

<p> No. They've just informed me "someone is working on it" and that it "may
take a long time" but without qualifying what that means. They call it
"administrative processing."

<p> I have talked to several persons who've experienced similar situations, and
  I have learned about waiting times up to 20 months until a definite "no". I used
  to think of that as a sort of "worst case" waiting time. Now we know it can
  take longer...
</div>

<a name="esta"></a>
<p class="question">
<a href="#esta">Why don't you just apply for an ESTA?</a>

<div class="answer">
<p>
  I already did and they denied me that. See one of the <a href="#images">images below</a>.
</div>

<p class="question">
Why did they deny you ESTA?

<div class="answer">
<p>
  I don't know as they won't tell. And I also don't know why they can't respond to my visa application.
</div>

<a name="working"></a>
<p class="question">
<a href="#working">So, someone is working on it?</a>

<div class="answer">
<p>
  Allegedly, yes. I'm sure that person must be working very hard...
</div>
  
<a name="eventually"></a>
<p class="question">
<a href="#eventually">Do you think they will grant you a visa eventually?</a>

<div class="answer">
<p>
  No. I have been in contact with many people who have been in similar
  situations such as this, as well as many people who have applied for visas
  for very complicated matters, and it is basically unheard of that it would
  take this long time and still end up with a positive response in the end.
<p>
  Someone emailed me and explained how they got their visa approved after 10
  months waiting - so it obviously <i>can</i> happen after a fairly
  long time!
</div>

<a name="arab"></a>
<p class="question">
<a name="#arab">Did you travel to any arab countries, middle-east, North Korea, Sudan, Iran or Iraq?</a>

<div class="answer">
<p>
 No.
</div>

<a name="ever"></a>
<p class="question">
<a name="#ever">Did you ever visit the US?</a>

<div class="answer">

<p> Yes, I have visted the US around a dozen times over a time period of almost
 twenty years. I have applied and gotten ESTA permissions several times. I have
 many friends living and working in the US.

<p> My latest visit to the US was in December 2016 - using the same ESTA and
 passport I subsequently wanted to use in the summer of 2017 when I was first
 denied travelling to the US.

</div>

<a name="blocked"></a>
<p class="question">
<a href="#blocked">How many trips have this blocked you from taking so far?</a>

<div class="answer">
<p> I have been invited personally to several meetings in the US that I couldn't
 attend. (excluding IETF, HTTPbis or QUIC meetings)

<ol>
<li> San Francisco June 2017. Mozilla All Hands.
<li> San Francisco June 2018. Mozilla All hands.
<li> San Francisco October 2018. Conference speaking engagement.
<li> Orlando, Florida December 2018. Mozilla All hands.
<li> Portland, Oregon January 2019. Conference speaking engagement.
<li> California, March 2019. Conference speaking engagement.
<li> Summer of 2019. Wedding.
</ol>

</div>

<a name="employer"></a>
<p class="question">
<a href="#employer">Can't your employer help you?</a>

<div class="answer">

<p> We've already tried all available ways to get information or otherwise
bring this effort forward. To no avail.

</div>

<a name="Mozilla"></a>
<p class="question">
<a href="#Mozilla">Will Mozilla move more meetings outside of the US?</a>

<div class="answer">

<p> Yes. Several of the coming All hands are now planned and scheduled to
happen outside of the US, for example in Canada and Germany. But I will not be
there to experience them since I quit Mozilla in December 2018.
</div>

<p class="question">
Will your visa situation change when you've quit Mozilla?

<div class="answer">

<p> Unfortunately, there is no reason to suspect or hope so.

</div>

<a name="lost"></a>
<p class="question">
<a href="#lost">Maybe they lost your application?</a>

<div class="answer">

<p> I emailed them in July 2019 just to make sure they just hadn't
 forgot about my case or similar over the past year, and I received their
 reply on August 1st 2019. The response said "I have forwarded your email to
 my supervisor to highlight the problem."  - but then nothing more came.

<p> I emailed them again on January 28, 2020.<br>
<img src="/media/651-days-email.png">
<p>
 They responded very politely:
 <p>
<pre>
Dear Sir,
&nbsp;
All applications are processed in the most expeditious manner
possible. While we understand your frustration, we are required to follow
immigration law regarding visa issuances. This process cannot be expedited or
circumvented. Rest assured that we will contact you as soon as the
administrative processing is concluded.
</pre>

</div>

<a name="likely"></a>
<p class="question">
<a href="#likely">What do you think is the most likely explanation for this treatment?</a>

<div class="answer">

<p> I think one of the likelier explantions is that someone somewhere has
 found my name and my code used in some evil or malicious manner and drawn the
 wrong conclusions about how my code ended up there or how I could've been
 involved. Like for example in some malware, virus or other attack software. I
 make tools and code available for free and openly and sometimes those are
 unfortunately used in ways I don't condone.

<p> Since they won't tell me why, basically all theories are equally likely.
 We just won't know.

</div>

<p class="question">
Any other plausible explanations?

<div class="answer">

<p> People have mentioned my domain name <b>haxx.se</b> or suggested it is
because I have referred to myself as "a hacker" at times. I find that unlikely
since I used the domain and used the term for decades before this.

<p> Others have offered the explanation that the immigration authorities
might've decided that I violated the ESTA rules in a previous visit. I can of
course not know what they think, but I have not violated those rules.

</div>

<a name="crime"></a>
<p class="question">
<a href="#crime">Convicted of a crime?</a>

<div class="answer">

No, I have never been convicted of a crime in Sweden and not anywhere
else. Not even charged. Nor have I ever been involved in a lawsuit of any
kind.

</div>

<a name="license"></a>
<p class="question">
<a href="#license">Can you change the curl license?</a>

<div class="answer">

Lots of people suggest this, most probably in jest, but let me be perfectly
clear: no I won't change the curl license.
<ol>
 <li> excluding a specific user would make a license to not be open source anymore
 <li> curl has many more copyrights than mine, it would be hard
 <li> curl is bigger than me personally, I wouldn't do it anyway
</ol>

</div>

<a name="covid"></a>
<p class="question">
<a href="#covid">But Covid-19?</a>

<div class="answer">
During the Corona pandemic (starting in spring 2020), the US has closed its
borders for a lot of more people who otherwise would have been allowed
entry. I suspect the visa processing has slowed down during this period since
people can't go there anyway. But I have not been notified about anything and
I still expect to get a rejection at some point. Pandemic or not.
</div>

<a name="officials"></a>
<p class="question">
<a href="#officials">Have you contacted any US officials?</a>

<div class="answer">

A US citizen friend of mine sent the following text in an email to the
U.S. Congressman Gerry Connolly on September 3, 2020.

<pre>
Dear Representative Gerry Connolly:
&nbsp;
Could you please help my friend Daniel Stenberg *finally* gain permission to
travel to the US? He has been denied permission to travel to the US for years,
yet there is no cause for it.
&nbsp;
On June 26, 2017, Mr. Stenberg was denied to travel to the US, even though he
had a valid ESTA and passport. He was then denied ESTA on April 3, 2018. He
then applied for a visa in April 2018, and has *still* not heard anything.
&nbsp;
This is especially galling because is a widely-known leader in the computer
community. He developed and maintains the "curl" program, a program used
worldwide by many software developers and computer system administrators. In
October 2017 he won the "Polhem prize" for his work on curl; in that ceremony
the Swedish king personally handed Daniel a gold medal. In February 2019 he
joined wolfSSL, an American company (he's their only Swedish hire), and yet
he's still not allowed to travel to the US.
&nbsp;

Perhaps there is a confusion about the word "hacker". In the computer
community, a "hacker" is NOT someone who breaks into computers, a hacker
is "a person who delights in having an intimate understanding of the
internal workings of a system, computers and computer networks in
particular."  ( IETF RFC 1983, https://tools.ietf.org/html/rfc1983).
Mr. Stenberg does *not* break into computers without authorization.
&nbsp;
At the least, the State Department should have asked questions instead of
reflexively denying entry to a world leader in the computer industry.
&nbsp;
More information is available on his personal website:
https://daniel.haxx.se/us-visa.html
https://daniel.haxx.se/about.html
&nbsp;
Thank you very much!
&nbsp;
--- [name redacted]
</pre>

<p> Subsequently, this congressman's office queried the US embassy in
 Stockholm about the case and on September 17, 2020 (884 days since the
 interview) the US embassy responded. Here's the relevant part of the answer:

<pre>
On your behalf, my office contacted the Embassy and asked the agency to provide any
information that might be helpful to you. The agency has responded to this inquiry
stating that your case is currently undergoing necessary administrative processing
and that regrettably it is not possible to predict when this processing will be
completed. The Embassy has assured my office that you will be contacted directly
once a decision is rendered or if any additional information is needed.
</pre>

<p> Let me repeat: <b>undergoing necessary administrative processing</b>

</div>

<p>
<a name="images"></a>
SUBTITLE(Images)

<p> This is what the online visa application status site showed for my case on
July 30, 2019:
<p><center>
<img style="max-width:80%" src="/media/Administrative-Processing.png"></center>

<p> This is what an ESTA rejection looks like:
<p><center>
<img style="max-width:80%" src="/media/ESTA-travel-not-authorized.png"></center>

#include "footer.t"
