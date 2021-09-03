DIRROOT=..
MAINPARTS= $(DIRROOT)/doctype.t $(DIRROOT)/body.t $(DIRROOT)/footer.t \
	$(DIRROOT)/setup.t $(DIRROOT)/daniel.t
ACTION=@echo preprocessing $@; rm -f $@; fcpp -WWW -Uunix -H -I$(DIRROOT) -C -V -LL $< $@; chmod a-w+r $@

all:	index.html bilder.html

index.html: hus.t $(MAINPARTS)
	$(ACTION)

bilder.html: bilder.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
	rm -f index.html bilder.html
