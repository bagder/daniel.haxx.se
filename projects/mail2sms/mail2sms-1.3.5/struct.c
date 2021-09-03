
#include "main.h"

/*
** Add a line to a linked list that makes up a boundary stack. This new one 
** should be the new "active" boundary.
**
** "Adding" a NULL will retrieve the formerly used boundary pointer.
*/

struct boundary *bound(struct boundary *bound, char *line)
{
    struct boundary *newnode=NULL;
  
    if (line) {
        newnode = (struct boundary *) malloc(sizeof(struct boundary));
        newnode->line = strdup(line);
        newnode->next = NULL;
        newnode->prev = bound;
  
        if (bound)
            bound->next = newnode;
  
        bound = newnode;
    }
    else {
        if (bound->prev) {
            /* go back to the previous */
            bound = bound->prev;
        
            /* free the latest one */
            free(bound->next->line);
            free(bound->next);
        }
        else {
            /* this is the last node */
            free(bound->line);
            free(bound);
            bound = NULL;
        }
    }
    return bound; /* the new "active" boundary */
}


/*
** Add a line to a linked list that makes up an article's body.
*/

struct body *addbody(struct body *bp,
                     struct body **lp, /* points to the last pointer */
                     char *line, int flags)
{
    struct body *tempnode;
    struct body *newnode=NULL;
  
    if (!(flags&BODY_CONTINUE)) {
        newnode = (struct body *) malloc(sizeof(struct body));
        memset(newnode, 0, sizeof(struct body));
        newnode->line = strdup(line);
        newnode->html = (flags&BODY_HTMLIZED)?1:0;
        newnode->header = (flags&BODY_HEADER)?1:0;
        newnode->attached = (flags&BODY_ATTACHED)?1:0;
        newnode->next = NULL;
    }
    if (bp == NULL) {
        bp = newnode;
        *lp = bp;
    }  
    else {
        tempnode = *lp; /* get pointer right away */
  
        if (flags&BODY_CONTINUE) {
            /* this is a continuation of the previous line */
            int newlen;
            char *newbuf;
  
            /* get the new size + 1 for the terminating zero */
            newlen = strlen(tempnode->line) + strlen(line) + 1;
        
            /* extend the former memory area: */
            newbuf = (char *)realloc(tempnode->line, newlen);
  
            /* if successful, continue */
            if (newbuf) {
                /* remove (CR)LF from the first part: */
                char *lf;
                lf = strchr(newbuf, '\r');
                if(!lf)
                  /* No CR, try LF */
                  lf = strchr(newbuf, '\n');
                if (lf)
                  *lf=0;
  
                /* append the new part */
                strcat(newbuf, line);
  
                /* point out the new buffer instead */
                tempnode->line = newbuf;
            }
        }
        else {
            tempnode->next = newnode;
            *lp = newnode;
        }
    }
    return bp;
}

int rmlastlines(struct body *bp)
{
  struct body *tempnode;
 
  if(!bp)
    return 0;

  for (tempnode = bp; tempnode->next != NULL &&
	 (tempnode->next->line)[0] != '\0'; tempnode = tempnode->next)
                ;
  if((tempnode->line[0] == '\n') || (tempnode->line[0] == '\r')) {
    (tempnode->line)[0] = '\0';
    return 1;
  }
  return 0;
}
