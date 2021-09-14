
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t topmenu.t head.t
ACTION=@echo fixing $@; \
  fcpp -WWW -Uunix -H -C -V -I.. -LL $(NOW) $(TODAY) $< $@

all: index.html pres.html faq.html changelog.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

pres.html: pres.t $(MAINPARTS)
	$(ACTION)

faq.html: faq.t $(MAINPARTS)
	$(ACTION)

changelog.html: changelog.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
