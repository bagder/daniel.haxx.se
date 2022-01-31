
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t
ACTION=@echo fixing $@; \
  fcpp -WWW -Uunix -H -C -V -I.. -LL $< $@

all: index.html
	make -C 2006
	make -C 2007
	make -C 2008

index.html: index.t $(MAINPARTS)
	$(ACTION)

clean:
	rm index.html
	find . -name "*~" -exec rm {} \;
