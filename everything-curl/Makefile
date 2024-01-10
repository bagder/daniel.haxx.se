
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t
ACTION=@echo fixing $@; \
  fcpp -WWW -Uunix -H -C -V -I.. -LL $(NOW) $(TODAY) $< $@

all: index.html

index.html: index.t data.t $(MAINPARTS)
	$(ACTION)

data.t: everything-curl.pdf everything-curl.epub everything-curl.zip data.pl
	perl ./data.pl everything-curl.pdf everything-curl.epub everything-curl.zip > data.t

clean:
	find . -name "*~" -exec rm {} \;
