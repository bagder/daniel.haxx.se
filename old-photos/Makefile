DIRROOT=..
MAINPARTS= $(DIRROOT)/doctype.t $(DIRROOT)/body.t $(DIRROOT)/footer.t \
	$(DIRROOT)/setup.t $(DIRROOT)/daniel.t
ACTION=@echo preprocessing $@; rm -f $@; fcpp -WWW -Uunix -H -I$(DIRROOT) -C -V -LL $< $@; chmod a-w+r $@

all:	index.html 

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
