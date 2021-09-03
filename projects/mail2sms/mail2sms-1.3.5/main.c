#include "main.h"
#include "sms.h"
#include "parse.h"

#include "sendmsg.h"

extern int num_of_regex;

int valid=TRUE;
int exitcode=0;
extern char phone[256];

/* maximum size of the output data */
extern int maxdisplay;
/* maximum number of output parts */
extern int maxparts;

#ifdef AFS
#define CONFIGDIR "/var/mail2sms/"
#else
#define GLOBAL_CONFIG "/etc/mail/sms/mail2sms.conf"
#endif

extern FILE *logfile; /* write logs to this file pointer */
extern char forced_logfile; /* set on command line disable config
                               file's specification */

/* default view is everything but debug info: */
int viewlog = 0xffff- (1 << LOGF_DEBUG) - (1<<LOGF_DEBUGREGEX);

typedef enum {
  CONFIG_NONE,
  CONFIG_DEFAULT, /* built-in set */
  CONFIG_USER,    /* user-specified */
  CONFIG_LAST
} ConfigType;

struct ConfigFile {
  char *filename;
  ConfigType type;
  struct ConfigFile *next;
};

struct ConfigFile *configs=NULL;

void static
AddConfigFile(ConfigType type, char *filename)
{
  struct ConfigFile *newnode =
    (struct ConfigFile *)malloc(sizeof(struct ConfigFile));
  struct ConfigFile *last = configs;

  if(newnode) {
    /* fill the struct with zeros if needed */

    /* find the end of the current action-list */
    while(last && last->next) {
      last = last->next;
    }

    newnode->filename = strdup(filename);
    newnode->type = type;
    newnode->next = NULL; /* we always append the last node */

    /* now link it */
    if(last)
      last->next = newnode;
    else
      configs = newnode; /* the first action node here */
  }
}

