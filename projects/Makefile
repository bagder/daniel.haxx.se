
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t ../daniel.t
ACTION=@echo preprocessing $@; rm -f $@; fcpp -WWW -Uunix -H -C -V -I.. -LL $< $@; chmod a-w+r $@

all:	index.html
	cd roffit; make

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
