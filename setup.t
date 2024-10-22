#define TITLEPRE <div class=title align=left>
#define TITLEPOST </div>
#define TITLE(blurb) TITLEPRE blurb TITLEPOST
#define SUBTITLE(blurb) <div class=subtitle align=left> blurb </div>

#if 0
#define BOXTOP <table width="100%" cellspacing="0" cellpadding="1" bgcolor="#8000ff"><tr><td> \
        <table width="100%" cellspacing="0" cellpadding="3"><tr><td bgcolor="#ffffff">
#define BOXBOT </td></tr></table> \
 </td></tr></table>
#else

#define BOXTOP <div class="box">
#define BOXBOT </div>
#endif

#define NBOXTOP <table width="60%" cellspacing="0" cellpadding="1" bgcolor="#8000ff"><tr><td> \
        <table width="100%" cellspacing="0" cellpadding="3"><tr><td bgcolor="#ffffff">


#ifndef OGDESC
#define OGDESC "Documentation and ramblings of Daniel Stenberg, founder and lead developer of curl."
#endif

#define HEAD(text) <head> \
<title>text</title> \
<meta name="viewport" content="width=device-width, initial-scale=1.0"> \
<link rel="STYLESHEET" type="text/css" href="/daniel.css"> \
<link rel="STYLESHEET" type="text/css" href="/content.css"> \
<link href="/lora.css" rel="stylesheet" type="text/css"> \
<meta property="og:title" name="og:title" content="text"> \
<meta property="og:type" name="og:type" content="article"> \
<meta property="og:description" name="og:description" content=OGDESC> \
<meta property="og:locale" name="og:locale" content="en_US"> \
<meta property="og:site_name" name="og:site_name" content="daniel.haxx.se"> \
<meta property="og:image" name="og:image" content="https://daniel.haxx.se/final-12-400-gray.jpg"> <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> </head>
