#include "doctype.t"
#define OGDESC "The Daniel email collection"
#include "setup.t"
HEAD(Daniel Stenberg -- Email)
#include "body.t"
#include "daniel.t"

<style>

pre {
    max-width: 50em;
    background: #f0f0f0;
    white-space: pre-wrap;
    word-break: keep-all;
}

table {
}
td {
    border: 2px solid black;
    padding: 4px 10px 4px 10px;
}

/* DARK MODE PROPERTIES */
/* These will override all settings above */
@media (prefers-color-scheme: dark) {

   pre {
     background: #101010;
   }
}
</style>

<div class="content">
<p>
<i>Part of <td><a href="./">The Daniel email collection</a></i>
<p>
<table>
<tr>
<td><a href="%PREV%">&lt; prev</a> </td>
<td><a href="%NEXT%">next &gt;</a></td>
<td><a href="./toc.html">index</a> </td>
</tr>
</table>
<p>
%EMAIL%

</div>

#include "footer.t"
