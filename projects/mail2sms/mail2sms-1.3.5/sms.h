/*
 * max number of nested includes allowed
 */
#define MAX_INCLUDE_DEPTH 5

/* standard default SMS message is 160 bytes */
#define MAX_DISPLAY 160

/* default is to allow only one output part */
#define MAX_PARTS 1

/* Max prio level: */
#define SMSPRIO_MAX 5

#define PRIO_DEFAULT 3

int makesms(char **, void *);
int multipart_format(char **, int, int);
int readconfig(char *, int);


typedef enum {
  LOGF_INFO, /* general no-prefix log line */
  LOGF_BREAK,
  LOGF_ERROR,
  LOGF_DEBUG,
  LOGF_DEBUGREGEX,
  LOGF_WARN,
  LOGF_ABORT,
  LOGF_IF,
  LOGF_SEARCH,
  LOGF_NOT,
  LOGF_DELETE,
  LOGF_CREATE,
  LOGF_SYSTEM,
  LOGF_CONFIG,
  LOGF_ACTION,
  LOGF_EXIT,

  LOGF_LAST
} LogfType;

/* Log the specified data: */
void logf(LogfType, char *fmt, ...);

/*
** Use this struct to build expandable buffers. Quick and easy.
** Daniel 1998-11-17.
*/

struct Push {
  char *string;
  size_t len;
  size_t alloc;
};

#define INIT_PUSH(x) memset(&(x), 0, sizeof(struct Push))
#define RETURN_PUSH(x) return (x).string

#define PUSH_STRING(x) (x).string
#define PUSH_STRLEN(x) (x).len

char *PushByte(struct Push *push,
	       char byte);     /* byte to append */
char *PushString(struct Push *push,
		 char *append);  /* string to append */
char *PushNString(struct Push *push,
		  char *append,  /* string to append */
		  int size);      /* maximum number of bytes to copy */

void AddPath(char *dir);
void ShowLog(char *toggle);
