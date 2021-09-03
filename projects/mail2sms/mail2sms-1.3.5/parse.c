
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <ctype.h>
#include <errno.h>

#include "main.h"
#include "struct.h"

#define MAXLINE 4096

typedef enum {
  ENCODE_UNSET,  /* not set, act NORMAL (ho ho ho) */
  ENCODE_NORMAL,
  ENCODE_QP,     /* quoted printable */

  ENCODE_MULTILINED, /* this is not a real type, but just a separator showing
                        that the types below are encoded in a way that makes
                        one line in the indata may become one or more lines
                        in the outdata */
  
  ENCODE_BASE64, /* base64 */
  ENCODE_UUENCODE, /* well, it seems there exist some kind of semi-standard
                      for uu-encoded attachments. */
 
  ENCODE_UNKNOWN /* must be the last one */
} EncodeType;

typedef enum {
    CONTENT_TEXT,   /* normal mails are text based default */
    CONTENT_BINARY, /* this kind we store separately and href to */
    CONTENT_HTML,   /* this is html formated text */
    CONTENT_IGNORE, /* don't care about this content */

    CONTENT_UNKNOWN /* must be the last one */
} ContentType;


int preferedcontent(char *type)
{
  if(!strcasecmp(type, "text/plain"))
    return 1;
  return 0;
}

/*
** strcasestr() - case insensitive strstr()
*/
 
char *strcasestr(char *haystack, char *needle)
{
  int nlen = strlen(needle);
  int hlen = strlen(haystack);
 
  int i;
  int max;
 
  max = hlen-nlen;
 
  for (i=0; i<=max; i++) {
    if (!strncasecmp(haystack, needle, nlen))
      return haystack;
    haystack++;
  }
  return NULL;
}

/*
** RFC 2047 defines MIME extensions for mail headers.
**
** This function decodes that into binary/8bit data.
**
** Example:
**   =?iso-8859-1?q?I'm_called_?= =?iso-8859-1?q?Daniel?=
**
** Should result in "I'm called Daniel", but:
**
**   =?iso-8859-1?q?I'm_called?= Daniel
**
** Should result in "I'm called Daniel" too.
**
** Returns the newly allcated string, or the previous if nothing changed 
*/

static char *mdecodeRFC2047( char *string, int length )
{
    char *iptr = string;
    char *oldptr;
    char *storage=malloc(length+1);
  
    char *output = storage;
  
    char charset[129];
    char encoding[33];
    char blurb[257];
    char equal;
    int value;
  
    char didanything=FALSE;

    while (*iptr) {
      if (!strncmp(iptr, "=?", 2) &&
	  (3 == sscanf(iptr+2, "%128[^?]?%32[^?]?%256[^ ]",
		       charset, encoding, blurb)) ) {
	/* This is a full, valid 'encoded-word'. Decode! */
	char *ptr=blurb;

	ptr = strstr(blurb, "?=");
	if(ptr) {
	  *ptr=0;
	}
	else {
	  *output++ = *iptr++;   
	  /* it wasn't a real encoded-word */
	  continue;
	}
	ptr = blurb;
  
	didanything=TRUE; /* yes, we decode something */
  
	/* we could've done this with a %n in the sscanf, but we know all
	   sscanfs don't grok that */

	iptr += 2+ strlen(charset) + 1 + strlen(encoding) + 1 + strlen(blurb) + 2;
  
	if (!strcasecmp("q", encoding)) {
	  /* quoted printable decoding */
	  
	  for ( ; *ptr; ptr++ ) {
	    switch ( *ptr ) {
	    case '=':
	      sscanf( ptr+1, "%02X", &value );
	      *output++ = value;
	      ptr += 2;
	      break;
	    case '_':
	      *output++ = ' ';
	      break;
                        default:
                          *output++ = *ptr;
                          break;
	    }
	  }
	}
            else if (!strcasecmp("b", encoding)) {
                /* base64 decoding */
                int length;
                base64Decode(ptr, output, &length);
                output += length-1;
            }
            else {
                /* unsupported encoding type */
                strcpy(output, "<unknown>");
                output += 9;
            }
  
            oldptr = iptr; /* save start position */
  
            while (*iptr && isspace(*iptr))
                  iptr++; /* pass all whitespaces */
  
            /* if this is an encoded word here, we should skip the passed
               whitespaces. If it isn't an encoded-word, we should include the
               whitespaces in the output. */

            if (!strncmp(iptr, "=?", 2) &&
                (4 == sscanf(iptr+2, "%128[^?]?%32[^?]?%128[^?]?%c",
                              charset, encoding, blurb, &equal)) &&
                ('=' == equal)) {
                continue; /* this IS an encoded-word, continue from here */
            }
            else
              /* this IS NOT an encoded-word, move back to the first whitespace */
              iptr = oldptr;
        }
        else
            *output++ = *iptr++;   
    }
    *output=0;
  
    if (didanything) {
        /* this check prevents unneccessary strsav() calls if not needed */
        free(string); /* free old memory */
  
#if 0
        /* debug display */
        printf("NEW: %s\n", storage);
  
        {  
            unsigned char *f;
            puts("NEW:");
            for (f=storage; f<output; f++) {
                if (isgraph(*f))
                   printf("%c", *f);
                else
                   printf("%02X", (unsigned char)*f);
            }
            puts("");
        }  
#endif
        return storage; /* return new */
    }
    else {
      free (storage);
      return string;
    }
}

