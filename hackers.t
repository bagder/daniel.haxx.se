#include "doctype.t"
#include "setup.t"
HEAD(Daniel Stenberg -- Hacking ups and downs)
#include "body.t"
#include "daniel.t"

TITLE(Hackers Are The Good People)
BOXTOP

<p>

  I consider myself a "hacker". I never went to college or university. I've
  spent thousands of spare-time hours in front of my various home
  computers. I've been programming since I was 14. I know assembler for
  several CPUs. I've participated in numerous <a
  href="http://www.opensource.org">Open Source</a> projects for more than 25
  years. I think I master every dusty corner of the language C. I'm very
  interested in network and security issues with a Unix angle. I avoid crappy
  operating systems. I run Linux machines. I know Unix. I continuously use
  Unix systems and write Unix programs on my spare time. I know HTML. I've
  written lots of CGI's, shell scripts and perl things. I know how TCP/IP
  works. I know PPP and its sub protocols. I've written multi platform
  networking servers and clients. I've written my own interpreted script
  language with a separate compiler and I've written action-filled computer
  games. I've written device drivers on numerous operating systems, and even
  on Linux running on many different CPUs.

SUBTITLE(Coding Is An Art)
<p>
  I consider coding an art. I really do. Good coders are cool people and
  coders who aren't good shouldn't be paid to code. Good coders are not as
  popular nor important today that I'd like them to be. Quality code is
  usually a forgotten issue in the huge corporate developing of today. All
  people are thought to do equally good. I wish people one day will realize
  that some people do better code, some do worse code. I'll become more
  appreciated that day.
<p>
  You simply aren't a skilled programmer after a few years in college. You
  need time and time in front of a computer bent over a keyboard. You need
  hundreds of hard hours hacking.
BOXBOT

<p>

TITLE(Guide to Successful Living)
BOXTOP
<small>This gets updated every now and then when I come to think of things</small>

<p>
  <b>Master C and the tools you write it in</b><br>
  To be a successful C programmer, you simply have to be skilled in the art of
  writing and using the language C. Basic knowledge takes you nowhere.  Be an
  expert, or try another profession. You can never write fast and good code if
  you don't work quick n' easy in the text-editor of your choice.

<p>
  <b>Know your target hardware and its oddities</b><br>

  Although C is a somewhat higher level language than plain assembler, there
  are still many many times you can optimize the code you write depending on
  the nature of the CPU and other hardware that is gonna run the final result
  of your program.

<p>
  <b>Go with your first hunch</b><br>
  Don't let the less knowing point you in the wrong direction or let them
  design things just because you aren't 100% involved in a subject, believing
  that they who decide are. Always object if your first hunch says you are
  right.
#if 0
<p>
  <b>Ban 'const' from your code</b><br>
  You will be sorry sooner or later when you introduce 'const' char pointers
  in your C code. At some point you will need to assign a regular pointer the
  value of the const pointer and then the compiler will puke on you and your
  code.
#endif
<p>
  <b>Don't follow silly coding rules (like no #include within include files)</b><br>
  Silly coding rules making writing good and fast code a lot harder.
  Forbidding #include from include files can make a single change in a single
  header file affect lots and lots of other source files and require every one
  of them to get modified.

<p>
  <b>What is the point with hungarian/other prefix/suffix systems?</b><br>
  In large software projects development teams very often setup rules of how
  to write variable, function, define, struct and typedef names. They often
  involve prefixes and suffixes, more or less complicated. Not only do many of
  the persons have their own opinions of how the rules should be interpreted
  but changes to sources often don't change the prefix/suffixes (making them
  wrong is in my eyes far worse than having none at all).

<p>
  <b>Avoid identical code parts, use loops where applicable.</b><br>
  Very very many newbies, and even a little more experienced programmers use
  extensive cut n' pasting when programming, making long sequences of nearly
  identical program parts instead of making loops. While this may be a quick
  way to make a quick first version, updating and extending such a source code
  is a pain.

<p>
  <b>avoid using own (typedef'ed) types in header files included by many files</b><br>
  if the typedefs aren't in the same file
  What happens when your functions return their own typedef'ed type ? The
  sources that use your function have to include the files keeping your
  typedefs and they have to use your typedefs to store the result of your
  function(s)... Using plain C variable types is a lot better, and no
  assumptions or silly data conversions will be needed.
<p>
  <b>do not typedef away pointers to structs</b><br> Very often I end up
  looking at code where programmers typedef away a pointer to a struct in a
  manner like 'typedef struct foobar * foopoint', so that they all over the
  code can use <i>foopoint</i> instead of <i>struct foobar *</i>. I do not
  consider that productive, as it hides the true nature of the variable. C is
  not the language to use if you wanna hide things like that. In my eyes a
  construction where you declare a variable like 'foopoint boo = NULL' looks
  like your trying to do something illegal, since the lack of asterisks
  implies it isn't a pointer. It makes the code harder to read.

BOXBOT

#include "footer.t"

