ROOT=../..

MAINPARTS= $(ROOT)/doctype.t $(ROOT)/body.t $(ROOT)/footer.t $(ROOT)/setup.t \
 $(ROOT)/daniel.t
TODAY=$(shell gnudate +'-D__TODAY__="%B %e, %Y"')
ACTION=@echo preprocessing $@; rm -f $@; cpp -WWW -Uunix -H -C -V -I$(ROOT) $(TODAY) -LL $< $@; chmod a-w+r $@

all:	index.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
