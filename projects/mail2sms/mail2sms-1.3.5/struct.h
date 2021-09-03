struct body *addbody(struct body *bp,
                     struct body **lp, /* points to the last pointer */
                     char *line, int flags);

struct boundary *bound(struct boundary *bound, char *line);
