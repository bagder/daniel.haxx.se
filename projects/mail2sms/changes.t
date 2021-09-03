Version 1.3.4
=============
 Daniel (7 Jun 2002)
 - Rainer Thieringer found out that a line starting with "From " in the body
   of a mail with mysteriously discarded from the output. This was due to old
   bad parsing code hanging around.
&nbsp;
 Daniel (20 May 2002)
 - Rainer Thieringer got a mail with a very long "encoded-word", even though
   the standards say they shouldn't be longer than 76 bytes. I increased the
   buffer in mail2sms to support 256 bytes body in the "encoded-words".
&nbsp;
 Daniel (27 Apr 2002)
 - Josep Portella Florit fixed a problem with some 8-bit chars used as
   array indexes, as some compilers apparently will deal with them signed
   and then there will be badness happening.
&nbsp;
 Daniel (19 Feb 2002)
 - Norbert Federa fixed a problem where we didn't clear the full range for
   keywords like 'wday' etc which could lead to bad expression parsing.
&nbsp;
Version 1.3.3
=============
 Daniel (7 Nov 2001)
 - Harry Mahoney pointed out that the quoted-printable decoder didn't work
   properly if the line ends with CRLF and not just an LF. We now check for
   either LF or CRLF.
&nbsp;
 Daniel (25 Oct 2001)
 - Petr Kuba found and corrected a problem with a string buffer that wasn't
   zero terminated properly.
&nbsp;
 Daniel (31 May 2001)
 - getname() had an unsigned problem that made certain 8bit characters get
   treated and shown as space!
&nbsp;
 Daniel (19 Apr 2001)
 - More complete CRLF fixes, they seem to make Hermann's example mails to
   get through looking fine!
&nbsp;
Version 1.3.2
=============
 Daniel (3 Apr 2001)
 - Made some basic attempts to deal with CRLF lines better as Hermann
   Himmelbauer reported problems. mail2sms has never dealt with them good.
&nbsp;
 Daniel (13 Feb 2001)
 - Mats Irenéus discovered that within a multipart mail, mail2sms could fail
   to decode the Content-Transfer-Encoding specified. This happened if the
   CTE-header was set before the Content-Type header.
&nbsp;
 - As Mats Irenéus reported, -n could only be used as the first argument. Hm, 
   a 1 can look like a i! Fixed! :-)
&nbsp;
Version 1.3.1
=============
 Daniel (12 Feb 2001)
 - Applied the patches sent to me by Luciano Campal Vazquez
   &lt;lucho@coala.uniovi.es&gt;. They add the 'exit' keyword, which is a kind of
   combined 'break' and 'abort' keyword that makes it possible to set the exit
   code of mail2sms. One beauty of this feature is to return 75 when invoked
   by sendmail, since that'll make the mail to get queued and retried at a
   later time. Do note that you can make this return whatever value you tell
   it to, but you need to check out yourself what return codes that make sense
   in your environment.
&nbsp;
Version 1.3
===========
&nbsp;
 Daniel (9 Feb 2001)
 - I removed the -s again since it can be done better with 'filter'.
&nbsp;
 - So, after having posted a few mails to the mailing list, I added the
   'filter' keyword today that now allows the 'ignore' filter to be used. I've
   done some initial basic testing, but I figure I need a larger user base to
   know for sure that everything works as intended.
&nbsp;
 Daniel (7 Feb 2001)
 - Juan Toledo identified the most silly mistake in the history of mail2sms.
   At least it felt so. mail2sms wrote a line like 'attached mail follows'
   within HTML tags when an attached mail was included. I removed this.
&nbsp;
 Daniel (31 Jan 2001)
 - After a discussion with Jernej Porenta I've made the -l switch override
   the 'logfile' keywords of config files. Once -l has been used on the command
   line, no config file can set the logfile. It just makes more sense.
&nbsp;
 Daniel (25 Jan 2001)
 - Based on the simple patch Karol Bryd &lt;kbryd@int.gnu.org.pl&gt; was friendly to
   send me, I added the -s switch today that tell mail2sms to attempt to strip
   off the signature from the input mail. It is a very simple approach, but it
   might work! The signature is everything from a line starting with "-- ".
&nbsp;
   There is currently no way to set this option in the config file, as I want
   to solve this a little different in the future. The stripping should not be
   done in parse.c as now, it should be in the sms.c so that the stripping
   could be conditional like most other things in mail2sms. We should also add
   more strip options, like the frequently requested 'strip html'. We might
   just add a 'strip' keyword soon...
 
 Daniel (19 Jan 2001)
 - Tin Le &lt;tin@le.org&gt; made me aware of a possible core dump situation in the
   log function that I corrected. I've asked him to verify that my fix
   actaully removes the problem...
