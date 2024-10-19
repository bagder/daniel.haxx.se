#include "doctype.t"
#include "setup.t"
HEAD(Daniel Stenberg -- Emails)
#include "body.t"
#include "daniel.t"

<style>
td {
  font-size: 120%;
  padding: 8px 8px 8px 8px;
}

/* DARK MODE PROPERTIES */
/* These will override all settings above */
@media (prefers-color-scheme: dark) {

   .odd {
     background: #101010;
   }
}
</style>

<div class="content">

TITLE(Email index)
<p>
The emails in <a href="./">the collection</a>.
<p>
#include "index.gen"
</div>

#include "footer.t"
