
#ifndef _MAIN_H
#define _MAIN_H

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
#ifdef HAVE_STDIO_H
#include <stdio.h>
#endif
#ifdef HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif
#ifdef HAVE_SYS_STAT_H
#include <sys/stat.h>
#endif
#ifdef TM_IN_SYS_TIME
#include <sys/time.h>
#else
#include <time.h>
#endif
#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif
#ifdef HAVE_PWD_H
#include <pwd.h>
#endif
#ifdef HAVE_STRING_H
#include <string.h>
#endif

#undef FALSE
#define FALSE 0
#undef TRUE
#define TRUE  1

struct body {
	char *line;
	char html;         /* set to TRUE if already converted to HTML */
	char header;       /* part of header */
	char parsedheader; /* this header line has been parsed once */
	char attached;     /* part of attachment */
	char demimed;      /* if this is a header, this is set to TRUE if
			      it has passed the decoderfc2047() function */
	struct body *next;
};

/* MIME Support */

#define BODY_NONE     0  
#define BODY_CONTINUE (1<<0) /* this is a continued line */
#define BODY_HTMLIZED (1<<1) /* this is already htmlified */
#define BODY_HEADER   (1<<2) /* this is a header line */
#define BODY_ATTACHED (1<<3) /* this line was attached */

struct boundary {
	struct boundary *next;
	struct boundary *prev;
	char *line;
};

#define VERSION "1.3.5"

#endif