&nbsp;
 Daniel (24 Oct 2000)
 - I made most of the config file keyword loggings to use the CONFIG level
   instead of the INFO level. It makes it easier to filter stuff in the log.
   All log texts regarding config file parsing should now be CONFIG.
&nbsp;
Version 1.2.1
=============
&nbsp;
 Daniel (19 Oct 2000)
 - Made the startup config files get read in a slightly different manner. It
   won't really be noticed. Instead of parsing them right away as they're
   defined, they're now appened to a queue. When all the command line options
   are parsed, the config files are taken care of. Thus, if "-n" is used
   anywhere, the default config files are skipped.
&nbsp;
   This properly allows -l to be used to set a logfile that will be used for
   all read config files, as the -l sets logfile before any config files gets
   parsed.
&nbsp;
 Daniel (18 Oct 2000)
 - Added the -l &lt;log&gt; command line switch. This is important if you want *all*
   logs to end up in that particular logfile, since some events will happen
   before the 'logfile' entry in your personal config file is read.
&nbsp;
 - I had missed the new ACTION stuff in the logging so the log didn't look
   like before. Now it does again.
&nbsp;
Version 1.2
===========
&nbsp;
 Daniel (18 Oct 2000)
 - The IF-stuff didn't quite work. There was this kludge lying around that was
   once introduced to enable search/replace to have not-regexes that ruined
   everything, as after one search-expression, everything would be linked to
   that expressions action list! And search/replace-expressions can't have
   action lists! :-)
&nbsp;
 - Removed a crash in the replacecheck(). Now why hasn't anyone noticed that
   before? Must've been there for very long...
&nbsp;
 Daniel (17 Oct 2000)
 - Removed double MSG-log entries.
&nbsp;
Version 1.1
===========
&nbsp;
 Daniel (17 Oct 2000)
 - The ABORT keyword is now made one of those IF-sensitive ones. This also
   means it no longer requires a regex as parameter. In fact, this is a very
   much changed ABORT function, although I really think this fits in the
   design a lot better than before.
&nbsp;
 - Updated README quite a bit to reflect the new reality. I really do think it
   makes the whole config file concept easier to grasp.
&nbsp;
 Daniel (16 Oct 2000)
 - Added support to send multiple messages from one large input. You control
   this feature with two new keywords:
&nbsp;
        multipart - controls how you want each part in a multipart output to
                    look like. Available "variables" are $index and $numparts,
                    that allow you to set it to "($index/$numparts)" if you
		    want each part to be prefixed with that. Start this
		    pattern with a dash '-' to make it a suffix instead! If
		    the output fits in one part, no multipart format will be
		    added.
&nbsp;
        maxparts -  set the maximum number of parts you allow the output to
                    consist of
&nbsp;
   These two keywords are of course also possible to control with IF, just as
   the ones I described below...
&nbsp;
 - I made things work way cooler than before. The following keywords are
   affected:
        outsize, create, delete, system, config, run, program, progargs,
        output, phone, server, port
&nbsp;
   They're all kind of "variables". They're all from now on "context
   sensitive" in the sense that if they're written within an IF-ENDIF section,
   they will only be performed if that IF-expression evaluates TRUE. This
   enables a lot more tricky stuff and fancy conditions. You can change any of
   these variables depending on contents of a mail.
&nbsp;
   NOTE! The ability to change outsize "run time" forced me to remove the
   feature that was used that made mail2sms sometimes not scan the entire
   mail, but only outsize * 10 bytes. Since outsize now can change all the
   time, the entire mail will now always be read.
&nbsp;
Version 1.0
===========
&nbsp;
 Daniel (9 Oct 2000)
 - I decided to bump to 1.0 now since we've been running 0.x-versions now for
   almost two years by now and the implementation is rather solid as it is
   used in most of the cases.
&nbsp;
 - Made mail2sms truncate logged messages at 500 bytes.
&nbsp;
 - Jørn-Morten Innselset pointed out that the multi-part alternative parser
   didn't work properly. When there was one text and one html part, both parts
   were included in the output. Now only the first, plain-text part is used.
&nbsp;
 Daniel (26 Mar 2000)
 - In a discussion with Petr Sulla &lt;xsulla@informatics.muni.cz&gt;, I decided to
   finally and once and for all, remove the code that prevents mail2sms to
   output two "space" letters in a row. This has only caused problems to those
   who have had slightly different wishes than I've had.
