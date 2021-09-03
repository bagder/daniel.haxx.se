ROOT=../..

MAINPARTS= $(ROOT)/doctype.t $(ROOT)/body.t $(ROOT)/footer.t $(ROOT)/setup.t \
 $(ROOT)/daniel.t
ACTION=@echo preprocessing $@; rm -f $@; cpp -WWW -Uunix -H -C -V -I$(ROOT) -LL $< $@; chmod a-w+r $@

all:	index.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
