<!-- generated with roffit 0.7 -->

<p class="level0"><a name="NAME"></a><h2 class="nroffsh">NAME</h2>
<p class="level0">mail2sms - reads a (MIME) mail and converts it to a short message. <a name="SYNOPSIS"></a><h2 class="nroffsh">SYNOPSIS</h2>
<p class="level0"><span Class="bold">mail2sms [options] &lt; mail</span> <a name="DESCRIPTION"></a><h2 class="nroffsh">DESCRIPTION</h2>
<p class="level0">mail2sms offers search and replace, conditional rules, conditional search and replace etc to create a custom output. It can optionally pipe its output into a specified program. <a name="OPTIONS"></a><h2 class="nroffsh">OPTIONS</h2>
<p class="level0">
<p class="level0"><a name="-c"></a><span class="nroffip">-c &lt;config file&gt;</span> 
<p class="level1">Specifies what config file to read. It can be used repeatedly. 
<p class="level0"><a name="-d"></a><span class="nroffip">-d</span> 
<p class="level1">Switch on debug messages in the log file 
<p class="level0"><a name="-I"></a><span class="nroffip">-I &lt;include dir&gt;</span> 
<p class="level1">Adds a directory to the include path. 
<p class="level0"><a name="-l"></a><span class="nroffip">-l &lt;logfile&gt;</span> 
<p class="level1">Specify what file to write all log texts to. 
<p class="level0"><a name="-n"></a><span class="nroffip">-n</span> 
<p class="level1">Prevents mail2sms from reading the default config files. 
<p class="level0"><a name="-o"></a><span class="nroffip">-o</span> 
<p class="level1">makes mail2sms write the sms message to stdout when completed (and not invoke any sub-command). 
<p class="level0"><a name="-p"></a><span class="nroffip">-p &lt;phone number&gt;</span> 
<p class="level1">sets the $phone variable (see the run command) 
<p class="level0"><a name="-q"></a><span class="nroffip">-q</span> 
<p class="level1">shuts off all logging 
<p class="level0"><a name="-v"></a><span class="nroffip">-v</span> 
<p class="level1">Shows mail2sms' version number then quits. <a name="AUTHORS"></a><h2 class="nroffsh">AUTHORS</h2>
<p class="level0">mail2sms has been written by Daniel Stenberg &lt;daniel@haxx.se&gt; with lofs of help from friendly contributors, such as: 
<p class="level0">&nbsp;- Linus Nielsen &lt;linus@haxx.se&gt; &nbsp;- Kjell Ericson &lt;kjell@haxx.se&gt; &nbsp;- Bjorn Stenberg &lt;bjorn@haxx.se&gt; &nbsp;- Alexander Bergolth &lt;leo@strike.wu-wien.ac.at&gt;  &nbsp;- A. Ljunggren &lt;andreas.ljunggren@ericsson.com&gt; &nbsp;- Peter Kundrat &lt;kundrat@gic.sk&gt; &nbsp;- Tomi Malensek &lt;tomi@insert.si&gt; &nbsp;- Balazs Nagy &lt;julian7@kva.hu&gt; &nbsp;- Adrian Pavlykevych &lt;pam@polynet.lviv.ua&gt; 
<p class="level0"><a name="WWW"></a><h2 class="nroffsh">WWW</h2>
<p class="level0"><a href="http://daniel.haxx.se/projects/mail2sms/">http://daniel.haxx.se/projects/mail2sms/</a> <a name="SEE"></a><h2 class="nroffsh">SEE ALSO</h2>
<p class="level0"><span Class="manpage">mail2sms (4)</span> <p class="roffit">
 This HTML page was made with <a href="http://daniel.haxx.se/projects/roffit/">roffit</a>.
