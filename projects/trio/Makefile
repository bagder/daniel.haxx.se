
MAINPARTS= _doctype.html _menu.html _footer.html setup.t
# today's date (assumes GNU date)
NOW=$(shell date +'-D__TODAY__=%B %d, %Y')

MAN2HTML = roffit --bare < $<

ACTION=@echo preprocessing $@; rm -f $@; cpp -WWW -Uunix -H -C -V -LL "$(NOW)" $< $@; chmod a-w+r $@

all: index.html download.html strio.shtml trio_printf.shtml  trio_scanf.shtml\
	competition.html

index.html: _index.html $(MAINPARTS)
	$(ACTION)

competition.html: _competition.html $(MAINPARTS)
	$(ACTION)

download.html: _download.html $(MAINPARTS)
	$(ACTION)

strio.shtml: _strio.html $(MAINPARTS) strio.t
	$(ACTION)

strio.t: strio.3
	$(MAN2HTML) >$@

trio_printf.shtml: _trio_printf.html $(MAINPARTS) trio_printf.t
	$(ACTION)

trio_printf.t: trio_printf.3
	$(MAN2HTML) >$@


trio_scanf.shtml: _trio_scanf.html $(MAINPARTS) trio_scanf.t
	$(ACTION)

trio_scanf.t: trio_scanf.3
	$(MAN2HTML) >$@
