<!-- generated with roffit 0.7 -->

<p class="level0"><pre>
<p class="level0"><p class="level0"></pre>

<p class="level0"><a name="NAME"></a><h2 class="nroffsh">NAME</h2>
<p class="level0">trio_scanf,  trio_vscanf,  trio_fscanf,  trio_vfscanf,  trio_dscanf,  trio_vdscanf,  trio_sscanf,  trio_vsscanf  - formatted input conversion  
<p class="level0"><a name="SYNOPSIS"></a><h2 class="nroffsh">SYNOPSIS</h2>
<p class="level0">
<p class="level0">cc ... -ltrio -lm 
<p class="level0">#include &lt;trio.h&gt; 
<p class="level0">int trio_scanf(const char *format, ...); <br>int trio_vscanf(const char *format, va_list args); <br>int trio_fscanf(FILE *file, const char *format, ...); <br>int trio_vfscanf(FILE *file, const char *format, va_list args); <br>int trio_dscanf(int fd, const char *format, ...); <br>int trio_vdscanf(int fd, const char *format, va_list args); <br>int trio_sscanf(const char *buffer, const char *format, ...); <br>int trio_vsscanf(const char *buffer, const char *format, va_list args); <br>
<p class="level0"><a name="DESCRIPTION"></a><h2 class="nroffsh">DESCRIPTION</h2>
<p class="level0">This documentation is incomplete.  The documentation of the scanf family in [C99] and [UNIX98] also applies  to the trio counterparts.  
<p class="level0"><a name="SCANNING"></a><h2 class="nroffsh">SCANNING</h2>
<p class="level0">
<p class="level0">The scanning is controlled by the format string.  The format string can contain normal text and conversion indicators.  The normal text can be any character except the nil character  (ASCII 000 = '0') and the percent character (ASCII 045 = '%').  Conversion indicators consists of an indication character (%), followed by  zero or more conversion modifiers, and exactly one conversion specifier.  
<p class="level0"><a name="MODIFIERS"></a><h2 class="nroffsh">MODIFIERS</h2>
<p class="level0">
<p class="level0">
<p class="level0">Positional (9$) [UNIX98] <br>See  <span Class="emphasis">trio_printf</span> (3). 
<p class="level0"><a name="SPECIFIERS"></a><h2 class="nroffsh">SPECIFIERS</h2>
<p class="level0">
<p class="level0">
<p class="level1">
<p class="level1">Percent (%) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Character (c) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Decimal (d) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Floating-point (a, e, E, f, F, g, G) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Integer (i) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Count (n) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Octal (o) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Pointer (p) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">String (s) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Unsigned (u) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Hex (x, X) <br>
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level1">Scanlist ([]) <br>
<p class="level2">
<p class="level2">
<p class="level3">
<p class="level2">
<p class="level2">Exclusion (^) <br>
<p class="level3">
<p class="level3">
<p class="level2">
<p class="level2">Range (-) [TRIO] <br>
<p class="level3">
<p class="level3"><span Class="bold">*</span> Only increasing ranges, i.e. [a-b], but not [b-a].  
<p class="level3"><span Class="bold">*</span> Transitive ranges, ie. [a-b-c] equals [a-c].  
<p class="level3"><span Class="bold">*</span> Trailing minus, ie. [a-] is interpreted as an 'a' and a '-'.  
<p class="level3"><span Class="bold">*</span> Duplicates are ignored.  
<p class="level2">
<p class="level3">
<p class="level3">
<p class="level2">
<p class="level2">Class Expression (::) [TRIO] <br>Locale dependent (LC_CTYPE)  
<p class="level3">
<p class="level3">:alnum: :alpha: and :digit:  
<p class="level3">:alpha: :lower: and :upper:  
<p class="level3">:cntrl: Control characters  
<p class="level3">:digit: Decimal digits  
<p class="level3">:graph: Printable characters except space  
<p class="level3">:lower: Lower case alphabetic letters  
<p class="level3">:print: Printable characters  
<p class="level3">:punct: Punctuation  
<p class="level3">:space: Whitespace characters  
<p class="level3">:upper: Upper case alphabetic letters  
<p class="level3">:xdigit: Hexadecimal digits  
<p class="level2">
<p class="level3">
<p class="level3">
<p class="level2">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level-1">
<p class="level-1"><a name="RETURN"></a><h2 class="nroffsh">RETURN VALUES</h2>
<p class="level0"><a name="SEE"></a><h2 class="nroffsh">SEE ALSO</h2>
<p class="level0"><span Class="emphasis">trio_printf</span> (3) 
<p class="level0"><a name="CONFORMING"></a><h2 class="nroffsh">CONFORMING TO</h2>
<p class="level0">See the description of  <span Class="emphasis">trio_printf</span> (3). 
<p class="level0"><a name="LEGAL"></a><h2 class="nroffsh">LEGAL ISSUES</h2>
<p class="level0">Copyright (C) 1998-2000 Bjorn Reese and Daniel Stenberg.  
<p class="level0">Permission to use, copy, modify, and distribute this software for any  purpose with or without fee is hereby granted, provided that the above  copyright notice and this permission notice appear in all copies.  
<p class="level0">THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED  WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF  MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE AUTHORS AND  CONTRIBUTORS ACCEPT NO RESPONSIBILITY IN ANY CONCEIVABLE MANNER.  <p class="roffit">
 This HTML page was made with <a href="http://daniel.haxx.se/projects/roffit/">roffit</a>.
