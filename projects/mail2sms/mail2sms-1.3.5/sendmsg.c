
#include <stdio.h>

#include <sys/stat.h>
#include <errno.h>
#include <string.h>

#include "sms.h"


extern char phone[256];
extern char smsserver[256];
extern unsigned short smsserverport;
extern char program[256];
extern char run[256];
extern char progargs[256];

char port[32];

struct Run {
  char *name;
  char *value;
};

/*
 * Prepend the escape character before all non-alpha or digit characters.
 */
static char *escape(char *input)
{
  struct Push buf;
  char *string=NULL;

  INIT_PUSH(buf);
  while (input && *input) {
    if((*input != ' ') && !isalnum((int)*input) )
      PushByte(&buf, '\\');
    string = PushByte(&buf, *input);
    input++;
  };
  return string;
};

int smsit(char *message)
{
  if(strlen(run)) {
    struct Push buf;
    char *out;
    int i;
    FILE *runit;

    struct Run vars[]={
      {"program", program},
      {"server", smsserver},
      {"port", port},
      {"phone", phone},
      {"progargs", progargs},
      {"message", message},
    };      

    INIT_PUSH(buf);

    sprintf(port, "%d", smsserverport);

    out = run;
    while(*out) {
      if('$' == *out) {
	out++;
	for(i=0; i<sizeof(vars)/sizeof(vars[0]); i++) {
	  if(!strncasecmp(vars[i].name, 
			  out,
			  strlen(vars[i].name))) {
            /* escape all characters possibly sensitive when sent to popen() */
            char *str = escape(vars[i].value);
	    PushString(&buf, str);
	    out+= strlen(vars[i].name);
	    i=0;
	    break;
	  }
	}
	if(i)
	  PushByte(&buf, '$');
      }
      else
	PushByte(&buf, *out++);
    }

    out = PUSH_STRING(buf);

    runit = popen(out, "w");
    if(runit) {
      fwrite(message, strlen(message), 1, runit);
      pclose(runit); /* close program again */

      logf(LOGF_DEBUG, "(cmd in): %s\n", run);
      logf(LOGF_DEBUG, "(cmd run): %s\n", out);
    }
    else
      logf(LOGF_ERROR, "can't run command: \"%s\"\n", run);

  }
  return 0;
}