int main(int argc, char **argv)
{
  struct passwd *pw;
#ifndef AFS
  char *home = getenv("HOME");
#endif
  char filename[256];
  int i=1;
  struct body *mailp;
  char outstdout = FALSE;
  char defaultconfig = TRUE; /* get the default config file(s) */

#if 0
  alarm(60); /* a 60 second maximum time for the *COMPLETE* operation 
		or we go boom! */
#endif

  /* set global default config file name */
  AddConfigFile(CONFIG_DEFAULT, GLOBAL_CONFIG);

  /* set user-default config file */
  *filename= '\0';
#ifdef AFS
  strncat(filename, CONFIGDIR, 255);
  if (! (pw= getpwuid(geteuid()))) {    
    logf(LOGF_ERROR, "unable to get passwd entry for uid %d!\n", geteuid());
  }
  strncat(filename, pw->pw_name, 255-sizeof(CONFIGDIR));
#else
  if (home && *home)
    strncat(filename, home, 255);
  else {
    if (pw= getpwuid(geteuid())) {    
      strncat(filename, pw->pw_dir, 255);
    }
    else {
      logf(LOGF_ERROR, "unable to get passwd entry for uid %d!\n", geteuid());
    }
  }
  if (strlen(filename) < 245)
    strcat(filename, "/.mail2sms");
  else
    logf(LOGF_ERROR, "home directory is too long!\n");
#endif

  AddConfigFile(CONFIG_DEFAULT, filename);

  for(; i<argc; i++) {
    if(!strcmp("-c", argv[i])) {
      if(argc>i+1) {
	/* get a specified set of replacements */
        AddConfigFile(CONFIG_USER, argv[++i]);
      }
    }
    else if(!strcmp("-d", argv[i])) {
      viewlog |= (1<< LOGF_DEBUG) |
        (1<< LOGF_DEBUGREGEX); /* log debug info too */
    }
    else if(!strcmp("-l", argv[i])) {
      if(argc>i+1) {
	/* get the specified logfile, if it becomes NULL, stderr will
           be used */
        logfile = fopen(argv[++i], "a");
        if(logfile)
          forced_logfile = TRUE; /* this overrides other settings */
      }
    }
    else if(!strcmp("-I", argv[i])) {
      if(argc>i+1) {
	/* Add directory to include path: */
	AddPath(argv[++i]);
      }
    }
    else if(!strcmp("-n", argv[i])) {
      defaultconfig = FALSE;
    }
    else if(!strcmp("-o", argv[i])) {
      outstdout = TRUE; /* write message to stdout */
    }
    else if(!strcmp("-p", argv[i])) {
      if(argc>i+1) {
	/* get a specified phone number */
	strcpy(phone, argv[++i]);
      }
    }
    else if(!strcmp("-q", argv[i])) {
      viewlog = 0; /* don't log anything */
    }
    else if(!strcmp("-v", argv[i])) {
      printf("mail2sms " VERSION "\n");
      return 1;
    }
    else {
      printf("mail2sms " VERSION " by Daniel Stenberg <daniel@haxx.se>\n"
             "Usage: mail2sms [options]\n"
	     "  -c <file>   - Read specified config file\n"
	     "  -d          - Show debug info in log\n"
	     "  -I <dir>    - Add directory to include path\n"
             "  -l <file>   - Log to this file\n"
	     "  -n          - Prevents reading the default config files\n"
	     "  -o          - Write message to stdout\n"
	     "  -p <number> - Set $phone number\n"
	     "  -q          - Shut off logging\n"
             "  -v          - Show version number\n"
	     "Default config files: %s and %s\n",
	     GLOBAL_CONFIG, filename);
      return 1;
    }
  }

  while(configs) {
    struct ConfigFile *next;
    if(defaultconfig ||
       (configs->type!=CONFIG_DEFAULT))
      /* either we want the default or this isn't a default file */
      readconfig(configs->filename, MAX_INCLUDE_DEPTH);
    next = configs->next;

    /* free the file name and main struct */
    free(configs->filename);
    free(configs);

    configs = next;
  }

  /* all config files are done */
  if(valid) {
    char *smsbuffer=NULL;
    mailp = process("", 1, 1);
    if(mailp) {
      i = makesms(&smsbuffer, mailp);
      if(i) {
        /* ok, log it anyway, the first 500 bytes max */
        logf(LOGF_INFO, "MSG: %.500s\n", smsbuffer);
        if(maxparts == 1) {
          if(outstdout) {
            puts(smsbuffer);
          }
          else
            smsit(smsbuffer);
        }
        else {
          char *buffer;
          char *fix; /* pre or post */
          char *ptr=smsbuffer;

          long sizeleft=i;
          long copysize;
          
          buffer=(char*)malloc(maxdisplay+1); /* Add error check */
          
          for(i=1; i<= maxparts; i++) {
            int fixlen = multipart_format(&fix, i, maxparts);

            if(sizeleft > maxdisplay) {
              copysize=maxdisplay; /* copy this size, tops! */
            }

            if(fix[0] == '-') {
              fixlen--;
              /* we have 'fixlen' number of suffix */
              memcpy(buffer, ptr, copysize-fixlen);
              strcpy(buffer+copysize-fixlen, &fix[1]);
            }
            else {
              /* we have fixlen number of prefix */
              strcpy(buffer, fix);
              memcpy(buffer+fixlen, ptr, copysize-fixlen);
              buffer[copysize] = '\0'; /* zero terminate! */
            }
            ptr += (copysize-fixlen);
            if(outstdout)
              puts(buffer);
            else
              smsit(buffer); /* a single part */

            sizeleft -= (copysize -fixlen);
          }
          free(buffer);
        }
      }
    }
    if(smsbuffer)
      free(smsbuffer);
  }
  else {
    if (!exitcode)
      logf(LOGF_BREAK, "instructed to stop\n");
    else
      logf(LOGF_EXIT, "instructed to EXIT with code %d\n",exitcode);
  }

  if(logfile)
    fclose(logfile); 

  return exitcode;

}