/*
** Decode this [virtual] Quoted-Printable line as defined by RFC2045.
** Written by Daniel.Stenberg@haxx.nu
*/

static void mdecodeQP(FILE *file, char *input, char **result, int *length)
{
    int outcount=0;
    char *buffer=input;
    unsigned char inchar;
    char *output;

    int len=strlen(input);  
    output=strdup(input);

    while ((inchar = *input) != '\0') {

        if (outcount>=len-1) {
            /* we need to enlarge the destination area! */
	  /* double the size each time enlargement is needed */
            char *newp = realloc(output, len*2);
            if (newp) {
                output = newp;
                len *= 2;
            }
            else
                break;
        }

        input++;
        if ('=' == inchar) {
            int value;
            if (('\n'== *input) ||
                (('\r' == input[0]) && ('\n' == input[1]))) {
              if (!fgets(buffer, MAXLINE, file))
                break;
              input = buffer;
              continue;
            }
            else if ('=' == *input) {
              inchar='=';
              input++; /* pass this */
            }
            else if (isxdigit(*input)) {
              sscanf(input, "%02X", &value);
              inchar = (unsigned char)value;
              input+=2; /* pass the two letters */
            }
            else
            inchar='=';
        }
        output[outcount++] = inchar;
    }
    output[outcount]=0; /* zero terminate */

    *result = output;
    *length = outcount;
}

/*
** Parsing...
** This loads in the mail from stdin or a file, adding the right
** field variables to the right structures. If readone is set, it will
** think anything it reads in is one article only.
*/

