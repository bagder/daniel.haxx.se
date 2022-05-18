
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t
ACTION=@echo fixing $@; \
  fcpp -WWW -Uunix -H -C -V -I.. -LL $(NOW) $(TODAY) $< $@

all: index.html

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