&nbsp;
0.36
====
 Daniel (19 Jan 2000)
 - A problem pointed out by Mats Irenéus &lt;Mats.Ireneus@sth.frontec.se&gt; and
   Gerd Bavendiek &lt;bav@esn.sbs.de&gt; caused mail2sms to crash if the HOME
   environment variable wasn't set.
&nbsp;
 - Expect this project to appear on sourceforge.net very soon. At least partly.
&nbsp;
 Daniel (10 jan 2000)
 - I remade the previous patch, it got lost. mail2sms now doesn't exit if the
   home directory wasn't found. We don't need it that terribly bad! ;-)
&nbsp;
0.35
====
 Daniel (13 oct 1999)
 - Alexander Bergolth &lt;leo@strike.wu-wien.ac.at&gt; pointed out two problems.
   One of them lead to an immediate crash when logging fullbody-stuff and
   the other was a little more subtle possible crash.
&nbsp;
0.34
====
 Daniel (12 oct 1999)
 - Adrian Pavlykevych &lt;pam@polynet.lviv.ua&gt; pointed out and fixed a bug in
   the new output support for \-codes.
&nbsp;
 Daniel (11 Oct 1999)
 - Iztok Umek &lt;Iztok.Umek@simobil.si&gt; pointed out two bugs related to stuff I
   introduced in 0.33. It had to do with the 'output' string and the 'to'
   stuff. The 'to' stuff is still pretty bad since it only works really well
   if there's a single mail address in there. If not, you should probably
   consider using the 'header' type and match it better "manually".
 - Alexander Bergolth &lt;leo@strike.wu-wien.ac.at&gt; brought me some fixes
   regarding AFS and a few buffer sizes.
 - I took Alexander's changes a bit further and made the output buffer fully
   dynamic, as it should have been from the start, to fully support any-length
   outputs.
 - Added the first mail2sms.1 man page attempt. I stalled the mail2sms.4 that
   should contain the config file format, it was too much work and the README
   does a pretty good job already. It is still included here in case anyone
   would want to help me completing it.
 - Made -v display the current version number.
&nbsp;
0.33
====
 Daniel (7 Oct 1999)
 - Made 'to' and 'toaddress' work all over the rules and conditions
 - The 'address' should now be replaced with 'fromaddress' in rules and config
   files, although the former is still recognized and working
 - \n now makes newlines in the output string, \t makes tab and \r makes
   carriage return. \\ should be a regular backslash. This idea came from
   A. Ljunggren &lt;andreas.ljunggren@ericsson.com&gt;.
 - I added more blurb in the README file (bottom) about the order of the tests
   as it has caused confusion.
&nbsp;
0.32
====
 Daniel (7 Sep 1999)
 - Removed the MPL license again, it is not compatible with the GPL of the
   regex.c file. *sigh* it is a plague.
 - Removed an old debug-line in sms.c that made redhat 6 compiles fail.
 - Added a configure script for better portability. Not that much is
   actually using the results from it yet! ;-)
 - Updated to my new email address all over
&nbsp;
0.31
====
 Daniel (29 Jul 1999)
 - Peter Kundrat &lt;kundrat@gic.sk&gt; and Tomi Malensek &lt;tomi@insert.si&gt; both
   pointed out a problem in sms.c that made the 0.30 change a little buggy.
&nbsp;
0.30
====
 Daniel (1 Mar 1999)
 - On request from Balazs Nagy &lt;julian7@kva.hu&gt;, I've introduced $address
   as a variable in the output format, as well as "address" is now an
   understood options limiter. Address is the email address only. Not the
   name part. $from/from will remain the name part if available and the
   email otherwise.
&nbsp;
0.29
====
 Daniel (10 Feb 1999)
 - Just found out the Lotus Notes SMTP (some version) doesn't fill in the
   MIME-version: header at all times (in my test, I didn't get it when I got a
   mail without body), so I have to skip the check for that and always
   "assume" mime-headers to be better compliant... :-/
&nbsp;
 - Extended the buffer which overflow Kjell Ericson pointed out.
&nbsp;
0.28
====
 Daniel (22 Dec 1998)
 - A command parse bug removed. It occured with space-indented commands.
&nbsp;
0.27
====
 Daniel (18 Dec 1998)
 - Finally I found the BAAAAD bug that ocured on sunos-4 which made repeated
   regex searches return "internal error"...
&nbsp;
 - Added Kjell's regex fixes again after correction.
&nbsp;
 - -d now enables the DEBUGREGEX messages too, which can be handy when
   debugging weird search/replace things.
