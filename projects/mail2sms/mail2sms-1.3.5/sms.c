
#include <ctype.h>
#include <stdarg.h>
#include <stdlib.h>

#include "main.h"
#include "regex.h"
#include "sms.h"
#include "config.h"

#define BYTEWIDTH 8

extern int exitcode;

/* This is a list with all available keywords/instructions */
typedef enum {
  KEYWORD_NONE, /* must be the first one */
  KEYWORD_ABORT,
  KEYWORD_BEGIN,
  KEYWORD_BREAK,
  KEYWORD_CONFIG,
  KEYWORD_CREATE,
  KEYWORD_DELETE,
  KEYWORD_ELSE,
  KEYWORD_END,
  KEYWORD_ENDIF,
  KEYWORD_FILTER,
  KEYWORD_IF,
  KEYWORD_INCLUDE,
  KEYWORD_LOG,
  KEYWORD_LOGFILE,
  KEYWORD_MAXPARTS,
  KEYWORD_MULTIPART,
  KEYWORD_NOT,
  KEYWORD_OPTIONS,
  KEYWORD_OUTPUT,
  KEYWORD_OUTSIZE,
  KEYWORD_PATH,
  KEYWORD_PHONE,
  KEYWORD_PORT,
  KEYWORD_PROGARGS,
  KEYWORD_PROGRAM,
  KEYWORD_REPLACE,
  KEYWORD_RUN,
  KEYWORD_SEARCH,
  KEYWORD_SERVER,
  KEYWORD_SHOWLOG,
  KEYWORD_SYSTEM,
  KEYWORD_UNBREAK,
  KEYWORD_WHEN,
  KEYWORD_WHENNOT,
  KEYWORD_EXIT,

  KEYWORD_LAST /* must be the last one */
} KeyId;

/* This is a node in the linked list with NOT-expressions that may be appended
   to a normal RE */
struct Notre {
  struct re_pattern_buffer buf;
  char fastmap[(1 << BYTEWIDTH)];
  char *search;
  char *log; /* log text to output when this is used (the first time) */
  char *file; /* where this was found */
  int lineno; /* line number */
  struct Notre *next;
};

/* This is a node in the linked list with expressions that should be evaluated
   when the associated IF-expression matches */
struct if_action {
  KeyId instruction; /* what instruction is this? */
  char *param; /* parameter(s) to this instruction */
  char *log;   /* malloc()ed text to log when this is performed */
  struct if_action *next; /* linked to the next if_action node */
};

struct RE {
  struct re_registers regs; /* search registers */
  struct re_pattern_buffer buf;
  char fastmap[(1 << BYTEWIDTH)];
  char *search;
  char *replace;
  char *log; /* log text to output when this is used (the first time) */

  int prio; /* priority of this regex */

  /* from where the search/replace pair comes from */
  char *file;
  int lineno;

  int checker; /* used to prevent multiple loggins on the same line
		  and "area" */
  int replaceline; /* set to line number it has been used in */
  int looper; /* used to prevent infinite looping */

  struct RE *sublist; /* if this expression matches, this list should
                         be appended to the main list */
  long flags; 

#define RE_LOOP    (1<<0)  /* this check will be repeated on each line */
#define RE_NOCASE  (1<<1)  /* no case significance */
#define RE_SUBJECT (1<<2)  /* only replace in subject */
#define RE_FROM    (1<<3)  /* only replace in from */
#define RE_FROM_ADDRESS (1<<16) /* only replace in from-email address */
#define RE_ADDRESS RE_FROM_ADDRESS /* to make the old define still work */

#define RE_TO       (1<<17)  /* only work in to */
#define RE_TO_ADDRESS (1<<18) /* only work in to-email address */

#define RE_BODY    (1<<4)  /* only replace in body */
#define RE_ONCE    (1<<5)  /* once in a whole session */
#define RE_FULLBODY (1<<6) /* replace on huge bite of a no-newlines buffer */
#define RE_HEADER  (1<<7)  /* replace in header */
#define RE_ABORT   (1<<8)  /* abort on match */
#define RE_CONDITIONAL (1<<9) /* conditional search/replace */
#define RE_REVERSED (1<<10) /* reversed action, i.e if it doesn't match */

#define RE_DELETE (1<<11) /* delete named file */
  char *delete;
#define RE_CREATE (1<<12) /* create named file */
  char *create;
#define RE_SYSTEM (1<<13) /* run specified shell command line */
  char *system;
#define RE_DONE   (1<<14) /* mark an IF-expression as done */
#define RE_CONFIG (1<<15) /* read specified config file! */
  char *config;

  struct Notre *not; /* list of non-matches */
  struct if_action *action; /* list of attached actions */
  
  struct RE *next;
};


typedef enum {
  COND_FALSE, /* must be first and zero */
  COND_TRUE,
  COND_UNDEFINED, /* default in all cases, if 'begin' is found it acts
		     as if TRUE */

  COND_LAST
} Condition;


static int replaceregex(struct RE *re,
			unsigned char **line,
			struct re_registers *regs);

char output[512]="F: $from S: $subject B: $body";

char multipart[512]="[$index/$numparts]";

char phone[256]=""; /* no default phone number */
char smsserver[256]=""; /* no default server */
unsigned short smsserverport=6793; /* default port according to sms server
				      sources */

/* no default ones for these: */
char program[256]="";
char run[256]="";
char progargs[256]="";

int prio_min = PRIO_DEFAULT;
int prio_max = PRIO_DEFAULT;

int maxdisplay = MAX_DISPLAY;
int maxparts = MAX_PARTS; /* the maximum number parts to generate, each is max
                             MAX_DISPLAY bytes big */

FILE *logfile=NULL; /* write logs to this file pointer, NULL makes stderr */
char forced_logfile = FALSE; /* override the logfile keyword */

/* maximum number of directories supported in the path: */
#define MAX_INCLUDE_PATH 25
char *includepath[MAX_INCLUDE_PATH];
int includeno=0;

/* this is a bitpattern with all set active filters */
long active_filter=0;
long filter_lines=0; /* number of lines to cut off, or zero */
#define FILTER_IGNORE (1<<0)
#define FILTER_HTML   (1<<1)

extern int viewlog;

#if 0
FILE *testfp=stdin;
#endif

/* Log the specified data: */
void logf(LogfType type, char *fmt, ...)
{
  static char *prefix[]={
    "", /* info */
    "BREAK: ",
    "ERROR: ",
    "DEBUG: ",
    "REGEX: ",
    "WARNING: ",
    "ABORT: ",
    "IF: ",
    "SEARCH: ",
    "NOT: ",
    "DELETE: ",
    "CREATE: ",
    "SYSTEM: ",
    "CONFIG: ",
    "ACTION: ",
    "EXIT: ",

  };
    
  char *s="=== %Y-%m-%d %T mail2sms " VERSION" started ===\n";
  char e[2560];
  time_t now;
  va_list ap;
  struct tm *tms;
  static char init=0;
  FILE *stream;

  if(!(viewlog & (1 << type))) {
    return;
  }

  stream=logfile?logfile:stderr;

  if(!init) {
    init = TRUE;
    now=time(NULL);
    tms = localtime(&now);
    
    strftime(e, sizeof(e), s, tms);
    fputs(e, stream);
  }

  va_start(ap, fmt);
  vsprintf(e, fmt, ap);
  va_end(ap);

  if( type < LOGF_LAST)
    fputs(prefix[type], stream);
  else
    fputs("BAD: ", stream);
  fputs(e, stream);
}

void ShowLog(char *toggle)
{
  static char *logwords[]={
    "INFO", /* info */
    "BREAK",
    "ERROR",
    "DEBUG",
    "REGEX",
    "WARNING",
    "ABORT",
    "IF",
    "SEARCH",
    "NOT",
    "DELETE",
    "CREATE",
    "SYSTEM",
    "CONFIG",
    "ACTION",
    "EXIT",
  };
  char *p;
  int i;
  char add=TRUE;

  p = strtok(toggle, " \t,");
  while(p) {
    switch(*p) {
    case '+':
      add= TRUE;
      p++;
      break;
    case '-':
      add = FALSE;
      p++;
      break;
    }
    if(!strcasecmp("all", p)) {
      if(add)
	viewlog = 0xffffff;
      else
	viewlog = 0;
    }
    else {
      for(i=0; i< sizeof(logwords)/sizeof(logwords[0]); i++) {
	if(!strcasecmp(p, logwords[i])) {
	  if(add)
	    viewlog |= (1 << i);
	  else
	    viewlog &= ~(1 << i);
	  i=0;
	  break;
	}
      }
      if(i) {
	logf(LOGF_WARN, "unknown showlog keyword: %s\n", p);
      }
    }
    p = strtok(NULL, " \t,");
  }

}


void AddPath(char *dir)
{
  if(includeno < MAX_INCLUDE_PATH) {
    includepath[ includeno++ ] = strdup(dir);
  }
  else 
    logf(LOGF_WARN, "max number of path entries (%d) already reached\n",
	 MAX_INCLUDE_PATH);
}

