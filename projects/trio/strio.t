<!-- generated with roffit 0.7 -->

<p class="level0"><pre>
<p class="level0"><p class="level0"></pre>

<p class="level0"><a name="NAME"></a><h2 class="nroffsh">NAME</h2>
<p class="level0">StrAlloc,  StrAppend,  StrAppendMax,  StrContains,  StrCopy,  StrCopyMax,  StrDuplicate,  StrDuplicateMax,  StrEqual,  StrEqualMax,  StrEqualCase,  StrEqualCaseMax,  StrError,  StrFormat,  StrFormatMax,  StrFormatDateMax,  StrFree,  StrHash,  StrIndex,  StrIndexLast,  StrLength,  StrMatch,  StrMatchCase,  StrScan,  StrSpanFunction,  StrSubstring,  StrSubstringMax,  StrTokenize,  StrToDouble,  StrToFloat,  StrToLong,  StrToUnsignedLong,  StrToUpper  - string functions  
<p class="level0"><a name="SYNOPSIS"></a><h2 class="nroffsh">SYNOPSIS</h2>
<p class="level0">
<p class="level0">cc ... -ltrio -lm 
<p class="level0">#include &lt;strio.h&gt; 
<p class="level0">See section Functions below for the prototypes of the string functions.  
<p class="level0"><a name="DESCRIPTION"></a><h2 class="nroffsh">DESCRIPTION</h2>
<p class="level0">This package renames, fixes, and extends the C string handling functions.  
<p class="level0"><a name="NAMING"></a><h2 class="nroffsh">NAMING</h2>
<p class="level0">Renaming is done to provide more clear names, to provide a consistant naming  and argument policy, and to hide portability issues. <br>
<p class="level0"><span Class="bold">*</span> All functions starts with "Str". <br>
<p class="level0"><span Class="bold">*</span> Target is always the first argument, if present, except where the target  is optional, such as StrToDouble(). 
<p class="level0"><span Class="bold">*</span> Functions requiring a size for target ends with "Max", and the size is  always the second argument.  
<p class="level0"><a name="FIXING"></a><h2 class="nroffsh">FIXING</h2>
<p class="level0">Fixing is done to avoid subtle error conditions.  For example, strncpy() does not terminate the result with a zero if  the source string is bigger than the maximal length, so technically the result  is not a C string anymore. StrCopyMax() makes sure that the result is  zero terminated.  
<p class="level0"><a name="EXTENDING"></a><h2 class="nroffsh">EXTENDING</h2>
<p class="level0">Extending is done to provide a richer set of fundamental functions.  This includes wildcard matching (StrMatch()) and calculation of  hash values (StrHash()). 
<p class="level0"><a name="FUNCTIONS"></a><h2 class="nroffsh">FUNCTIONS</h2>
<p class="level0">
<p class="level0">
<p class="level0">char *StrAlloc(size_t size); <br>Allocate a string with  <span Class="emphasis">size</span> characters (including terminating zero).  This string is freed again with StrFree(). 
<p class="level0">
<p class="level0">char *StrAppend(char *target, char *source); <br>Append source at the end of  <span Class="emphasis">target.</span> 
<p class="level0">
<p class="level0">char *StrAppendMax(char *target, size_t max, const char *source); <br>Append  <span Class="emphasis">source</span> at the end of  <span Class="emphasis">target.</span> Make sure that the result  does not exceed  <span Class="emphasis">max</span> characters.  <span Class="emphasis">max</span> must be greater than the  length of  <span Class="emphasis">target.</span> 
<p class="level0">
<p class="level0">int StrContains(const char *string, const char *substring); <br>Returns true if  <span Class="emphasis">string</span> contains at least one appearance of  <span Class="emphasis">substring.</span> 
<p class="level0">
<p class="level0">char *StrCopy(char *target, const char *source); <br>Copy the contents of  <span Class="emphasis">source</span> to  <span Class="emphasis">target.</span> 
<p class="level0">
<p class="level0">char *StrCopyMax(char *target, size_t max, const char *source); <br>Copy the contents of  <span Class="emphasis">source</span> to  <span Class="emphasis">target.</span> Make sure that the  result does not exceed  <span Class="emphasis">max</span> characters. Excessive characters are  discarded in the result.  
<p class="level0">
<p class="level0">char *StrDuplicate(const char *source); <br>Allocate a new string which contains a copy of  <span Class="emphasis">source.</span> 
<p class="level0">
<p class="level0">char *StrDuplicateMax(const char *source, size_t max); <br>Allocate a new string which contains a copy of  <span Class="emphasis">source.</span> At most  <span Class="emphasis">max</span> characters are allocated and copied to the result.  
<p class="level0">
<p class="level0">int StrEqual(const char *first, const char *second); <br>Return true if  <span Class="emphasis">first</span> and  <span Class="emphasis">second</span> are equal.  Not case-sensitive.  
<p class="level0">
<p class="level0">int StrEqualMax(const char *first, size_t max, const char *second); <br>Return true if at most the first  <span Class="emphasis">max</span> characters of  <span Class="emphasis">first</span> and  <span Class="emphasis">second</span> are equal. Not case-sensitive.  
<p class="level0">
<p class="level0">int StrEqualCase(const char *first, const char *second); <br>
<p class="level0">
<p class="level0">int StrEqualCaseMax(const char *first, size_t max, const char *second); <br>
<p class="level0">
<p class="level0">const char *StrError(int errno); <br>
<p class="level0">
<p class="level0">int StrFormat(char *target, const char *format, ...); <br>
<p class="level0">
<p class="level0">int StrFormatMax(char *target, size_t max, const char *format, ...); <br>
<p class="level0">
<p class="level0">int StrFormatDateMax(char *target, size_t max, const char *format, const struct tm *datetime); <br>
<p class="level0">
<p class="level0">int StrFree(char *target); <br>Free a string allocated by StrAlloc(), StrDuplicate(), or  StrDuplicateMax(). 
<p class="level0">
<p class="level0">unsigned long StrHash(const char *source, int type); <br>
<p class="level0">
<p class="level0">char *StrIndex(char *string, int character); <br>
<p class="level0">
<p class="level0">char *StrIndexLast(char *string, int character); <br>
<p class="level0">
<p class="level0">size_t StrLength(char *source); <br>
<p class="level0">
<p class="level0">int StrMatch(char *string, char *pattern); <br>
<p class="level0">
<p class="level0">int StrMatchCase(char *string, char *pattern); <br>
<p class="level0">
<p class="level0">int StrScan(char *source, const char *format, ...); <br>
<p class="level0">
<p class="level0">size_t StrSpanFunction(char *target, int (*Function)(int)); <br>
<p class="level0">
<p class="level0">char *StrSubstring(const char *string, const char *substring); <br>
<p class="level0">
<p class="level0">char *StrSubstringMax(const char *string, size_t max, const char *substring); <br>
<p class="level0">
<p class="level0">char *StrTokenize(char *target, const char *delimiter); <br>
<p class="level0">
<p class="level0">double StrToDouble(const char *source, const char **target); <br>
<p class="level0">
<p class="level0">float StrToFloat(const char *source, const char **target); <br>
<p class="level0">
<p class="level0">long StrToLong(const char *source, const char **target, int base); <br>
<p class="level0">
<p class="level0">unsigned long StrToUnsignedLong(const char *source, const char **target, int base); <br>
<p class="level0">
<p class="level0">int StrToUpper(char *target); <br>
<p class="level0"><a name="SEE"></a><h2 class="nroffsh">SEE ALSO</h2>
<p class="level0"><span Class="emphasis">trio_printf</span> (3), <span Class="emphasis">trio_scanf</span> (3) 
<p class="level0"><a name="LEGAL"></a><h2 class="nroffsh">LEGAL ISSUES</h2>
<p class="level0">Copyright (C) 1998-2000 Bjorn Reese and Daniel Stenberg.  
<p class="level0">Permission to use, copy, modify, and distribute this software for any  purpose with or without fee is hereby granted, provided that the above  copyright notice and this permission notice appear in all copies.  
<p class="level0">THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED  WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF  MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE AUTHORS AND  CONTRIBUTORS ACCEPT NO RESPONSIBILITY IN ANY CONCEIVABLE MANNER.  <p class="roffit">
 This HTML page was made with <a href="http://daniel.haxx.se/projects/roffit/">roffit</a>.