&nbsp;
 - "always" and "never" works better in when expressions.
&nbsp;
0.26
====
 - Removed Kjell's regex fiddle and it WORKS again under sunos and linux.
   Darned problem took me hours to track!
&nbsp;
0.25
====
&nbsp;
 - example.conf is taking shape
 
 - Corrected the problem if no prio was specified no regex was done! ;-)
&nbsp;
 - The log now numbers body-replacemens from body line number 1.
&nbsp;
 - 'config' is now an accepted if/endif specifier. It specifies a config file
   to read if the regex matches!
&nbsp;
0.24
====
&nbsp;
 - 'not' now works for the previous 'abort' or 'search/replace' too. (If
   defined for a search/replace, it must be used after the replace keyword.)
&nbsp;
 - Corrected a "location" bug in which the regexes weren't properly done if
   "locations" were specified.
&nbsp;
 - Now checks for min and max prio used and only runs through them on
   regex checks.
&nbsp;
 - Now logs each s/r once for each line it performs on.
&nbsp;
0.23
====
&nbsp;
 - removed the ctype[] stuff in regex.c
&nbsp;
 - no longer treats attachments' headers as real headers
&nbsp;
 - '-n' as first argument prevents reading the default config files.
&nbsp;
0.22
====
&nbsp;
 - 'nocase' now treats 'åäö' properly.
&nbsp;
 - (Kjell Ericson) åäö are treated as parts of words in the regex.c.
&nbsp;
 - More details added to the README.
&nbsp;
 - Made the MIME header decoder be less strict about ?-letters in encoded-
   words (a violation of the RFC, but they still appear at times due to bad
   mailers).
&nbsp;
0.21
====
&nbsp;
 - 'begin' uses 'log' now, if specified. It also mentioned whether the
   condition flag is TRUE or FALSE.
&nbsp;
 - "showlog" sets what to include in the logfile.
 
 - Made "1perline" work as an alias to "noloop" in the options.
&nbsp;
 - Corrected the not-list.
&nbsp;
0.20
====
  (Dec 14, 1998)
&nbsp;
 - Added 'not' 
&nbsp;
 - Now logs MSG: even if -o is used.
&nbsp;
 - Added -d for debugging mail2sms.
&nbsp;
 - New internal log system.
&nbsp;
 - General clean-up of the README.
&nbsp;
 - Moved the regex guide from README to REGEX.
&nbsp;
 - Added 'outsize' to support any-length output.
&nbsp;
 - Added 'path' and -I.
&nbsp;
 - The when-fix didn't really work.
&nbsp;
0.19
====
&nbsp;
 - The first when command now sets the condition flag to the result. This means
   more logical constructions. I.e if the first when-command doesn't match,
   the condition flag is set to FALSE.
&nbsp;
 - create, delete and system now work in if/endif contexts too
&nbsp;
 - if-bug removed.
&nbsp;
 - Documented create, delete and system.
&nbsp;
0.18
====
&nbsp;
 - Made it deal with parentheses in the comment part of the From: line better
&nbsp;
 - Removed the extra newline from the 'run' command'
&nbsp;
 - Now logs when the replace-check aborts due to too many search hits. It
   is generally due to bad search patterns.
&nbsp;
0.17
====
&nbsp;
 - '-o' no longer runs the 'run'-command also.
&nbsp;
 - 'create' creates the specified file
&nbsp;
 - 'delete' removes the specified file
&nbsp;
 - 'system' runs a shell command line
&nbsp;
0.16
====
&nbsp;
 - Better help desk when -h is used.
&nbsp;
 - Added support for -q (shut off logging) and -o (write message to stdout).
&nbsp;
 - Added 'run' and associated variables and code. See README.
&nbsp;
 - if/endif works for sub-sectioned search/replace/abort, whatever!
&nbsp;
 - New log format. It seemed silly to waste 15 columns on each log line for
   information that in 99.9% remains the same through all lines.
&nbsp;
0.15
====
&nbsp;
 - Now supports commments at all end of lines, i.e a # and everything to the
   right of it is treated as a comment. If you want # to be part of a value,
   use quotes around the value as in:
&nbsp;
	output: "$from#$subject#$body" # output format
&nbsp;
 - Corrected the "couldn't read include file" warning message.
&nbsp;
 - Made 'break' get logged.
&nbsp;
 - end/else used at the wrong place now warns in the logfile.
&nbsp;
0.14
====
&nbsp;
 - Minor fixes.
&nbsp;
0.13
====
&nbsp;
 - Now logs if it can't read a specified config file
&nbsp;
 - always and never weren't working properly in when-expressions.
