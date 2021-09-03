<!-- generated with roffit 0.7 -->

<p class="level0"><pre>
<p class="level0"><p class="level0"></pre>

<p class="level0"><a name="NAME"></a><h2 class="nroffsh">NAME</h2>
<p class="level0">trio_printf,  trio_fprintf,  trio_sprintf,  trio_snprintf,  trio_snprintfcat,  trio_aprintf,  trio_vprintf,  trio_vfprintf,  trio_vsprintf,  trio_vsnprintf,  trio_vaprintf  - formatted output conversion  
<p class="level0"><a name="SYNOPSIS"></a><h2 class="nroffsh">SYNOPSIS</h2>
<p class="level0">
<p class="level0">cc ... -ltrio -lm 
<p class="level0">#include &lt;trio.h&gt; 
<p class="level0">int trio_printf(const char *format, ...); <br>int trio_fprintf(FILE *file, const char *format, ...); <br>int trio_dprintf(int fd, const char *format, ...); <br>int trio_sprintf(char *buffer, const char *format, ...); <br>int trio_snprintf(char *buffer, size_t max, const char *format, ...); <br>int trio_snprintfcat(char *buffer, size_t max, const char *format, ...); <br>int trio_asprintf(char **buffer, const char *format, ...); <br>int trio_vprintf(const char *format, va_list args); <br>int trio_vfprintf(FILE *file, const char *format, va_list args); <br>int trio_vdprintf(int fd, const char *format, va_list args); <br>int trio_vsprintf(char *buffer, const char *format, va_list args); <br>int trio_vsnprintf(char *buffer, size_t bufferSize, const char *format, va_list args); <br>int trio_vasprintf(char **buffer, const char *format, va_list args); 
<p class="level0"><a name="DESCRIPTION"></a><h2 class="nroffsh">DESCRIPTION</h2>
<p class="level0">This documentation is incomplete.  The documentation of the printf family in [C99] and [UNIX98] also applies  to the trio counterparts.  
<p class="level0">All these functions outputs a string which is formatted according to the  <span Class="emphasis">format</span> string and the consecutive arguments. The  <span Class="emphasis">format</span> string  is described in the Formatting section below.  
<p class="level0"><span Class="manpage">trio_printf</span> and  <span Class="manpage">trio_vprintf</span> writes the output to the  standard output stream (stdout).  
<p class="level0"><span Class="manpage">trio_fprintf</span> and  <span Class="manpage">trio_vfprintf</span> writes the output to a given  output stream.  
<p class="level0"><span Class="manpage">trio_dprintf</span> and  <span Class="manpage">trio_vdprintf</span> writes the output to a file  descriptor (this includes, for example, sockets).  
<p class="level0"><span Class="manpage">trio_sprintf</span> and  <span Class="manpage">trio_vsprintf</span> writes the output into  <span Class="emphasis">buffer.</span> 
<p class="level0"><span Class="manpage">trio_snprintf</span> and  <span Class="manpage">trio_vsnprintf</span> writes  <span Class="emphasis">max</span> - 1  characters into  <span Class="emphasis">buffer</span> followed by a terminating zero character. If  <span Class="emphasis">max</span> is 1, then  <span Class="emphasis">buffer</span> will be an empty string. If  <span Class="emphasis">max</span> is 0,  then  <span Class="emphasis">buffer</span> is left untouched, and can consequently be NULL. The number of characters that would have been written to  <span Class="emphasis">buffer,</span> had  there been sufficient space, is returned.  
<p class="level0"><span Class="manpage">trio_snprintfcat</span> appends the formatted text at the end of  <span Class="emphasis">buffer.</span> 
<p class="level0"><span Class="manpage">trio_asprintf</span> and  <span Class="manpage">trio_vasprintf</span> allocates and returns a  string in  <span Class="emphasis">buffer</span> containing the formatted text.  
<p class="level0"><a name="FORMATTING"></a><h2 class="nroffsh">FORMATTING</h2>
<p class="level0">
<p class="level0">The  <span Class="emphasis">format</span> string can contain normal text and conversion indicators.  The normal text can be any character except the nil character  (ASCII 000 = '0') and the percent character (ASCII 045 = '%').  Conversion indicators consists of an indication character (%), followed by  zero or more conversion modifiers, and exactly one conversion specifier.  
<p class="level0">NOTE: The examples below are missing the n character. This was omitted to  improve readability. To make trio_printf actually print the formatted text,  the n character must be added to the examples. Furthermore, the |  character is used to clarify the output.  
<p class="level0"><a name="MODIFIERS"></a><h2 class="nroffsh">MODIFIERS</h2>
<p class="level0">
<p class="level0">Some modifiers exhibit the same behaviour for all specifiers, other modifiers  indicate different behaviours for different specifiers, and other modifiers  are only applicable to certain specifiers. The relationship is described for  each modifier. The number 9 is used to denotes an arbitary integer.  
<p class="level0">
<p class="level0">Positional (9$) [UNIX98] <br>Normally the arguments supplied to these functions are interpreted  incrementially from left to right. Arguments can be referenced specifically in  the format string. The modifier n$ selects the nth argument. The first  argument is referred as 1$. If this modifier is used, it must be the first  modifier after the indication character. n$ can also be used for argument  width, precision, and base. <br>The performance penalty of using positionals is almost neglible (contrary to  most other printf implementations). <br>
<p class="level1">
<p class="level1">Mixing <br>Mixing normal and positional specifiers is allowed [TRIO]. For example,  trio_printf("%d %3$d %2$d", 1, 2, 3); results in "1 3 2". <br>Arguments for the printf family are passed on the stack. On most platforms it  is not possible to determine the size of individual stack elements, so it is  essential that the format string corresponds exactly to the passed arguments.  If this is not the case, incorrect values may be put into the result.  
<p class="level1">Reference Gap <br>For the same reason it is also essential that the format string does not  contain any "gaps" in the positional arguments. For example,  trio_printf("%1$d %3$d", 1, 2, 3); is NOT allowed. The format  string parser has no knowledge about whether the second argument is, say, an  integer or a long double (which have different sizes). <br>[UNIX98] describes this as unspecified behaviour. [TRIO] will detect reference  gaps and return an error.  
<p class="level1">Double Reference <br>It is also not allowed to reference an argument twice or more. For example,  trio_printf("%1$d %1$lf", 1); is NOT allowed, because it  references the first argument as two differently sized objects. <br>[UNIX98] describes this as unspecified behaviour. [TRIO] will detect double  references and return an error.  
<p class="level0">
<p class="level1">
<p class="level1">The following two statements are equivalent  
<p class="level2">
<p class="level1">
<p class="level1">1. trio_printf("|%d %s|", 42, "meanings"); <br>|42 meanings|  
<p class="level1">2. trio_printf("|%1$d %2$s|", 42, "meanings"); <br>|42 meanings|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Width (9) <br>Specifies the minimum width of a field. If the fields has less characters than  specified by the width, the field will be left adjusted and padded by spaces.  The adjustment and padding can be changed by the Alignment (-) and Padding (0)  modifiers. <br>The width is specified as a number. If an asterix (*) is used instead, the  width will be read from the argument list. <br>Prefixes, such as 0x for hexadecimal integers, are part of width. <br>
<p class="level1">
<p class="level1">1. trio_printf("|%10i|", 42); <br>|        42|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Precision (.9) <br>
<p class="level0">
<p class="level1">
<p class="level1">1. trio_printf("|%10.8i|%.8i|", 42, 42); <br>|  00000042|00000042|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Base (..9) [TRIO] <br>Sets the base that the associated integer must be converted to. The base can  be between 2 and 36 (both included).  
<p class="level0">
<p class="level1">
<p class="level1">1. trio_printf("|%10.8.2i|%10..2i|%..2i|", 42, 42, 42); <br>|  00101010|    101010|101010|  
<p class="level1">2. trio_printf("|%*.8.*i|", 10, 2, 42); <br>|  00101010|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Padding (0) <br>This modifier means that (integer and floating point) numbers are prepended by  zeros. The number of leading zeros are determined by the precision. If  precision is not present width is used instead.  
<p class="level0">
<p class="level0">Short (h) <br>The argument is read as an (unsigned) short int. 
<p class="level0">
<p class="level0">Short short (hh) [C99, GNU] <br>The argument is read as an (unsigned) char. 
<p class="level0">
<p class="level0">Largest (j) [C99] <br>The argument is read as an intmax_t/uintmax_t, which is  defined to be the largest signed/unsigned integer.  
<p class="level0">
<p class="level0">Long (l) <br>The argument is read as an (unsigned) long int. 
<p class="level0">
<p class="level0">Long long (ll) [C99, UNIX98, GNU] <br>The argument is read as an (unsigned) long long int. 
<p class="level0">
<p class="level0">Long double (L) [C99, UNIX98, GNU] <br>The argument is read as a long double. 
<p class="level0">
<p class="level0">ptrdiff_t (t) [C99] <br>The argument is read as a ptrdiff_t, which is defined to be the  signed integer type of the result of subtracting two pointers.  
<p class="level0">
<p class="level0">Quad (q) [BSD, GNU] <br>Corresponds to the long long modifier (ll).  
<p class="level0">
<p class="level0">size_t (z) [C99] <br>The argument is read as a size_t, which is defined to be the type  returned by the sizeof operator.  
<p class="level0">
<p class="level0">size_t (Z) [GNU] <br>Corresponds to the size_t modifier (z).  
<p class="level0">
<p class="level0">Alternative (#) <br>
<p class="level0">
<p class="level0">Spacing ( ) <br>
<p class="level0">
<p class="level0">Sign (+) <br>Always prepend a sign to numbers. Normally only the negative sign is prepended  to a number. With this modifier the positive sign may also be prepended.  
<p class="level0">
<p class="level0">Alignment (-) <br>The output will be left-justified.  
<p class="level0">
<p class="level0">Argument (*) <br>
<p class="level0">
<p class="level0">Quote/Grouping (') [MISC] <br>Groups integers and the integer-part of floating-point numbers according to  the locale.  
<p class="level0">
<p class="level0">Sticky (!) [TRIO] <br>The modifiers listed for the current specifier will be reused by subsequent  specifiers of the same group. <br>The following specifier groups exists  
<p class="level1">
<p class="level1"><span Class="bold">*</span> Integers (i, u, d, o, x, X)  
<p class="level1"><span Class="bold">*</span> Floating-point (f, F, e, E, g, G, a, A)  
<p class="level1"><span Class="bold">*</span> Characters (c, C)  
<p class="level1"><span Class="bold">*</span> Strings (s, S)  
<p class="level1"><span Class="bold">*</span> Pointer (p)  
<p class="level1"><span Class="bold">*</span> Count (n)  
<p class="level1"><span Class="bold">*</span> Errno (m)  
<p class="level1"><span Class="bold">*</span> Group ([])  
<p class="level0">
<p class="level1">
<p class="level1">The sticky modifiers are active until superseeded by other sticky modifiers,  or the end of the format string is reached. <br>Local modifiers overrides sticky modifiers for the given specifier only.  
<p class="level1">
<p class="level2">
<p class="level1">
<p class="level1">1. trio_printf("|%!08#x|%04x|%x|", 42, 42, 42); <br>|0x00002a|0x2a|0x00002a|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Allocate (&lt;alloc&gt;) [TRIO] <br>
<p class="level0"><a name="SPECIFIERS"></a><h2 class="nroffsh">SPECIFIERS</h2>
<p class="level0">
<p class="level0">
<p class="level0">Percent (%) <br>Produce a percent (%) character. This is used to quote the indication  character. No modifiers are allowed. The full syntax is "%%".  
<p class="level0">
<p class="level1">
<p class="level1">1. trio_printf("Percent is %%"); <br>Percent is %  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Hex floats (a, A) [C99] <br>Output a hexadecimal (base 16) representation of a floating point number. The  number is automatically preceeded by 0x (or 0X). The exponent is 'p' (or 'P').  
<p class="level0">
<p class="level1">
<p class="level1">1. trio_printf("|%a|%A|", 3.1415, 3.1415e20); <br>|0x3.228bc|0X3.228BCP+14|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Binary numbers (b, B) [MISC - SCO UnixWare 7] <br>DEPRECATED: Use Base %..2i instead.  
<p class="level0">
<p class="level0">Character (c) <br>Output a single character.  
<p class="level1">
<p class="level1"><span Class="bold">*</span> Quote (') [TRIO] <br>Quote the character  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Decimal (d) <br>Output a decimal (base 10) representation of a number.  
<p class="level1">
<p class="level1"><span Class="bold">*</span> Grouping (') [TRIO] <br>The number is separated by the locale thousand separator.  
<p class="level0">
<p class="level1">
<p class="level1">Assuming the thousand separator is comma and the grouping is set to 3  
<p class="level2">
<p class="level1">
<p class="level1">1. trio_printf("|%'ld|", 1234567); <br>|1,234,567|  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Floating-point (e, E) <br>Output a decimal floating-point number.  The style is  <span Class="manpage">[\-]9.99e[\-]9</span> where  
<p class="level1">
<p class="level1"><span Class="manpage">[\-]9.99</span> is the mantissa (as described for the f, F specifier),  
<p class="level1"><span Class="manpage">e[\-]9</span> is the exponent indicator (either e or E, depending on the floating-point specifier), followed by an optional sign and the exponent  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Floating-point (f, F) <br>Output a decimal floating-point number.  The style is  <span Class="manpage">[\-]9.99</span> where  
<p class="level1">
<p class="level1"><span Class="manpage">[\-]</span> is an optional sign (either + or -),  
<p class="level1"><span Class="manpage">9</span> is the integer-part (possibly interspersed with thousand-separators),  
<p class="level1"><span Class="manpage">.</span> is the decimal-point (depending on the locale), and  
<p class="level1"><span Class="manpage">99</span> is the fractional-part.  
<p class="level0">
<p class="level1">
<p class="level1">The following modifiers holds a special meaning for this specifier  
<p class="level2">
<p class="level1">
<p class="level1"><span Class="bold">*</span> Alternative (#) [C99] <br>Add decimal point.  
<p class="level1"><span Class="bold">*</span> Grouping (') [TRIO] <br>Group integer part of number into thousands.  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">Floating-point (g, G) <br>Output a decimal floating-point representation of a number. The format of  either the f, F specifier or the e, E specifier is used, whatever  produces the shortest result.  
<p class="level0">
<p class="level0">Integer (i) <br>Output a signed integer. Default base is 10.  
<p class="level0">
<p class="level0">Errno (m) [GNU] <br>
<p class="level0">
<p class="level0">Count (n) <br>Insert into the location pointed to by the argument, the number of octets  written to the output so far.  
<p class="level0">
<p class="level0">Octal (o) <br>Output an octal (base 8) representation of a number.  
<p class="level0">
<p class="level0">Pointer (p) <br>Ouput the address of the argument. The address is printed as a hexadecimal  number. If the argument is the NULL pointer the text "(nil)" will be  used instead.  
<p class="level1">
<p class="level1"><span Class="bold">*</span> Alternative (#) [TRIO] <br>Prepend 0x  
<p class="level0">
<p class="level1">
<p class="level1">
<p class="level0">
<p class="level0">String (s) <br>Output a string. The argument must point to a zero terminated string. If the  argument is the NULL pointer the text "(nil)" will be used  instead.  
<p class="level1">
<p class="level1"><span Class="bold">*</span> Quote (') [TRIO] <br>Quote the string.  
<p class="level1"><span Class="bold">*</span> Alternative (#) [TRIO] <br>Non-printable characters are converted into C escapes, or hexadecimal numbers  where no C escapes exists for the character. The C escapes, the hexadecimal  number, and all backslashes are prepended by a backslash (). The known  C escapes are  
<p class="level2">
<p class="level2">a (ASCII 007) = alert  
<p class="level2">b (ASCII 010) = backspace  
<p class="level2">f (ASCII 014) = formfeed  
<p class="level2">n (ASCII 012) = newline  
<p class="level2">r (ASCII 015) = carriage return  
<p class="level2">t (ASCII 011) = horizontal tab  
<p class="level2">v (ASCII 013) = vertical tab  
<p class="level1">
<p class="level2">
<p class="level2">
<p class="level1">
<p class="level0">
<p class="level0">
<p class="level1">
<p class="level0">
<p class="level0">1. trio_printf("|One %s Three|One %'s Three|", "Two", "Two"); <br>|One Two Three|One "Two" Three|  
<p class="level0">2. trio_printf("|Argument missing %s|", NULL); <br>|Argument missing (nil)|  
<p class="level0">3. trio_printf("|%#s|", "007 a."); <br>|a a.|  
<p class="level-1">
<p class="level0">
<p class="level0">
<p class="level-1">
<p class="level-1">Unsigned (u) <br>Output an unsigned integer. Default base is 10.  
<p class="level-1">
<p class="level-1">Hex (x, X) <br>Output a hexadecimal (base 16) representation of a number.  
<p class="level0">
<p class="level0"><span Class="bold">*</span> Alternative (#) <br>Preceed the number by 0x (or 0X). The two characters are counted as part of  the width.  
<p class="level-1">
<p class="level0">
<p class="level0">
<p class="level-1">
<p class="level-1"><a name="RETURN"></a><h2 class="nroffsh">RETURN VALUES</h2>
<p class="level0">All functions returns the number of outputted characters. If an error occured  then a negative error code is returned [TRIO]. Note that this is a deviation  from the standard, which simply returns -1 (or EOF) and errno set  appropriately.  The error condition can be detected by checking whether the function returns  a negative number or not, and the number can be parsed with the following  macros. The error codes are primarily intended as debugging aide for the  developer.  
<p class="level0">Example:  
<p class="level0">
<p class="level0">int rc; 
<p class="level0">rc = trio_printf("%r", 42); if (rc &lt; 0) { &nbsp; if (TRIO_ERROR_CODE(rc) != TRIO_EOF) { &nbsp;   trio_printf("Error: &nbsp;at position 0n", &nbsp;               TRIO_ERROR_NAME(rc), &nbsp;               TRIO_ERROR_POSITION(rc)); &nbsp; } } 
<p class="level0">rc = trio_printf("%r", 42); if (rc &lt; 0) { &nbsp; if (TRIO_ERROR_CODE(rc) != TRIO_EOF) { &nbsp;   trio_printf("Error: &nbsp;at position 0n", &nbsp;               TRIO_ERROR_NAME(rc), &nbsp;               TRIO_ERROR_POSITION(rc)); &nbsp; } } 
<p class="level0"><a name="SEE"></a><h2 class="nroffsh">SEE ALSO</h2>
<p class="level0"><span Class="emphasis">trio_scanf</span> (3) 
<p class="level0"><a name="CONFORMING"></a><h2 class="nroffsh">CONFORMING TO</h2>
<p class="level0">Throughout this document the following abbreviations have been used to  indicate what standard a feature conforms to. If nothing else is indicated  ANSI C (C89) is assumed.  
<p class="level-1">
<p class="level-1">C89 ANSI X3.159-1989  
<p class="level-1">C99 ISO/IEC 9899:1999  
<p class="level-1">UNIX98 The Single UNIX Specification, Version 2  
<p class="level-1">BSD 4.4BSD  
<p class="level-1">GNU GNU libc  
<p class="level-1">MISC Other non-standard sources  
<p class="level-1">TRIO Extensions specific for this package  
<p class="level-1"><a name="LEGAL"></a><h2 class="nroffsh">LEGAL ISSUES</h2>
<p class="level0">Copyright (C) 1998-2000 Bjorn Reese and Daniel Stenberg.  
<p class="level0">Permission to use, copy, modify, and distribute this software for any  purpose with or without fee is hereby granted, provided that the above  copyright notice and this permission notice appear in all copies.  
<p class="level0">THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED  WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF  MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE AUTHORS AND  CONTRIBUTORS ACCEPT NO RESPONSIBILITY IN ANY CONCEIVABLE MANNER.  <p class="roffit">
 This HTML page was made with <a href="http://daniel.haxx.se/projects/roffit/">roffit</a>.