/* The follow function is a plain rip-off from Hypermail (even though
 * I wrote it all) and I'll try to create the structs and defines to
 * leave it exactly as in hypermail to enable future updates when the
 * hypermail one develops */

#define NONAME ""
#define NOEMAIL ""

/*
** Push byte onto a buffer realloc the buffer if needed.
**
** Returns the (new) buffer pointer.
*/
char *PushByte(struct Push *push,
	       char byte)     /* byte to append */
{
#define PUSH_DEFAULT 32 /* default strings are this big */
  if(!push)
    return NULL; /* this is a sever error */
  if(!push->string) {
    push->string = (char *)malloc(PUSH_DEFAULT);
    if(!push->string)
      return NULL; /* error again */
    push->alloc = PUSH_DEFAULT;
    push->len = 0;
#ifdef DEBUG_PUSH
    fprintf(stderr, "PUSH: INIT at index 0 alloc %d\n", PUSH_DEFAULT);
#endif
  }
  else if((push->len+2) >= push->alloc) {
    char *newptr;
    newptr = (char *)realloc(push->string, push->alloc*2); /* double the size */
    if(!newptr) {
      return push->string; /* live on the old one! */
    }
    push->alloc *= 2;  /* enlarge the alloc size */
    push->string = newptr; /* use the new buffer */
#ifdef DEBUG_PUSH
    fprintf(stderr,
	    "PUSH: REALLOC at index %d to alloc %d\n", push->len, push->alloc);
#endif
  }
#ifdef DEBUG_PUSH
  fprintf(stderr, "PUSH: WRITE '%c' at index %d\n", byte, push->len); 
#endif
  push->string[push->len++]=byte;
  push->string[push->len]=0; /* zero terminate */

  return push->string; /* current buffer */
}

/*
** Push a string onto a buffer, and realloc the buffer if needed.
**
** Returns the (new) buffer pointer.
*/
char *PushString(struct Push *push,
		 char *append)  /* string to append */
{
  char *string=NULL;
  while(append && *append) { /* continue until zero termination */
    string = PushByte(push, *append);
    append++; /* get next character */
  }

  return string; /* this is the new buffer */
}

/*
** Push a limited string onto a buffer, and realloc the buffer if needed.
**
** Returns the (new) buffer pointer.
*/
char *PushNString(struct Push *push,
		  char *append,  /* string to append */
		  int size)      /* maximum number of bytes to copy */
{
  char *string=NULL;
  while(append && *append && size--) { /* continue until zero termination */
    string = PushByte(push, *append);
    append++; /* get next character */
  }

  return string; /* this is the new buffer */
}


/*
** Grabs the name and email address from a From: header.
** This could get tricky; I've tried to keep it simple.
** Should be able to handle all the addresses below:
**
**   From: user                   [no @]
**   From: kent (Kent Landfield)  [no @ - with comment]
**   From: <user@node.domain>     [no text name, use email as text name]
**   From: Kent Landfield <kent>  [text name but no @]
**   From: (kent)                 [comment - no email address]
**   From: "" <kent>              [email address but null comment]
**   From:                        [blank From: line]
**   From: uu.net!kent            [uucp addresses - no comment]
**   From: uu.net!kent (kent)     [uucp addresses - with comment]
**   From: "(Joe Bloggs)" <joe@anorg.com> 
**   From: "Roy T. Fielding" <fielding@kiwi.ics.uci.edu>
**   From: kent@localhost
**   From: kent@uu.net (Kent Landfield)
**   From: (George Burgyan) <gburgyan@cybercon.com>
**   From: <gburgyan@cybercon.com> (George Burgyan) 
**   From:              Kent B. Landfield <kent@landfield.com>
**   From:      IN%"fekete+reply@c2.net" 26-JAN-1997 13:28:55.36
**   From:      IN%"vicric@panix.com"  "Vicki Richman" 13-AUG-1996 10:54:33.38
**   From:      US2RMC::"lwv26@cas.org" "Larry W. Virden, x2487" 22-OCT-1994 09:44:21.44
**   From:          Mail Delivery Subsystem <postmaster@igc.apc.org>
**   From:          Self <ehasbrouck>
**   From:         adam@eden.apana.org.au (Adam Frey)
**   From:        faqserv@penguin-lust.mit.edu
**   From:    nc0548@freebsd.netcom.com (Mark Hittinger)
**   From: "- Pam Greene, one of the *.answers moderators" <pgreene@MIT.EDU>
**   From: "Felan shena Thoron'edras" <felan@netcom.com>
**   From: David Muir Sharnoff <muir@idiom.com>
**   From: A.J.Doherty@reading.ac.uk (Andy Doherty)
**   From: Jordan Hubbard                        <jkh@vector.eikon.e-technik.tu-muenchen.de>
**   From: ZXPAN%SLACVM.BITNET@MITVMA.MIT.EDU
**   From: afs!piz!alf@uu5.psi.com (Alf the Poet)
**   From: answers@cp.tn.tudelft.nl ("Moderator *.answers")
**   From: mdw%merengue@merengue.oit.unc.edu (Matt Welsh)
**   From: bgoffe@whale.st.usm.edu (William L. Goffe)
*
* 
* This is an interesting new one (1998-11-26):
* From: <name.hidden@era.ericsson.se>›Name.Hidden@era.ericsson.seœ
*
*/

/****************************************************************************
 *
 * Getting name and email part from a From: -line
 *
 * Daniel Stenberg rewrote the whole routine Nov 24 1998.
 *
 * "This works better"
 *
 ***************************************************************************/

struct Part822 {
  struct Push buf;
  int type;
  int count; /* 0 if its the first, 1 if its the second */
};

/* we *OR* these flags! */

#define RFC822_EMAIL 1
#define RFC822_NAME  2

#define RFC822_GUESS 4 /* this is just guessed, a non-guessed field will
			  have priority over a guessed one */

#define RFC822_PARTS (RFC822_EMAIL|RFC822_NAME)

static
void getname(unsigned char *in,
	     char **namep,
	     char **emailp)
{
  char quotemode=FALSE;
  struct Part822 part822[2];
  int bufcount=0;
  char done=FALSE;
  int ws;
  char emailbuffer[256];
  int prevpart = 0;

  struct Push *namebufp;
  struct Push *emailbufp;

  struct Part822 *bufp = &part822[0];

  /* start with NULLs */
  *namep = *emailp = NULL;

  /* first, init both string buffers */
  INIT_PUSH(part822[0].buf);
  INIT_PUSH(part822[1].buf);

  while (isspace(*in))
    in++; /* pass beginning whitespace */

  if(!*in) {
    /* empty line, abort */
    PushString(&part822[0].buf, NONAME);
    *namep=PUSH_STRING(part822[0].buf);

    PushString(&part822[1].buf, NOEMAIL);
    *emailp=PUSH_STRING(part822[1].buf);
    return;
  }

  bufp->type = 0;
  bufp->count = 0;

  while(!done) {
    if(*in == '\"') {
      quotemode^=TRUE;
      in++;
    }

    switch(*in) {
    case '\0':
    case '\n':
    case '\r':
      done = TRUE;
      continue;
    case '<':
      /* we don't expect any quotes here */
      sscanf(in+1, "%255[^>]", emailbuffer);
      in += strlen(emailbuffer)+2;
      PushString(&bufp->buf, emailbuffer);
      bufp->type = RFC822_EMAIL;

      if(prevpart & RFC822_EMAIL) {
	/* the previous part is ALSO said to be the email part, we
	   don't believe there is any better way than this to find an
	   email address, so we *convert* the previous one to name part!
	   */
	part822[0].type = RFC822_NAME|RFC822_GUESS;
      }

      /* ok, we've seen cases where the Real Name follows this part
       * _without_ whitespaces after this, so we need to expect
       * another part already now */

      /* FALL THROUGH! */

    case '\t':
    case ' ':
      while (isspace(*in))
	in++; /* pass more whitespaces */
      bufcount++;
      if(2 == bufcount) {
	/* this is getting silly */
	done = TRUE;
	continue;
      }
      prevpart = bufp->type; /* what kind of part the previous one was */
      bufp++;
      bufp->type = 0;
      bufp->count = bufcount;
      break;

    case '(':
      in++;
      while(*in) {
	if(quotemode && (*in == '\\')) {
	  in++;
	  PushByte(&bufp->buf, *in++);
	}
	else {
	  if(!*in || (!quotemode && (*in == ')')))
	    break;
	  else if(*in == '\"') {
	    quotemode ^= TRUE; /* toggle mode */
	    in++; /* pass the quote character */
	  }
	  else
	    PushByte(&bufp->buf, *in++);
	}
      }
      if(*in == ')')
	in++;
      bufp->type = RFC822_NAME;
      break;
    default:
      ws=0;
      while(*in) {
	if(quotemode && (*in == '\\')) {
	  in++;
	  PushByte(&bufp->buf, *in++);
	}
	else {
	  if(!*in || 
	     /* lessthans aren't important when quoting! */

             /* removed sensitive for open parens 1998-12-10 */
	     (!quotemode && (*in == '<')))  {
	    if(ws)
	      in--; /* back on the whitespace */
	    break;
	  }
	  else if(*in == '\"') {
	    quotemode ^= TRUE; /* toggle mode */
	    ws=0;
	    in++; /* pass the quote character */
	  }
	  else if(isspace(*in)) {
	    if(!quotemode && (bufp->type&RFC822_EMAIL)) {
	      /* we have previously detected this to be an email address,
		 and therefore this cannot have spaces */
	      break;
	    }
	    ws++;
	    in++;
	  }
	  else {
	    if(ws) {
	      PushByte(&bufp->buf, ' ');
	      ws=0;
	    }
	    if( ('@' == *in)  &&
		PUSH_STRLEN(bufp->buf) && /* we can't start with an @ sign */
		!(prevpart & RFC822_EMAIL) ) {
	      char *emp;
	      /* We treat a @-letter here as a hint of this being an
                 email address! But _not_ if we already have found an email
		 in the previous part */
	      
	      /* Have we already found an @-sign in this part earlier? */
	      if(! strchr( PUSH_STRING(bufp->buf), '@')) {

		/* Email addresses can not have 8bit characters, we check that
		   to be a little more certain! */
		emp = PUSH_STRING(bufp->buf);
		
		while(*emp) {
		  if((unsigned char)*emp > 127)
		    break;
		  emp++;
		}
		if(!*emp)
		  bufp->type = RFC822_EMAIL|RFC822_GUESS;
	      }
	      else
		/* can't have to @s */
		bufp->type &= ~RFC822_EMAIL;
	    }
	    PushByte(&bufp->buf, *in++);
	  }
	}
      }
      break;
    }
  }
  if(0 == bufcount) {
    switch(part822[0].type & RFC822_PARTS) {
    case RFC822_NAME:
      namebufp = &part822[0].buf;

      PushString(&part822[1].buf, NOEMAIL);
      emailbufp = &part822[1].buf;

      /* We return here to prevent the noemail message to get domainized! */
      *namep = PUSH_STRING(*namebufp);
      *emailp = PUSH_STRING(*emailbufp);
      return;

    case RFC822_EMAIL:
    default:
      emailbufp = &part822[0].buf;

      /* we have no name, so we set the email to be the name too */
      PushString(&part822[1].buf, PUSH_STRING(part822[0].buf));
      namebufp = &part822[1].buf;
      break;
    }
  }
  else if((part822[0].type & RFC822_NAME) ||
	  (part822[1].type & RFC822_EMAIL)) {
      namebufp = &part822[0].buf;
      emailbufp = &part822[1].buf;
  }
  else {
    namebufp = &part822[1].buf;
    emailbufp = &part822[0].buf;
  }

  *namep = PUSH_STRING(*namebufp);
  *emailp = PUSH_STRING(*emailbufp);
}

