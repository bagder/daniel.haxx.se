MARKDOWN=pandoc -f gfm
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t ../daniel.t
ACTION=@echo fixing $@; \
  fcpp -WWW -Uunix -H -C -V -I.. -LL $(NOW) $(TODAY) $< $@

TODAY=$(shell date +'-D__TODAY__="%B %e, %Y"')
NOW=$(shell date +'-D__NOW__="%H:%M"')

OUT=index.html sshproxy.html curl-vs-wget.html m6d2.html ftp-vs-http.html \
 bittorrent-vs-http.html encrypted-transfer-protocols-compared.html \
 curl-vs-libcurl.html poll-vs-select.html curl-vs-httpie.html \
 URL-interop.html wcurl-vs-wget.html

all: $(OUT)

index.html: index.t $(MAINPARTS)
	$(ACTION)

sshproxy.html: sshproxy.t $(MAINPARTS)
	$(ACTION)

m6d2.html: m6d2.t $(MAINPARTS)
	$(ACTION)

curl-vs-wget.gen: docs/curl-vs-wget.md
	$(MARKDOWN) < docs/curl-vs-wget.md > curl-vs-wget.gen

curl-vs-wget.html: curl-vs-wget.t $(MAINPARTS) curl-vs-wget.gen
	$(ACTION)

wcurl-vs-wget.gen: docs/wcurl-vs-wget.md
	$(MARKDOWN) < docs/wcurl-vs-wget.md > wcurl-vs-wget.gen
wcurl-vs-wget.html: wcurl-vs-wget.t $(MAINPARTS) wcurl-vs-wget.gen
	$(ACTION)

curl-vs-httpie.gen: docs/curl-vs-httpie.md
	$(MARKDOWN) < docs/curl-vs-httpie.md > curl-vs-httpie.gen

curl-vs-httpie.html: curl-vs-httpie.t $(MAINPARTS) curl-vs-httpie.gen
	$(ACTION)

poll-vs-select.gen: docs/poll-vs-select.md
	$(MARKDOWN) < $< > $@

poll-vs-select.html: poll-vs-select.t $(MAINPARTS) poll-vs-select.gen
	$(ACTION)

curl-vs-libcurl.html: curl-vs-libcurl.t $(MAINPARTS)
	$(ACTION)

ftp-vs-http.gen: docs/ftp-vs-http.md
	$(MARKDOWN) < $< > $@

ftp-vs-http.html: ftp-vs-http.t $(MAINPARTS) ftp-vs-http.gen
	$(ACTION)

encrypted-transfer-protocols-compared.html: encrypted-transfer-protocols-compared.t $(MAINPARTS)
	$(ACTION)

bittorrent-vs-http.gen: docs/bittorrent-vs-http.md
	$(MARKDOWN) < $< > $@

bittorrent-vs-http.html: bittorrent-vs-http.t $(MAINPARTS) bittorrent-vs-http.gen
	$(ACTION)

URL-interop.gen: docs/URL-interop.md
	$(MARKDOWN) < $< > $@
URL-interop.html: URL-interop.t $(MAINPARTS) URL-interop.gen
	$(ACTION)

clean:
	rm $(OUT)
	find . -name "*~" -exec rm {} \;
