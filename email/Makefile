MARKDOWN=pandoc -f gfm
MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t ../daniel.t
ACTION= fcpp -WWW -Uunix -H -C -V -I.. -LL $< $@
EMAILDEP=mkhtml.pl emailtemplate.t
EMAIL2HTML=./mkhtml.pl | fcpp -WWW -Uunix -H -C -V -I.. -LL >$@

EMAILS=
-include make.out

OUT=index.html toc.html $(EMAILS)

all: $(OUT)

index.html: index.t $(MAINPARTS)
	$(ACTION)

toc.html: toc.t $(MAINPARTS) index.gen
	$(ACTION)

index.gen: ./mkindex.pl emails/2*/*md
	./mkindex.pl index.gen make.inc make.out

-include make.inc

clean:
	rm -f $(OUT) index.gen make.inc make.out *~