#if 0
/* old display() code that prevents multiple isspace() letters in a row */
int display(char *buf, unsigned char *data, int *length)
{
  
  static char wasspace=0;
  while(*data) {
    if(isspace(*data) &&
       wasspace)
      ;
    else {
      if(maxdisplay <= (*length)) {
	buf[*length]= 0;
	return 1; /* don't add more than max */
      }

      if(' ' > *data && *data != '\n' && *data != '\r' && *data != '\t')
	*data=' ';
      buf[*length] = *data;

      if(isspace(*data))
	wasspace=TRUE;
      else
	wasspace=FALSE;
      
      ++(*length);
    }
    data++;
  }
  buf[*length]= 0;
  return 0;
}
#else
int display(char *buf, unsigned char *data, int *length, int max)
{
  *length=0;
  while(*data) {
    if(max <= (*length)) {
      buf[*length]= 0;
      return 1; /* don't add more than max */
    }
    buf[*length] = *data;
    ++(*length);
    data++;
  }
  buf[*length]= 0;
  return 0;
}
#endif

struct RE *mainregexhead=NULL;
int num_of_regex=0;

int verbose=1; /* we should inform about what is being done */

unsigned char nocase[256];

int initregex()
{
  static int inited=0;
  int i;
  if(inited)
    return 1;
  inited =1;

  /* use the egrep regex style! */
  re_syntax_options = RE_SYNTAX_POSIX_EGREP;

  
  for (i = 0; i < 256; i++)
    nocase[i] = i;
  for (i = 'a'; i <= 'z'; i++)
    nocase[i] = toupper(i);

  /* make åäö get nocase treatment */
  nocase[(unsigned char)'å']=(unsigned char)'Å';
  nocase[(unsigned char)'ä']=(unsigned char)'Ä';
  nocase[(unsigned char)'ö']=(unsigned char)'Ö';

  return 0;
}

int getvalue( char *input, char *bitfield, int min, int max)
{
  /* syntax allowed:
     0-4,3,1-4

     overlaps are OK

     if the given value is larger than 'max' or lower than 'min', the
     input is illegal and we abort this function. 

     */

  long svalue;
  long evalue;
  long i;

  /* zero-fill it first */
  memset(bitfield, 0, (max-min+1)*sizeof(char));

  while(*input) {
    /* hunt for digits */
    if(!isdigit(*input)) {
      input++;
      continue;
    }

    svalue = strtol(input, &input, 10);

    if((svalue>max) || (svalue<min))
      return 1; /* illegal start value */

    if('-' == *input) {
      /* we have a sequence: */
      if(!*input)
	evalue=max;
      else if(','==*input) {
	evalue=max;
	input++;
      }
      else 
	evalue = strtol(++input, &input, 10);
    }
    else
      evalue=svalue;

    if((evalue>max) || (evalue<min))
      return 1; /* illegal end value */

    if(evalue < svalue) {
      /* evalue must be the higher of them, swap! */
      i = svalue;
      svalue = evalue;
      evalue = i;
    }

    for(i=svalue; i<=evalue; i++) {
      bitfield[ i - min] = 1; /* just set it */
    }

  }
  return 0; /* successful */
}

