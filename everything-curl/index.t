#include "doctype.t"
#include "setup.t"
HEAD(Everything curl)
#include "body.t"
#include "setup.t"

#include "data.t"

TITLE(Everything curl)
<p>
 <a href="https://everything.curl.dev">Everything curl</a> is hosted on everything.curl.dev.
<p>
 The sources are hosted on <a href="https://github.com/bagder/everything-curl">GitHub</a>
<p>

SUBTITLE(Downloadable)
<p>
<table cellpadding="5">
<tr>
<th>Format</th>
<th>Size</th>
<th>Updated</th>
</tr>

<tr><td>
<a href="everything-curl.pdf">PDF</a>
</td><td>
EVERYTHING_CURL_PDF_MB MB
</td><td>
EVERYTHING_CURL_PDF_STAMP
</td></tr>

<tr><td>
<a href="everything-curl.epub">ePUB</a>
</td><td>
EVERYTHING_CURL_EPUB_MB MB
</td><td>
EVERYTHING_CURL_EPUB_STAMP
</td></tr>

<tr><td>
<a href="everything-curl.zip">HTML</a>
</td><td>
EVERYTHING_CURL_ZIP_MB MB
</td><td>
EVERYTHING_CURL_ZIP_STAMP
</td></tr>

</table>

#include "footer.t"