&nbsp;
 - output was turned into a single string which supports three variables:
   $from, $subject and $body. Note that $body is usually very long.
&nbsp;
0.12
====
&nbsp;
 - experiments to actually send messages to the server failed! :-(
&nbsp;
 - changed -r to -c
&nbsp;
 - added -p &lt;phone number&gt; support.
&nbsp;
 - corrected the output internal defaults
&nbsp;
 - changed name of PRIO_MAX since that collided with some Linux system
   define (sms.h, sms.c)
&nbsp;
0.11
====
&nbsp;
 - removed 'from', 'subject' and 'body'. 'output' should be used for this!
&nbsp;
 - Thanks to Electric Fence, I undid two memory bugs in less than 5 minutes!
&nbsp;
 - More blurb in the README.
&nbsp;
 - 'output' is recogznied to control what is output and in which order.
&nbsp;
0.10
====
&nbsp;
 - Added code to actually post the message to the server too. 100% untested.
&nbsp;
 - Added 'port', 'server' and 'phone'. Port is default to the correct sms
   server port.
&nbsp;
 - valid/invalid are removed keywords
&nbsp;
 - 'break' now instructs to NOT send any sms
&nbsp;
 - 'unbreak' instructs to undo a 'break' command and thus enforces an sms
&nbsp;
 - 'else' is a valid keyword after a begin as in begin-else-end
&nbsp;
 - 'whennot' - is a reversed 'when' - true if the expression doesn't match
&nbsp;
 - 'if' is an alias to 'when'
&nbsp;
 - 'ifnot' is an alias to 'whennot'
&nbsp;
0.9
===
&nbsp;
 - 'when', 'begin', 'end' added
&nbsp;
 - 'abort' works
&nbsp;
 - options 'header' works
&nbsp;
 - the "hour" expression now supports 0000-2359 format too
&nbsp;
0.8
===
&nbsp;
  - Default file is named .mail2sms now.
&nbsp;
  - 'logfile' can redirect log messages from stderr to a file
&nbsp;
  - "prio &lt;value&gt;" is now a valid option for search/replace. value is 1 - 5
    lower prio values search/replace is done before higher values.
&nbsp;
  - 'log' keyword adds a string to output in the log when the search/replace
    is done (for debugging mostly)
&nbsp;
  - valid/invalid seem to work more as expected now
&nbsp;
  - 'day' in valid/invalid was wrong
&nbsp;
0.7
===
  Daniel
&nbsp;
  - More docs.
&nbsp;
  - Max time added. 10 seconds then it breaks.
&nbsp;
  - from, subject and body couldn't be set empty.
&nbsp;
  - Quotes in quoted strings in the config file weren't possible. They are
    now.
&nbsp;
  - Search pattern error messages pointed out wrong line number.
&nbsp;
0.6
===
&nbsp;
  Daniel
  - 'valid' and 'invalid' are now recognized in the config file.
    They specify expressions that validates or invalidates the continuation.
&nbsp;
    The EXPRESSION may involve:
&nbsp;
     day &lt;sequence 1 - 31&gt;
     hour &lt;sequence 0 - 23&gt;
     wday &lt;sequence 1 - 7&gt;
     month &lt;sequence 1 - 12&gt;
     year &lt;sequence 1998 - 2038&gt;
     file &lt;filename&gt;
&nbsp;
    Sequences can be specified as:
&nbsp;
	1-4,2,4-9-3 (no whitespace)
&nbsp;
    Filename is a filename without whitespace.
&nbsp;
    You can combine the different parts of an expression to a combined
    expression as in:
&nbsp;
	day 1-3 hour 8-14 wday 1,3,6
&nbsp;
    If you use several lines like:
&nbsp;
	    valid: &lt;expression&gt;
&nbsp;
    It is enough if one of the expressions are valid for this to succeed.
&nbsp;
    If you use several lines like:
&nbsp;
	    invalid: &lt;expression&gt;
&nbsp;
    It is enough if one of the expressions are invalid for this to be
    treated as invalid.
&nbsp;
    It is not recommended to mix valid and invalid lines unless you know what
    you're doing.
&nbsp;
  - Corrected the \&lt;num&gt; problem in replace strings.
&nbsp;
  - Corrected the "random" crashes Kjell found.
&nbsp;
  - Accepts the long form of 'options', 'search' and 'replace' now in the
    config file.
&nbsp;
0.5
===
  Daniel (Dec 3, 1998)
  - Replaces all ASCII characters below 32 with a plain space.
&nbsp;
0.4
===
  - Doesn't crash when run with no input.