int validcheck( char *valid, int *ok,
		/* these two for error messages: */
		char *filename, int line)
{
  /*
   * Syntax for valid expressions:
   *
   * keyword <value> [, keyword <value>]
   *
   * Available keywords:
   *
   * day   <day in month>
   * wday  <day in week>
   * month <month in year>
   * year  <year number>
   * hour  <hour in a day>
   * file  <whether file name exists>
   *
   *
   * set *ok to TRUE if valid, else to FALSE
   */
  char keyword[32];
  char value[128];

  char daybitfield[31];
  char hourbitfield[24];
  char wdaybitfield[7];
  char monthbitfield[12];
  char yearbitfield[40]; /* note the size of this */
  char minbitfield[2360]; /* 00:00 - 23:59 per minute */

  int check=0;
  time_t timenow;
  struct tm *timeNow;
  int file;

#define VALID_HOUR  (1<<0)
#define VALID_DAY   (1<<1)
#define VALID_WDAY  (1<<2)
#define VALID_MONTH (1<<3)
#define VALID_YEAR  (1<<4)
#define VALID_MIN   (1<<6)

  /* not date oriented: */
#define VALID_FILE  (1<<5)

#define VALID_ALWAYS (1<<7)
#define VALID_NEVER  (1<<8)

  while(*valid) {
    if(isspace(*valid)) {
      valid++;
      continue;
    }
    value[0]=0;
    if(1 <= sscanf(valid, "%31s %127[^ ]", keyword, value)) {

      valid += strlen(keyword) + strlen(value) + 1;

      if(!strcasecmp("always", keyword)) {
	*ok = TRUE;
	check |= VALID_ALWAYS;
        return 0;
      }
      else if(!strcasecmp("never", keyword)) {
	*ok = FALSE;
	check |= VALID_NEVER;
        return 0;
      }
      else if(!strcasecmp("day", keyword)) {
	/* input, store in bitfield array, start index */
	if(getvalue(value, daybitfield, 1, 31))
	  return 1; /* illegal value */
	check |= VALID_DAY;
      }
      else if(!strcasecmp("hour", keyword)) {
	/* input, store in bitfield array, start index */
	if(getvalue(value, hourbitfield, 0, 23)) {
	  /* illegal value, try the minute resolution: */

	  if(getvalue(value, minbitfield, 0, 2359))
	    return 1; /* illegal here too! */
	  check |= VALID_MIN;	  
	}
	else
	  check |= VALID_HOUR;
      }
      else if(!strcasecmp("min", keyword)) {
	/* try minute resolution: */
	if(getvalue(value, minbitfield, 0, 2359))
	  return 1; /* illegal here too! */
	check |= VALID_MIN;	  
      }
      else if(!strcasecmp("wday", keyword)) {
	/* input, store in bitfield array, start index */
	if(getvalue(value, wdaybitfield, 1, 7))
	  return 1; /* illegal value */
	check |= VALID_WDAY;
      }
      else if(!strcasecmp("month", keyword)) {
	/* input, store in bitfield array, start index */
	if(getvalue(value, monthbitfield, 1, 12))
	  return 1; /* illegal value */
	check |= VALID_MONTH;
      }
      else if(!strcasecmp("year", keyword)) {
	/* input, store in bitfield array, start index */
	if(getvalue(value, yearbitfield, 1998, 2038))
	  return 1; /* illegal value */
	check |= VALID_YEAR;
      }

      else if(!strcasecmp("file", keyword)) {
	file = (0 == access(value, F_OK));
	check |= VALID_FILE;
      }
      else {
	logf(LOGF_ERROR, "unsupported when-expression keyword: '%s' file %s line %d\n",
	     keyword, filename, line);
      }
    }
    else
      return 1;
  }

  if(!check)
    return 1; /* we have no check? */

  time(&timenow);
  timeNow = localtime(&timenow);

  if(check & VALID_DAY) {
    if( daybitfield [ timeNow->tm_mday - 1 ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if(check & VALID_HOUR) {
    if( hourbitfield [ timeNow->tm_hour ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if(check & VALID_MIN) {
    if( minbitfield [ timeNow->tm_hour*100 + timeNow->tm_min ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if(check & VALID_WDAY) {
    if( wdaybitfield [ timeNow->tm_wday?timeNow->tm_wday-1:6 ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if(check & VALID_MONTH) {
    if( monthbitfield [ timeNow->tm_mon ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if(check & VALID_YEAR) {
    if( yearbitfield [ timeNow->tm_year-98 ] )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }
  }
  if( check & VALID_FILE) {
    if( file )
      *ok = TRUE;
    else {
      *ok = FALSE;
      return 0;
    }

  }

  return 0;
}


void static
AppendActionToIfNode(struct RE *papa,
                     KeyId instruction,
                     char *what,
                     char **log)
{
  struct if_action *action = (struct if_action *)malloc(sizeof(struct if_action));
  struct if_action *last = papa->action;

  if(action) {
    /* fill the struct with zeros if needed */
    /*memset(action, 0, sizeof(struct if_action));*/

    /* find the end of the current action-list */
    while(last && last->next) {
      last = last->next;
    }

    action->instruction = instruction;
    action->param = strdup(what);
    action->next = NULL; /* we always append the last node */
    action->log = *log;
    *log = NULL; /* we've used it now! */


    /* now link it */
    if(last)
      last->next = action;
    else
      papa->action = action; /* the first action node here */

    logf(LOGF_DEBUG, "Added ACTION node (%s) to papa\n", what);
  }
}


extern int valid; /* This tells whether to continue or not */

struct KeyList {
  char *longone;
  char *shortone;
  KeyId id;
};


typedef enum {
  READ_NONE, /* just nothing */
  READ_END,  /* returned due to END */
  READ_ELSE, /* returned due to ELSE */

  READ_ENDIF, /* returned due to ENDIF */
  
  READ_LAST /* last in list  */
} ReadCode;

ReadCode readfile(FILE *re, char *filename,
		  int *line, int maxlevel,
		  struct RE **regexhead,
		  struct RE *papa, /* the papa of this subtree or NULL */
		  Condition condition)
{
  char buffer[512];
  char *search=NULL;
  char *replace=NULL;
  char *log=NULL;
  char options[512]="";
  char command[32];
  char what[512]="";
  const char *compile_ret; /* compile result */
  struct RE *regex_node=NULL; /* the previous regex node */

  KeyId id;
  int ok;
  int i;
  int searchline;
  int got=0;
  int commandno=0;

  struct RE *subregex=NULL;

#define REG_SEARCH  (1<<0)
#define REG_REPLACE (1<<1)
#define REG_OPTIONS (1<<2)
#define REG_ABORT   (1<<3)
#define REG_IF      (1<<4)
#define REG_IFNOT   (1<<5)

#define REG_COND    (REG_IF|REG_IFNOT)

  struct KeyList keys[]={
    {"abort", NULL, KEYWORD_ABORT},
    {"begin", "{", KEYWORD_BEGIN},
    {"break", NULL, KEYWORD_BREAK},
    {"create", NULL, KEYWORD_CREATE},
    {"config", NULL, KEYWORD_CONFIG},
    {"delete", NULL, KEYWORD_DELETE},
    {"else", NULL, KEYWORD_ELSE},
    {"end", "}", KEYWORD_END},
    {"endif", NULL, KEYWORD_ENDIF},
    {"execute", "run", KEYWORD_RUN},
    {"exit", NULL, KEYWORD_EXIT},
    {"filter", NULL, KEYWORD_FILTER},
    {"if", NULL, KEYWORD_IF},
    {"include", NULL, KEYWORD_INCLUDE},
    {"log",  NULL, KEYWORD_LOG},
    {"logfile", NULL, KEYWORD_LOGFILE},
    {"maxparts", NULL, KEYWORD_MAXPARTS},
    {"multipart", NULL, KEYWORD_MULTIPART},
    {"not", NULL, KEYWORD_NOT},
    {"options", "o", KEYWORD_OPTIONS},
    {"option", "o", KEYWORD_OPTIONS},
    {"output", NULL, KEYWORD_OUTPUT},
    {"outsize", NULL, KEYWORD_OUTSIZE},
    {"path", NULL, KEYWORD_PATH},
    {"phone", NULL, KEYWORD_PHONE},
    {"port", NULL, KEYWORD_PORT},
    {"progargs", NULL, KEYWORD_PROGARGS},
    {"program", NULL, KEYWORD_PROGRAM},
    {"replace", "r", KEYWORD_REPLACE},
    {"search", "s", KEYWORD_SEARCH},
    {"server", NULL, KEYWORD_SERVER},
    {"showlog", NULL, KEYWORD_SHOWLOG},
    {"system", NULL, KEYWORD_SYSTEM},
    {"unbreak", NULL, KEYWORD_UNBREAK},
    {"when", NULL, KEYWORD_WHEN},
    {"whennot", NULL, KEYWORD_WHENNOT},
  };

  while(fgets(buffer, sizeof(buffer), re)) {
    int cmdlen;

    (*line)++; /* count lines, line 1 is the first! */
    if(('#' == buffer[0]) ||
       ('\r' == buffer[0]) ||
       ('\n' == buffer[0]))
      /* this is no line we should bother about */
      continue;
    what[0]=0;
    if(1 <= sscanf(buffer, " %31[^: #=] %*[=: ] %n%511[^\n\r#]",
                   command, &cmdlen, what)) {

      if(('#' == command[0]) ||
	 ('\n' == command[0]))
	/* this is no line we should bother about */
	continue;
      
      if('\"' == *what) {	  
	int max=511;
	char *whatp=what;
	char *bufp=&buffer[cmdlen];

	/* pass white space */
	while(isspace(*bufp))
	  bufp++;
	
	bufp++; /* skip the quote character */
	  
	while(max-- && *bufp) {
	  if(('\\' == *bufp) &&
	     ('\"' == bufp[1])) {
	    *whatp++= '\"';
	    bufp+=2;
	    continue;
	  }
	  else if('\"' == *bufp) {
	    *whatp=0;
	    break;
	  }
	  *whatp++ = *bufp++;
	}
#if 0
	sscanf(buffer, "%31[^:]: \"%511[^\"]", command, what);
#endif
      }
      else {
	i = strlen(what);
	while(i && isspace(what[--i]))
	  what[i]=0;
      }
      i = strlen(command);
      while(i && isspace(command[--i]))
	command[i]=0;
      
      id = KEYWORD_NONE;
      for(i=0; i< sizeof(keys)/sizeof(keys[0]); i++) {
	if(!strcasecmp(command, keys[i].longone) ||
	   (keys[i].shortone && !strcasecmp(command, keys[i].shortone))) {
	  id = keys[i].id;
	  break;
	}
      }

      /* count number of commands */
      commandno++;

      switch(id) {
      case KEYWORD_NONE:
      default:
	logf(LOGF_ERROR, "unknown keyword '%s' used in file %s line %d\n",
	     command, filename, *line);
	continue;

        /*********************************************************************
         * SECTION FOR IF-AWARE KEYWORDS
         *********************************************************************/

      case KEYWORD_OUTSIZE:
        if(!papa) {
          /* this is set on root level, thus takes effect immediately */
          maxdisplay = atoi(what);
          if(maxdisplay > 500) {
            logf(LOGF_INFO, "Logged messages will be cut after 500 bytes!\n");
          }
          logf(LOGF_DEBUG, "max output size set to %d\n", maxdisplay);
        }
        else
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	break;

      case KEYWORD_FILTER:
        if(!papa) {
          /* this is set on root level, thus takes effect immediately */
          logf(LOGF_DEBUG, "no filter support on root-level yet\n");
        }
        else
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	break;


      case KEYWORD_CREATE:
	if(papa) {
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	}
	else {
	  logf(LOGF_CONFIG, "CREATE: %s %s\n", what, log?log:"");
	  if(access(what, F_OK))
	    creat(what, 0666);
	  if(log) {
	    free(log);
	    log=NULL;
	  }
	}
	break;

      case KEYWORD_DELETE:
	/* delete a given file */
	if(papa) {
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	}
	else {
	  logf(LOGF_CONFIG,"DELETE: %s %s\n", what, log?log:"");
	  unlink(what);
	  if(log) {
	    free(log);
	    log=NULL;
	  }
	}
	break;

      case KEYWORD_SYSTEM:
	/* run a shell line */
	if(papa) {
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	}
	else {
	  logf(LOGF_CONFIG, "SYSTEM: %s %s\n", what, log?log:"");
	  system(what);
	  if(log) {
	    free(log);
	    log=NULL;
	  }
	}
	break;

      case KEYWORD_CONFIG:
	/* read a config file */
	if(papa) {
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
	}
	else
	  logf(LOGF_ERROR,
	       "config not within if/endif pair, file %s line %d\n",
	       filename, *line);
	break;

      case KEYWORD_RUN:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else {
          sscanf(what, "%255[^\n]", run);
          logf(LOGF_CONFIG, "RUN: %s %s\n", run, log?log:"");
        }
	break;
      case KEYWORD_PROGRAM:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else {
          sscanf(what, "%511[^\n]", program);
	  logf(LOGF_CONFIG, "PROGRAM: %s %s\n", program, log?log:"");
        }
	break;
      case KEYWORD_PROGARGS:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else {
          sscanf(what, "%511[^\n]", progargs);
	  logf(LOGF_CONFIG, "PROGARGS: %s %s\n", progargs, log?log:"");
        }
	break;

      case KEYWORD_OUTPUT:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          sscanf(what, "%511[^\n]", output);
	break;
      case KEYWORD_MULTIPART:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          sscanf(what, "%511[^\n]", multipart);
	break;
      case KEYWORD_MAXPARTS:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          maxparts=atoi(what);
	break;
      case KEYWORD_PHONE:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else {
          sscanf(what, "%255s", phone);
	  logf(LOGF_CONFIG, "PHONE: %s %s\n", phone, log?log:"");
        }
	break;
      case KEYWORD_SERVER:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          sscanf(what, "%255s", smsserver);
	break;
      case KEYWORD_PORT:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          smsserverport=(unsigned short)atoi(what);
	break;

        /* This is NEW for version 1.1+ */
      case KEYWORD_ABORT:
        if(papa)
          /* this is conditionally performed when an IF evaluates true, link
             this to the IF-node's action-list */
          AppendActionToIfNode(papa, id, what, &log);
        else
          logf(LOGF_ERROR, "ABORT used outside if/endif: file %s line %d\n",
               filename, line);
	break;
      case KEYWORD_EXIT:
      	if(papa)
      	  AppendActionToIfNode(papa, id, what, &log);
      	else {
       	  valid = 0;
	  logf(LOGF_EXIT, "exit with code %s\n",what);
	  exitcode=(atoi(what));
        }
 	break;

        /*********************************************************************
         * END OF IF-AWARE KEYWORDS
         *********************************************************************/

      case KEYWORD_PATH:
	AddPath(what);
	break;

      case KEYWORD_NOT:
	if(!papa && !regex_node) {
	  logf(LOGF_ERROR, "'not' used in wrong context file %s line %d\n",
	       filename, *line);
	}
	else {
	  struct Notre *nox;
          
          struct RE *re_node=papa?papa:regex_node;

	  nox = (struct Notre *)malloc(sizeof(struct Notre));
	  if(nox) {
	    memset(nox, 0, sizeof(struct Notre));

	    nox->buf.allocated = 0;
	    nox->buf.buffer = NULL;
	    nox->buf.fastmap = nox->fastmap;
	    
	    /* compile the pattern! */
	    compile_ret = re_compile_pattern (what, strlen(what),
					      &nox->buf);
	    if (compile_ret) {
	      logf(LOGF_ERROR, "in not-pattern, file %s line %d \"%s\": %s\n",
		   filename, *line, what, compile_ret);
	      free(nox);
	    }
	    else {
	      /* compiled ok */
	      nox->search = strdup(what); /* clone cleartext */
	      nox->log = log;
	      nox->file = strdup(filename);
	      nox->lineno = *line;
	      
	      /* now link it to the list of papa or previous node */
	      nox->next = re_node->not;
	      re_node->not = nox;

	      logf(LOGF_DEBUG, "Added NOT node: %s\n", what);
	      log = NULL;
	    }
	  }
	  else {
	    logf(LOGF_ERROR, "out of memory\n");
	  }

	}

	break;

      case KEYWORD_IF:
	/* conditional search starts here */
	if(search)
	  free(search);
	search = strdup(what);
	searchline = *line;
	got |= REG_IF|      REG_SEARCH|REG_REPLACE;
	break;

      case KEYWORD_ENDIF:
	/* end of conditional search */
	return READ_ENDIF;

      case KEYWORD_LOGFILE:
        if(!forced_logfile) {
          if(*what)
            logfile = fopen(what, "a");
          if(!logfile)
            logf(LOGF_ERROR, "failed opening logfile: '%s'!\n", what);
        }
	break;
      case KEYWORD_SEARCH:
	if(search)
	  free(search);
	search = strdup(what);
	searchline = *line;
	got |= REG_SEARCH;
	break;
      case KEYWORD_REPLACE:
	if(replace)
	  free(replace);
	replace = strdup(what);
	got |= REG_REPLACE;
	break;
      case KEYWORD_OPTIONS:
	strcpy(options, what);
	got |= REG_OPTIONS;
	break;
      case KEYWORD_LOG:
	if(log)
	  free(log);
	log = strdup(what);
	break;
      case KEYWORD_INCLUDE:
	if(readconfig(what, maxlevel)) {
	  logf(LOGF_ERROR, "couldn't read include file '%s', included from %s at line %d\n",
	       what, filename, *line);
	}
	break;
      case KEYWORD_BREAK:
	valid = 0;
	logf(LOGF_DEBUG, "set BREAK\n");
	break;
      case KEYWORD_UNBREAK:
	valid = 1;
	logf(LOGF_DEBUG, "set UNBREAK\n");
	break;
      case KEYWORD_WHEN:
      case KEYWORD_WHENNOT:
	{
	  int reverse=(id==KEYWORD_WHEN)?FALSE:TRUE;
	  char *ptr=what;
	  if('!' == *ptr) {
	    reverse ^= TRUE;
	    ptr++;
	  }
	  if(validcheck(ptr, &ok, filename, *line)) {
	    logf(LOGF_ERROR, "bad when-expression file %s line %d\n",
		 filename, *line);
	  }
	  else {
	    if(COND_UNDEFINED == condition) {
	      condition = reverse?!ok:ok;
	    }
	    else if(ok && !reverse)
	      condition = COND_TRUE;
	    else if(ok && reverse) {
	      condition = COND_FALSE;
	    }
	    logf(LOGF_DEBUG, "condition is %d\n", condition);
	  }
	  break;
	}
      case KEYWORD_BEGIN:
	if(log) {
	  logf(LOGF_CONFIG, "BEGIN: (%s) %s\n",
	       condition?"TRUE":"FALSE", log);
	  free(log);
	  log=NULL;
	}
	
	if(condition) {
	  ReadCode red;
	  logf(LOGF_DEBUG, "conditional segment starts at line %d\n", *line);
	  red = readfile(re, filename, line, maxlevel, regexhead, papa,
			 condition);
	  if(READ_ELSE == red)
	    condition = COND_FALSE; /* skip the else-end section */
	  else { 
	    if(READ_END != red)
	      logf(LOGF_WARN, "weird end of 'begin' file %s line %d\n",
		   filename, *line);
	    break;
	  }
	}
	if(!condition) {
	  int level=1;
	  condition = COND_UNDEFINED; /* switch it on again */
	  logf(LOGF_DEBUG, "skip conditional segment starting at line %d\n", *line);
	  
	  id = KEYWORD_NONE;
	  while(fgets(buffer, sizeof(buffer), re)) {
	    (*line)++;
	    if(1 <= sscanf(buffer, " %31[^: \n]", command)) {
	      id = KEYWORD_NONE;
	      for(i=0; i< sizeof(keys)/sizeof(keys[0]); i++) {
		if(!strcasecmp(command, keys[i].longone) ||
		   (keys[i].shortone &&
		    !strcasecmp(command, keys[i].shortone))) {
		  id = keys[i].id;
		  break;
		}
	      }
	      if(KEYWORD_BEGIN == id) {
		level++;
	      }
	      else if((KEYWORD_END == id) ||
		      (KEYWORD_ELSE == id)) {
		if(!--level)
		  break;
	      }
	    }
	  }
	  logf(LOGF_DEBUG, "skip stopped at line %d\n", *line);
	  if(KEYWORD_ELSE == id) {
	    /* we have skipped a begin-else section, now do the else-end
	       section */
	    ReadCode red;
	    red = readfile(re, filename, line, maxlevel, regexhead, papa,
			   condition);
	    if(READ_END != red)
	      logf(LOGF_WARN, "weird end of 'else' in file %s at line %d\n",
		   filename, *line);
	  }
	  condition = COND_UNDEFINED;
	}
	break;

      case KEYWORD_ELSE:
	logf(LOGF_DEBUG, "ELSE at line %d\n", *line);
	return READ_ELSE;

      case KEYWORD_END:
	logf(LOGF_DEBUG, "segment END at line %d\n", *line);
	return READ_END;

      case KEYWORD_SHOWLOG:
	ShowLog(what);
	break;
      }
    }
    if((got&(REG_SEARCH|REG_REPLACE)) == (REG_SEARCH|REG_REPLACE) ) {
      /* we have both, that's a pair we like and can deal with! */
      struct RE *thisre = (struct RE *)malloc(sizeof(struct RE));

      if(thisre) {
	/* if no memory, just skip it */
	char *opt;
	memset(thisre, 0, sizeof(struct RE));

	thisre->buf.allocated = 0;
	thisre->buf.buffer = NULL;
	thisre->buf.fastmap = thisre->fastmap;
	thisre->prio = PRIO_DEFAULT;
	
	thisre->flags = RE_LOOP; /* loop is default */

	if(got & REG_ABORT)
	  thisre->flags |= RE_ABORT;

	if(got & REG_COND) {
	  thisre->flags |= RE_CONDITIONAL;

	  if(got & REG_IFNOT)
	    thisre->flags |= RE_REVERSED; /* trig the replace/action as soon
					     as this *DOESN'T* match! */
	}
	    
	opt = strtok(options, " ,\t");
	while(opt) {
	  if(!strcasecmp("noloop", opt) ||
	     !strcasecmp("1perline", opt))
	    thisre->flags &= ~RE_LOOP;
	  else if(!strcasecmp("once", opt))
	    thisre->flags |= RE_ONCE;
	  else if(!strcasecmp("nocase", opt)) {
	    thisre->flags |= RE_NOCASE;
	    thisre->buf.translate = nocase;
	  }
	  else if(!strcasecmp("subject", opt))
	    thisre->flags |= RE_SUBJECT;
	  else if(!strcasecmp("address", opt)) /* obsolete but kept */
	    thisre->flags |= RE_FROM_ADDRESS;
	  else if(!strcasecmp("fromaddress", opt))
	    thisre->flags |= RE_FROM_ADDRESS;
	  else if(!strcasecmp("from", opt))
	    thisre->flags |= RE_FROM;
	  else if(!strcasecmp("toaddress", opt))
	    thisre->flags |= RE_TO_ADDRESS;
	  else if(!strcasecmp("to", opt))
	    thisre->flags |= RE_TO;
	  else if(!strcasecmp("body", opt))
	    thisre->flags |= RE_BODY;
	  else if(!strcasecmp("header", opt))
	    thisre->flags |= RE_HEADER;
	  else if(!strcasecmp("fullbody", opt))
	    thisre->flags |= RE_FULLBODY;
	  else if(!strcasecmp("prio", opt)) {
	    opt = strtok(NULL, " ,\t");
	    if(!isdigit(*opt))
	      continue;
	    thisre->prio=atoi(opt);
	    if((thisre->prio > SMSPRIO_MAX) ||
	       (thisre->prio < 1)) {
	      logf(LOGF_WARN, "illegal prio '%d' (1-%d), file %s around line %d. (using %d)\n",
		   thisre->prio, SMSPRIO_MAX, filename, *line, PRIO_DEFAULT);
	      thisre->prio = PRIO_DEFAULT;
	    }
	    if(thisre->prio < prio_min)
	      prio_min = thisre->prio;
	    if(thisre->prio > prio_max)
	      prio_max = thisre->prio;
	  }
	  else
	    logf(LOGF_ERROR, "Unknown option '%s', file %s around line %d.\n",
		 opt, filename, *line);

	  opt = strtok(NULL, " ,\t");
	}

	/* compile the pattern! */
	compile_ret = re_compile_pattern (search, strlen(search),
					  &thisre->buf);
	if (compile_ret) {
	  logf(LOGF_ERROR, "in search pattern, file %s line %d \"%s\": %s\n",
	       filename, searchline, search, compile_ret);
	  free(thisre);
	  free(search);
	  if(replace)
	    free(replace);
	}
	else {
	  /* store the search/replace strings */
	  thisre->search = search;
	  thisre->replace = replace;
	  thisre->log = log;
	  thisre->file = strdup(filename);
	  thisre->lineno = *line;
	    
	  /* now link it */
	  thisre->next = *regexhead;
	  *regexhead = thisre;	    
	    
	  num_of_regex++; /* count total number */
	}

	if(got & REG_COND) {
	  /* conditional search-block started, recurse! */
	  if( READ_ENDIF != readfile(re, filename, line, maxlevel, &subregex,
				     thisre, condition)) {
	    logf(LOGF_WARN, "weird end of IF in file %s line %d\n",
		 filename, *line);
	  }

	  thisre->sublist = subregex; /* this is the sub list */
	}
	else
	  regex_node = thisre; /* to enable NOT on search/replace */
      }
      got = 0;
      search = replace = log = NULL;
      options[0] = 0;
    }
    
  }
  return READ_NONE;
}

int readconfig(char *filepart, int maxlevel)
{
  FILE *re;
  char filebuffer[512];
  int i=0;
  char *filename;

  initregex();


  filename = filepart;

  if(!maxlevel--) {
    logf(LOGF_ERROR, "too deep inclusion depth including file %s\n", filename);
    re=NULL; /* too deep inclusion */
    return 0; /* don't show error message for this */
  }
  else {
    do {
      re=fopen(filename, "r");

      if(re ||
	 (i == includeno))
	break;

      sprintf(filebuffer, "%s/%s", includepath[i++], filepart);
      filename = filebuffer;

    } while (1);
  }
  if(re) {
    int line=0;
    if(READ_NONE != readfile(re, filename, &line,
			     maxlevel, &mainregexhead, NULL,
			     COND_UNDEFINED)) {
      logf(LOGF_WARN, "file ended prematurely, file %s line %d\n", filename,
	   line);
    }
    fclose(re);
    return 0;
  }

  return 1;
}


/* only run the same regex this many times */
#define MAX_LOOP 70

typedef enum {
  REPL_SUBJECT,
  REPL_BODY,
  REPL_FROM,
  REPL_ADDRESS,
  REPL_FROM_ADDRESS,
  REPL_TO,
  REPL_TO_ADDRESS,
  REPL_HEADER,
  REPL_FULLBODY /* the entire *no newlines* body */
} ReplaceWhere;

/* return wheather to include this particular line */
char FilterFix(char *param)
{
  /* the right part of a filter line is input */
  char filter[32];
  char setto[16];
  int offset=-1;
  char include=FALSE;

  logf(LOGF_DEBUG, "filter \"%s\"\n", param);

  if(2 == sscanf(param, "%31s %15s %n", filter, setto, &offset)) {
    if(!strcasecmp(filter, "ignore")) {
      if(!strcasecmp(setto, "on") || !strcasecmp(setto, "yes")) {
        /* set filter */
        active_filter |= FILTER_IGNORE;
      }
      else {
        /* clear filter */
        active_filter &= ~FILTER_IGNORE;
      }
    }
  }
  while(-1 != offset) {
    int lines=-1;
    param = &param[offset];
    offset = -1;
    if(1 == sscanf(param, " lines %d %n", &lines, &offset)) {
      /* set the global filter line counter */
      filter_lines = lines;
    }
    else if(1 == !strncasecmp("include", param, 7)) {
      /* include this line */
      offset = 7;
      include = TRUE;
    }
    else if(1 == !strncasecmp("exclude", param, 7)) {
      /* exclude this line */
      offset = 7;
      include = FALSE;
    }
  }
  return include;
}

typedef enum {
  FILTER_IDLE,
  FILTER_INCLUDE,
  FILTER_EXCLUDE
} FilterInclude;

int replacecheck(unsigned char **line, int number, ReplaceWhere where)
{
  struct RE *re;
  int retcode; /* receives the search result */
  int tries=0;
  int prio=prio_min;
  static int checked=0;
  FilterInclude include_line=FILTER_IDLE;

  char *whe[]={
    "subject",
    "body",
    "from",
    "address", /* old style */
    "fromaddress",
    "to",
    "toaddress",
    "header",
    "fullbody"
  };

  checked++;

  re = mainregexhead;
  while(re || (prio <= prio_max)) {

    if(!re) {
      prio++; /* try next prio now */
      re = mainregexhead; /* start over on the list too */
      continue;
    }
    else if((prio != re->prio) ||
	    re->flags & RE_DONE) {
      /* not our prio level or already done! */
      re=re->next;
      continue;
    }
#if 0
    logf(LOGF_DEBUGREGEX, "check: %s line %d\n", re->search, number);
#endif

    if((re->flags & RE_ONCE) &&
       re->replaceline) {
      /* only once replace,
	 and it has already been done! */
      retcode = -1;
    }    
    else if((re->flags & RE_LOOP) &&
	    (number == re->replaceline) &&
	    (re->looper >= MAX_LOOP) ) {
      /* we support loop,
	 the previous replaceline was this,
	 too many loops on the same line */

      if(checked == re->checker) {
	logf(LOGF_WARN, "\"%s\" was found %d times on the same line, stopping!\n",
	     re->log?re->log:re->search,
	     re->looper);
      }
      re->checker=0;
      retcode = -1;
    }
    else if(!(re->flags & RE_LOOP) &&
	    (number == re->replaceline)) {
      /* we don't loop and this is already replaced, don't do it again */
      retcode = -1;
    }
    else if((re->flags &
             (RE_SUBJECT|RE_FROM|RE_FROM_ADDRESS|RE_TO|RE_TO_ADDRESS|RE_BODY|RE_FULLBODY|RE_HEADER)) ||
	    (where==REPL_HEADER)) {
      /* we have a 'where' limitation */
      retcode=0; /* do replace! */
      switch (where) {
      case REPL_SUBJECT:
        if(!(re->flags & RE_SUBJECT)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_FROM:
        if(!(re->flags & RE_FROM)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_FROM_ADDRESS:
        if(!(re->flags & RE_FROM_ADDRESS)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_TO:
        if(!(re->flags & RE_TO)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_TO_ADDRESS:
        if(!(re->flags & RE_TO_ADDRESS)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_BODY:
        if(!(re->flags & RE_BODY)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_FULLBODY:
        if(!(re->flags & RE_FULLBODY)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      case REPL_HEADER:
        if(!(re->flags & RE_HEADER)) {
          retcode = -1; /* don't search/replace this */
        }
        break;
      default:
        break;
      }
    }
    else
      retcode=0;

#if 0
    if(!line || !*line) {
      logf(LOGF_DEBUGREGEX, "no line\n");
    }
#endif

    if((0 == retcode) && line && *line) {
      tries++;

      if(tries > (num_of_regex*MAX_LOOP )) {
	/* this may be an infinite loop or something */
        logf(LOGF_WARN, "breaking out the regex loop after %d search hits!\n",
             tries);
	break;
      }
      retcode = re_search(&re->buf, *line, strlen(*line),
			  0, strlen(*line), &re->regs);
      if(retcode >= 0) {
	struct Notre *nox = re->not;

	/* scan the not-list: */
	while(nox) {
	  if( re_search(&nox->buf, *line, strlen(*line),
			0, strlen(*line), &re->regs) >= 0) {
	    break; /* MATCH! */
	  }
	  nox = nox->next;
	}
#if 0
        if(!nox)
          logf(LOGF_DEBUGREGEX, "TRY: %s\n",
               *line);
#endif
	if(nox) {
	  logf(LOGF_NOT, "%s\n", nox->log?nox->log:nox->search);
	}
	else if(re->flags & RE_CONDITIONAL) {
	  if( !(re->flags&RE_DONE)) {
	    struct RE *subre;
	    struct RE *next;
            struct if_action *action;

	    logf(LOGF_IF, "(%s) %s\n", whe[where],
		 re->log?re->log:re->search);
	    
	    subre = re->sublist;
	    while(subre) {
	      next = subre->next;

	      logf(LOGF_DEBUG, "(%s) append sub-search %s\n", whe[where],
		   subre->search);
	      
	      /* link the sub-part into the main list: */
	      subre->next = mainregexhead;
	      mainregexhead = subre;
	      
	      subre= next; /* goto next sub-part */
	    }
	    re->flags |= RE_DONE; /* mark as done! */


            /*
             * Now, loop through all the "actions" that are bound to this
             * conditional event!
             */
            while((action = re->action)) {
              switch(action->instruction) {
              case KEYWORD_FILTER:
                /* This keyword can now switch on and off filters */
                if(FilterFix(action->param))
                  include_line = FILTER_INCLUDE;
                else
                  include_line = FILTER_EXCLUDE;
                break;

              case KEYWORD_OUTSIZE:
                /* Set the maxdisplay */
                maxdisplay = atoi(action->param);
                logf(LOGF_DEBUG, "OUTSIZE %d\n", maxdisplay);
                if(action->log)
                  logf(LOGF_ACTION, "OUTSIZE %d: %s\n", maxdisplay, action->log);
                break;
              case KEYWORD_CREATE:
                /* create a file */
                logf(LOGF_ACTION, "CREATE: %s %s\n", action->param,
                     action->log?action->log:"");
                if(access(action->param, F_OK))
                  creat(action->param, 0666);
                break;
              case KEYWORD_DELETE:
                /* delete a file */
                logf(LOGF_ACTION, "DELETE: %s %s\n", action->param,
                     action->log?action->log:"");
                unlink(action->param);
                break;
              case KEYWORD_SYSTEM:
                /* run a shell-line */
                logf(LOGF_ACTION, "SYSTEM: %s %s\n", action->param,
                     action->log?action->log:"");
                system(action->param);
                break;
              case KEYWORD_CONFIG:
                /* read a config file */
                logf(LOGF_ACTION, "CONFIG: %s %s\n", action->param,
                     action->log?action->log:"");
                if(readconfig(action->param, MAX_INCLUDE_DEPTH))
                  logf(LOGF_ERROR, "couldn't read config file '%s'\n",
                       action->param);
                break;
              case KEYWORD_RUN:
                /* set the run variable */
                logf(LOGF_ACTION, "RUN: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(run, action->param, 511);
                run[511]='\0';
                break;
              case KEYWORD_PROGRAM:
                /* set the program variable */
                logf(LOGF_ACTION, "PROGRAM: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(program, action->param, 511);
                program[511]='\0';
                break;
              case KEYWORD_PROGARGS:
                /* set the program variable */
                logf(LOGF_ACTION, "PROGARGS: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(progargs, action->param, 511);
                progargs[511]='\0';
                break;
              case KEYWORD_OUTPUT:
                /* set the program variable */
                logf(LOGF_ACTION, "OUTPUT: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(output, action->param, 511);
                output[511]='\0';
                break;
              case KEYWORD_MULTIPART:
                /* set the program variable */
                logf(LOGF_ACTION, "MULTIPART: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(multipart, action->param, 511);
                multipart[511]='\0';
                break;
              case KEYWORD_MAXPARTS:
                /* set the program variable */
                logf(LOGF_ACTION, "MAXPARTS: %d %s\n", atoi(action->param),
                     action->log?action->log:"");
                maxparts = atoi(action->param);
                break;
              case KEYWORD_PHONE:
                /* set the program variable */
                logf(LOGF_ACTION, "PHONE: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(phone, action->param, 255);
                phone[255]='\0';
                break;
              case KEYWORD_SERVER:
                /* set the program variable */
                logf(LOGF_ACTION, "SERVER: %s %s\n", action->param,
                     action->log?action->log:"");
                strncpy(smsserver, action->param, 255);
                smsserver[255]='\0';
                break;
              case KEYWORD_PORT:
                /* set the program variable */
                logf(LOGF_ACTION, "PORT: %s %s\n", action->param,
                     action->log?action->log:"");
                smsserverport=(unsigned short)atoi(action->param);
                break;
              case KEYWORD_ABORT:
                /* abort the execution here */
                logf(LOGF_ABORT, "(%s) %s\n", whe[where],
                     action->log?action->log:action->param);
                return 1; /* ABORT, CANCEL, GET OUT, RUN AWAY! */
	      case KEYWORD_EXIT:
 		exitcode=atoi(action->param);
      		logf(LOGF_EXIT, "(%s) with code %d\n",whe[where], exitcode);
 		return 1;
              }
              re->action = re->action->next;
            }

	    /* start over again */
	    re = mainregexhead; 
	    prio = prio_min;
	    continue;
	  }
	  /* else
	     already done this! */
	}
	else {
	  if(re->replaceline == number) {
	    re->looper++;
	  }
	  else
	    re->looper=0;

	  if(checked != re->checker) {
	    if(re->log)
	      logf(LOGF_SEARCH, "(%s, line %d) %s (%s)\n", whe[where], number,
		   re->log, re->search);
            else
              logf(LOGF_DEBUGREGEX, "(%s, line %d) %s\n", whe[where], number,
		   re->search);
	  }
          else {
            logf(LOGF_DEBUGREGEX, "(%s, line %d) %s\n", whe[where], number,
                 re->search);
          }
#if 1
          logf(LOGF_DEBUGREGEX, "IN:%s\n", *line);
#endif
	  re->checker = checked;
	  re->replaceline = number;
	  replaceregex(re, line, &re->regs);

#if 1     
          logf(LOGF_DEBUGREGEX, "OUT:%s\n", *line);
#endif
	  /* start over again */
	  re = mainregexhead;
	  prio = prio_min;
	  continue;
	}
      }
      else {
        if(-2 == retcode)
          logf(LOGF_DEBUG, "regex \"internal error\" on %s\n", re->search);
#if 0
        else
          logf(LOGF_DEBUGREGEX, "no match %d\n", retcode);
#endif
      }
    }
#if 0
    else
      logf(LOGF_DEBUGREGEX, "no fun\n");
#endif
    re=re->next;
  }
  
  if(active_filter&FILTER_IGNORE) {
    if(filter_lines) {
      filter_lines--;
      if(!filter_lines) {
        /* the filter has worked for the set number of lines, switch off */
        active_filter &= ~FILTER_IGNORE;
      }
    }
    if(include_line!=FILTER_INCLUDE) {
      /* There's a filter going on and we aren't told to explicitly include
         this line */
      *line=""; /* empty output */
    }
  }
  else if(include_line==FILTER_EXCLUDE) {
    /* explicitly told to exclude this */
    *line="";
  }

  return 0;
}

static int replaceregex(struct RE *re,
			unsigned char **line,
			struct re_registers *regs)
{
  int num = re->buf.re_nsub; /*regs->num_regs;*/
  char *repl = re->replace;
  struct Push buf;
  long reg;

  INIT_PUSH(buf);

  /*
   * 1. Add the part left of the match
   */

  if(regs->start[0])
    PushNString(&buf, *line, regs->start[0]);

  /*
   * 2. Add the replace string
   */
  while(repl && *repl) {
    if('\\' == *repl) {
      repl++;
      if('\\' == *repl)
	PushByte(&buf, '\\');
      else {
	reg = strtol(repl, &repl, 10);
	if(reg <= num) {
	  /* legally used register */
	  PushNString(&buf, 
		      (*line)+regs->start[reg],
		      regs->end[reg] - regs->start[reg]);
	}
	continue;
      }
    }
    else
      PushByte(&buf, *repl);
    repl++;
  }

  /*
   * 3. Add the part right of the match
   */
  PushNString(&buf, (*line)+regs->end[0], strlen(*line)-regs->end[0]);

  free(*line);
  
  *line = PUSH_STRING(buf);

  return 0;
}


int makesms(char **buffer, void *mailbody)
{
  int length;
  int max;
  int abort=0;
  int number=0;
  int body=1;

  /* regex initiating stuff here */
  struct Push Body; /* hold the body */
  struct Push Subject; /* hold the subject */
  struct Push From; /* hold the from (Name) */
  struct Push FromAddress; /* hold the from (Address) */
  struct Push To; /* hold the to (Name) */
  struct Push ToAddress; /* hold the to (Address) */
  struct Push Result; /* hold the result */
  unsigned char *line;

  struct body *bp = (struct body *)mailbody;

  INIT_PUSH(Body);
  INIT_PUSH(Subject);
  INIT_PUSH(From);
  INIT_PUSH(FromAddress);
  INIT_PUSH(To);
  INIT_PUSH(ToAddress);
  INIT_PUSH(Result);
  
  while (bp != NULL &&
	 !abort) {
    line = bp->line;
    number++;

    if(bp->header && !bp->attached) {
      if(replacecheck(&line, number, REPL_HEADER))
	return 0;

      if(!strncmp("From:", line, 5)) {
	char *name=NULL;
	char *email=NULL;
	getname(line+5, &name, &email);
	if(name && *name) {
	  line = name;

          if(replacecheck(&line, number, REPL_FROM))
            return 0;

          PushString(&From, line);
	}
	if(email && *email) {
	  line = email;

          if(replacecheck(&line, number, REPL_FROM_ADDRESS))
            return 0;

          PushString(&FromAddress, line);
	}
      }
      else if(!strncmp("To:", line, 3)) {
	char *toname=NULL;
	char *toemail=NULL;
	getname(line+3, &toname, &toemail);
	if(toname && *toname) {
	  line = toname;

          if(replacecheck(&line, number, REPL_TO))
            return 0;

          PushString(&To, line);
	}
	if(toemail && *toemail) {
	  line = toemail;

          if(replacecheck(&line, number, REPL_TO_ADDRESS))
	    return 0;

          PushString(&ToAddress, line);
	}
      }
      else if(!strncmp("Subject:", line, 8)) {
	unsigned char *tline;
	int i;
	tline = strdup(line + 9);

	if(replacecheck(&tline, number, REPL_SUBJECT))
	  return 0;

	/* remove trailing white spaces */
	i=strlen(tline);
	if(i) {
	  while(isspace(tline[--i]))
	    tline[i]=0;
	}
	
	PushString(&Subject, tline);

	free(tline);
      }
    }
    else if(!bp->header) {
      int len;

      if(replacecheck(&line, body++, REPL_BODY))
        return 0;

      if(line) {
	len = strlen(line);

	if(len && ('\n' == line[len-1]))
	  line[len-1]=' '; /* remove newline */

	if((len>1) && ('\r' == line[len-2]))
	  line[len-2]=' '; /* remove carriage return */
	
	PushString(&Body, line);
      }
#if 0
      if(PUSH_STRLEN(Body) > maxdisplay*FULLBODY_SIZE)
	break;
#endif
    }
    
    bp = bp->next;
  }

  active_filter = 0; /* switch off all filters now */

  line = PUSH_STRING(Body);
  if(line) {
    line = strdup(line);
  
    if(replacecheck(&line, -1, REPL_FULLBODY))
      return 0;
  }    
  
  {
    char *out = output;
    while(*out) {
      if('$' == *out) {
	out++;
	if(!strncasecmp("toaddress", out, 9)) {
	  PushString(&Result, PUSH_STRING(ToAddress));
	  out+=9;
	}
        /* this is the old way: */
	else if(!strncasecmp("address", out, 7)) {
	  PushString(&Result, PUSH_STRING(FromAddress));
	  out+=7;
	}
	else if(!strncasecmp("fromaddress", out, 11)) {
	  PushString(&Result, PUSH_STRING(FromAddress));
	  out+=11;
	}
	else if(!strncasecmp("from", out, 4)) {
	  PushString(&Result, PUSH_STRING(From));
	  out+=4;
	}
	else if(!strncasecmp("to", out, 2)) {
	  PushString(&Result, PUSH_STRING(To));
	  out+=2;
	}
	else if(!strncasecmp("subject", out, 7)) {
	  PushString(&Result, PUSH_STRING(Subject));
	  out+=7;
	}
	else if(!strncasecmp("body", out, 4)) {
	  PushString(&Result, line);
	  out += 4;
	}
	else
	  PushByte(&Result, '$');
      }
      else if('\\' == *out) {
        switch(out[1]) {
        case 'n':
          PushByte(&Result, '\n');
          break;
        case 'r':
          PushByte(&Result, '\r');
          break;
        case 't':
          PushByte(&Result, '\t');
          break;
        default:
          PushByte(&Result, out[1]);
          break;
        }
        out+=2;
      }
      else
	PushByte(&Result, *out++);
    }

    /* We're done parsing the mail, now the outsize is set and we can safely
       allocate that number of bytes. But we shouldn't allocate more than we 
       have to. */
    if(PUSH_STRLEN(Result) > (maxdisplay*maxparts))
      max = maxdisplay*maxparts;
    else {
      max = PUSH_STRLEN(Result);

      /* adjust maxparts to contain the actual number of parts needed */
      maxparts = max/maxdisplay;
      if(max%maxdisplay)
        maxparts += 1;
    }

    *buffer = (char *)malloc(max+1); /* just some extra room */

    if(*buffer) 
      display(*buffer, PUSH_STRING(Result), &length, max);
  }

  return length;
}

int multipart_format(char **buffer,
                     int index,
                     int numparts)
{
  char *out = multipart;
  char temp[32];
  char rest[513];
  int num;
  int length=0;
  struct Push Result; /* hold the result */

  INIT_PUSH(Result);

  while(*out) {
    if('$' == *out) {
      out++;
      if(!strncasecmp("index", out, 5)) {
        sprintf(temp, "%d", index);
        PushString(&Result, temp);
        out+=5;
      }
      else if(!strncasecmp("numparts", out, 8)) {
        sprintf(temp, "%d", numparts);
        PushString(&Result, temp);
        out+=8;
      }
      else
        PushByte(&Result, '$');
    }
    else if('\\' == *out) {
      switch(out[1]) {
      case 'n':
        PushByte(&Result, '\n');
        break;
      case 'r':
        PushByte(&Result, '\r');
        break;
      case 't':
        PushByte(&Result, '\t');
        break;
      default:
        PushByte(&Result, out[1]);
        break;
      }
      out+=2;
    }
    else
      PushByte(&Result, *out++);
  }

  *buffer = (char *)malloc(maxdisplay+1); /* just some extra room */

  if(*buffer) 
    display(*buffer, PUSH_STRING(Result), &length, maxdisplay);

  return length;
}

#if 0
char *my_malloc(int size)
{
  char *new = (malloc)(size);
  if(new) {
    memset(new, 0xA5, size);
    printf("MALLOC %d\n", size);
  }
  return new;
}
#endif