struct body * process(char *mbox,    /* file name */
		      int use_stdin, /* read from stdin */
		      int readone)   /* only one mail */
{
  char line[MAXLINE];
  char *cp, *dp;
  FILE *fp;
  int num, isinheader;

  /* -- variables for the multipart/alternative parser -- */
  struct body *origbp=NULL;     /* store the original bp */
  struct body *origlp=NULL;     /* ... and the original lp */
  char alternativeparser=FALSE; /* set when inside alternative parser mode */
  /* -- end of alternative parser variables -- */

  struct body *bp;
  struct body *lp=NULL; /* the last pointer, points to the last node in the
                           body list. Initially set to NULL since we have
                           none at the moment. */

  struct body *headp=NULL; /* stored pointer to the point where we last
                              scanned the headers of this mail. */

  char Mime_B = FALSE;
  char boundbuffer[128]="";

  struct boundary *boundp=NULL; /* This variable is used to store a stack 
                                   of boundary separators in cases with mimed 
                                   mails inside mimed mails */

  char multilinenoend=FALSE; /* This variable is set TRUE if we have read 
                                a partial line off a multiline-encoded line, 
                                and the next line we read is supposed to get
                                appended to the previous one */

  int bodyflags=0;           /* This variable is set to extra flags that the 
                                addbody() calls should OR in the flag parameter */

  char *binname=NULL;        /* file name to store binary attachments in */
  int binfile=-1;

  char *boundary;
  char type[129]; /* for Content-Type */


  EncodeType decode=ENCODE_UNSET;
  ContentType content=CONTENT_TEXT;
  
  if (use_stdin || !mbox || !strcasecmp(mbox, "NONE"))
    fp = stdin;
  else if ((fp = fopen(mbox, "r")) == NULL) {
    return; /* add error code */
  }
  
  isinheader = 1;

  bp = NULL;

  while (fgets(line, MAXLINE, fp) != NULL) {
#if 0
    printf("IN: %s", line);
#endif
    if (isinheader) {
      /* check for MIME */
      if (!strncasecmp( line, "MIME-Version:", 13))
        Mime_B = TRUE;
      else if (isspace(line[0]) && ('\n' != line[0]) && ('\r' != line[0])) {
        /*
        ** since this begins with a whitespace, it means the 
        ** previous line is continued on this line, leave only 
        ** one space character and go! 
        */
        char *ptr=line;
        while (isspace(*ptr))
          ptr++;
        ptr--; /* leave one space */
        *ptr=' '; /* make it a true space, no tabs here! */
#if 0
        decodeRFC2047(ptr+1, MAXLINE-(ptr+2-line));
#endif
        bp = addbody(bp, &lp, ptr, BODY_CONTINUE|BODY_HEADER|bodyflags);
      }
  
      else if ((line[0] == '\n') || (line[0] == '\r')) {
        struct body *head;

        char savealternative;

        /* 
        ** we mark this as a header-line, and we use it to 
        ** track end-of-header displays 
        */
        bp = addbody(bp, &lp, line, BODY_HEADER|bodyflags);
        isinheader--;

#if 0
        printf("HEADER status: %d\n", isinheader);
#endif

        /*
        ** This signals us that we are no longer in the header, 
        ** let's fill in all those fields we are interested in. 
        ** Parse the headers up to now and copy to the target 
        ** variables 
        */
  
        for (head = bp; head; head=head->next) {
          if (head->header && !head->demimed) {
            head->line = mdecodeRFC2047(head->line, strlen(head->line));
            head->demimed=TRUE; /* don't do this again */
          }
        }

        if (!headp)
          headp=bp;

        savealternative = FALSE;
                
        for (head = headp; head; head=head->next) {
          if(head->parsedheader || !head->header)
            continue;

          if (!strncasecmp( head->line, "Content-Type:", 13)) {
            char *ptr=head->line+13;
#define DISP_HREF 1
#define DISP_IMG  2
#define DISP_IGNORE 3
            /* default is href to the attachment: */
            char disposition=DISP_HREF;

            /* we must make sure this is not parsed more times
               than this */
            head->parsedheader= TRUE;

            while (isspace(*ptr))
              ptr++;

            sscanf(ptr, "%128[^;]", type);
            if ((cp = strchr(type, '\r')) != NULL) 
              *cp = '\0'; /* rm CR */
            if ((cp = strchr(type, '\n')) != NULL) 
              *cp = '\0'; /* rm LF */

            if(alternativeparser) {
              /* We are parsing alternatives... */

              if(preferedcontent(type) ) {
                /* ... this is a prefered type, we want to store
                   this [instead of the earlier one]. */
#if 0
                struct body *next;
                printf("%s is more fun than the previous one\n",
                       type);
#endif
#if 0
                /*
                ** Not sure why this free section is here.
                ** It is causing purify to barf with massive numbers of
                ** "FMR: Free memory reads". When I commented it out it
                ** cleared up the problem with no associated memory leaked
                ** or difference in output. It's history for now.
                */ 
                while(bp) {
                  next=bp->next;
                  if (bp->line) free(bp->line);
                  if (bp) free(bp);
                  bp=next;
                }
#endif
                headp = NULL;
              }
              else {
                /* ...and this type is not a prefered one. Thus, we
                 * shall ignore it completely! */
                disposition = DISP_IGNORE;
#if 0
                printf("%s is to be ignored\n", type);
#endif
              }
            }
            if (!strcasecmp(type, "text/plain") ||
                (!alternativeparser &&
                 !strcasecmp(type, "text/html")) ) {
              /* 
               * text or inlined html follows
               */
              /* default is just plain 7/8 bit */
              if(ENCODE_UNSET == decode)
                decode = ENCODE_NORMAL;

              if (!strcasecmp(type, "text/html"))
                content = CONTENT_HTML;
              else
                content = CONTENT_TEXT;
              continue;
            }
            else if (!strncasecmp(type, "message/rfc822", 14)) {
              /* 
              ** Here comes an attached mail! This can be ugly, 
              ** since the attached mail may very well itself 
              ** contain attached binaries, or why not another 
              ** attached mail? :-)
              **
              ** We need to store the current boundary separator 
              ** in order to get it back when we're done parsing 
              ** this particular mail, since each attached mail 
              ** will have its own boundary separator that *might*
              ** be used.
              */
#if 0
              /* removed 2001-02-07, this is old leftovers from when I
               * picked this code out of hypermail */
              bp = addbody(bp, &lp,
                           "<P><STRONG>attached mail follows:</STRONG><HR>",
                           BODY_HTMLIZED | bodyflags);
#endif
              bodyflags |= BODY_ATTACHED;
              isinheader = 2;
              continue;
            }
            else if (strncasecmp(type, "multipart/", 10)) {
              /* 
              ** This is not a multipart and not text 
              */
              struct body *fnamep=NULL; 
              char acomment[256];      
              char attachname[129]; /* listed attachment name */
              char checkpath[256];  /* uniqueness path */
              char *fname = NULL;    /* attachment filename */
              char nameisuniq=FALSE; /* use the name included ?*/
              char *file = NULL;
  
              fname = strstr(ptr, "name=");
              if (NULL == fname) {
                /* 
                ** Name of file not specified in the
                ** Content-Type header.  See if the 
                ** Content-Disposition header exists and
                ** contains the info.
                */

                for (fnamep = head;fnamep;fnamep=fnamep->next) {
                  if(!fnamep->header)
                    continue;
                  if (!strncasecmp(fnamep->line,"Content-Disposition:", 20)) {
                    if ((fname = strstr(fnamep->line, "filename=")) != NULL) {
                      sscanf(fname+10, "%128[^\"]",attachname);
                      fname = attachname;
                    }
                  }
                }
              }
              else {
                sscanf(fname+6, "%128[^\"]", attachname);
                fname = attachname;
              }
#if 0
              sprintf(line, "** %s\n", fname?fname:"attachment");
              bp = addbody(bp,&lp,line,BODY_HTMLIZED|bodyflags);
#endif
              /* don't save this */
              disposition = DISP_IGNORE;
              content = CONTENT_IGNORE;

              continue;
            }
            else {
              /*
              ** Find the first boundary separator 
              */
           
              boundary=strcasestr(ptr, "boundary=");
              
              if (boundary) {
                boundary=strchr(boundary, '=');
                if (boundary) {
                  boundary++;
                  while (isspace(*boundary))
                    boundary++;
                  if ('\"' == *boundary) {
                    sscanf(++boundary, "%[^\"]", boundbuffer);
                  }
                  else
                    sscanf(boundary, "%s", boundbuffer);
                  boundary = boundbuffer;
                }
                           
                while (fgets(line, MAXLINE, fp)) {
                  if (!strncmp(line, "--", 2) &&
                      !strncmp(line+2, boundbuffer, 
                               strlen(boundbuffer))) {
                    break;
                  }
                }
  
                /* 
                ** This stores the boundary string in a stack 
                ** of strings: 
                */
                boundp = bound(boundp, boundbuffer);
  
                /* printf("set new boundary: %s\n", boundp->line); */
  
                /*
                ** We set ourselves, "back in header" since there is
                ** gonna come MIME headers now after the separator
                */
                isinheader = 1;

                /* Daniel Stenberg started adding the
                 * "multipart/alternative" parser 13th of July
                 * 1998!  We check if this is a 'multipart/
                 * alternative' header, in which case we need to
                 * treat it very special.  
                 */

                if(!strncasecmp(&ptr[10], "alternative", 11)) {
                  /* It *is* an alternative session!  Alternative
                  ** means there will be X parts with the same text
                  ** using different content-types. We are supposed
                  ** to take the most prefered format of the ones
                  ** used and only output that one. MIME defines
                  ** the order of the texts to start with pure text
                  ** and then continue with more and more obscure
                  ** formats. (well, it doesn't use those terms but
                  ** that's what it means! ;-)) 
                  */

                  /* How "we" are gonna deal with them:
                  **
                  ** We create a "spare" linked list body for the
                  ** very first part. Since the first part is
                  ** defined to be the most readable, we save that
                  ** in case no content-type present is prefered!
                  **
                  ** We skip all parts that are not prefered. All
                  ** prefered parts found will replace the first
                  ** one that is saved. When we reach the end of
                  ** the alternatives, we will use the last saved
                  ** one as prefered.
                  */

                  savealternative = TRUE;
#if 0
                  printf("SAVEALTERNATIVE: yes\n");
#endif           
                             
                }

              }
              else
                boundary = NULL;
            }
          }
          else if (!strncasecmp(head->line, "Content-Transfer-Encoding:", 26)) {
            char *ptr=head->line+26;
  
            head->parsedheader= TRUE;
            while (isspace(*ptr))
              ptr++;
            if (!strncasecmp(ptr, "QUOTED-PRINTABLE", 16)) {
              decode = ENCODE_QP;
            }
            else if (!strncasecmp(ptr, "BASE64", 6)) {
              decode = ENCODE_BASE64;
            }
            else if (!strncasecmp(ptr, "8BIT", 4)) {
              decode = ENCODE_NORMAL;
            }
            else if (!strncasecmp(ptr, "7BIT", 4)) {
              decode = ENCODE_NORMAL;
            }
            else if (!strncasecmp(ptr, "x-uue", 5)) {
              decode = ENCODE_UUENCODE;
  
              if (uudecode(fp, line, line, NULL, TRUE))
                /*
                ** oh gee, we failed this is chaos */
                break;
            }  
            else {
              /* this is an unknown format, we use default decoding */
              char code[64];
  
              sscanf(ptr, "%63s", code);
              sprintf(line, " ('%s')\n", code);
  
              bp = addbody(bp, &lp, line, BODY_HTMLIZED|bodyflags);
            }  
#if 0
            printf("DECODE set to %d\n", decode);
#endif
          }
        }
        if (savealternative) {
          /* let's remember 'bp' and 'lp' */

          origbp=bp;
          origlp=lp;

          alternativeparser = TRUE;

          /* restart on a new list: */
          lp=bp=NULL;
        }
        headp = lp; /* start at this point next time */
      }
      else {
#if 0
        decodeRFC2047(line, MAXLINE);
#endif
        bp = addbody(bp, &lp, line, BODY_HEADER|bodyflags);
      }
    }
    else {
      /* decode MIME complient gibberish */
      char newbuffer[MAXLINE];
      char *data;
      int datalen=-1; /* -1 means use strlen to get length */
    
      if (Mime_B) {
        if (boundp &&
            !strncmp(line, "--", 2) &&
            !strncmp(line+2, boundp->line, strlen(boundp->line))) {
          /* right at this point, we have another part coming up */
          isinheader = 1; /* back on a kind-of-header */

#if 0
          printf("hit %s\n", line);
#endif
          if (!strncmp(line+2+strlen(boundp->line), "--", 2)) {
            bp = addbody(bp,&lp,"\n",BODY_HTMLIZED|bodyflags);
    

            isinheader = 0; /* no header, the ending boundary
                               can't have any describing
                               headers */

#if 0
            printf("End boundary %s\n", line);
#endif
            boundp = bound(boundp, NULL);
            if (!boundp) {
              bodyflags &= ~BODY_ATTACHED;
            }
            if(alternativeparser) {
              struct body *next;
              /* we no longer have alternatives */
              alternativeparser = FALSE;
#if 0
              printf("We DUMP an old alternative\n");
#endif
              while(bp) {
                origbp = addbody(origbp, &origlp,
                                 bp->line,
                                 (bp->header?BODY_HEADER:0)|
                                 (bp->html?BODY_HTMLIZED:0)|
                                 (bp->attached?BODY_ATTACHED:0)
                                 );
                next= bp->next;
                free(bp->line);
                free(bp);
                bp=next;
              }
              bp = origbp;
              lp = origlp;

              headp= NULL;
            }
#if 0
            if (boundp)
              printf("back %s\n", boundp->line);
            else
              printf("back to NONE\n");
#endif
          }
    
          if (-1 != binfile) {
            close(binfile);
            binfile=-1;
          }
          continue;
        }
      }
    
      switch ( decode ) {
      case ENCODE_QP:
        mdecodeQP(fp, line, &data, &datalen);
        break;
      case ENCODE_BASE64:
        base64Decode(line, newbuffer, &datalen);
        data = newbuffer;
        break;
      case ENCODE_UUENCODE:
        uudecode(NULL, line, newbuffer, &datalen, FALSE);
        data = newbuffer;
        break;
      case ENCODE_NORMAL:
      case ENCODE_UNSET:
        data = line;
        break;
      default:
        /* we have no clue! */
        data = NULL;
        break;
      }
#if 0
      printf("LINE %s\n", data);
#endif
      if (data) {
        if ((content == CONTENT_TEXT) || (content==CONTENT_HTML)) {
          if (decode > ENCODE_MULTILINED) {
            /* 
            ** This can be more than one resulting line, 
            ** as the decoded the string may look like:
            "#!/bin/sh\r\n\r\nhelp() {\r\n echo 'Usage: difftree"
            */
            char *p=data;
            char *n;
            char store;

#if 0
            printf("decode type %d\n", decode);
#endif

            while ((n = strchr(p, '\n'))) {
              store = n[1];
              n[1]=0;
#if 0
              printf("UNFOLDED %s", p);
#endif
              bp = addbody(bp, &lp, p,
                           (content==CONTENT_HTML?
                            BODY_HTMLIZED:0)|
                           (multilinenoend?BODY_CONTINUE:0)|
                           bodyflags);
              multilinenoend = FALSE; /* full line pushed */                                 n[1]=store;
              p = n+1;
            }
            if (strlen(p)) {
                                /* 
                                ** This line doesn't really end here, 
                                ** we will get another line soon that 
                                ** should get appended! 
                                */
#if 0
              printf("CONTINUE %s\n", p);
#endif
              bp = addbody(bp, &lp, p,
                           (content==CONTENT_HTML?
                            BODY_HTMLIZED:0)|
                           (multilinenoend?BODY_CONTINUE:0)|
                           bodyflags);
				 
                                /*
                                ** We want the next line to get appended to this!
                                */
              multilinenoend = TRUE;
            }
          }
          else {
            bp = addbody(bp, &lp, data, 
                         (content==CONTENT_HTML?
                          BODY_HTMLIZED:0) | bodyflags );
          }
#if 0
          printf("ALIVE?\n");
#endif
        }
        else if (content == CONTENT_BINARY) {
          if (-1 != binfile) {
            if (datalen < 0)
              datalen = strlen(data);
                
            /*fwrite(data, datalen, 1, binfile); */
            write(binfile, data, datalen);
            /*bp = addbody(bp, "file contents");*/
          }
        }
    
        if (ENCODE_QP == decode)
          free(data); /* this was allocatd by mdecodeQP() */
      }
    }
  }

  if (!isinheader || readone) {
    while (rmlastlines(bp));
    num++;
  }
    
  fclose(fp);

  /* can we clean up a bit please... */
  
  if (boundp != NULL) {
    if (boundp->line) 
      free(boundp->line);
    free(boundp);
  }


  return bp;
}

