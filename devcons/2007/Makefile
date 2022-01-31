ROOT=../..
MAINPARTS= $(ROOT)/doctype.t $(ROOT)/body.t $(ROOT)/footer.t $(ROOT)/setup.t $(ROOT)/daniel.t
ACTION=fcpp -WWW -Uunix -H -C -V -I$(ROOT) -LL $< $@

all:	index.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
