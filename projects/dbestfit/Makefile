ROOT=../..

MAINPARTS= $(ROOT)/doctype.t $(ROOT)/body.t $(ROOT)/footer.t $(ROOT)/setup.t \
 $(ROOT)/daniel.t menu.t
ACTION=@echo preprocessing $@; rm -f $@; cpp -WWW -Uunix -H -C -V -I$(ROOT) -LL $< $@; chmod a-w+r $@

all:	index.html thoughts.html license.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

thoughts.html: thoughts.t $(MAINPARTS)
	$(ACTION)

license.html: license.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
