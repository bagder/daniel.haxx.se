
M2SDIR=mail2sms-1.3.5

MAINPARTS= _doctype.html _menu.html _footer.html ../../daniel.t ../../setup.t \
 setup.t
NOW=$(shell gnudate +'-D__TODAY__=%B %d, %Y')
ACTION=@echo preprocessing $@; rm -f $@; cpp -I../.. -WWW -Uunix -H -C -V -LL  "$(NOW)" $< $@; chmod a-w+r $@

all: index.html readme.shtml docs.html regex.shtml example.shtml changes.shtml\
     manpage.html

index.html: _index.html $(MAINPARTS)
	$(ACTION)

manpage.html: _manpage.html $(MAINPARTS) manpage.t
	$(ACTION)

manpage.t: $(M2SDIR)/mail2sms.1
	roffit --bare < $< >$@

docs.html: _docs.html $(MAINPARTS)
	$(ACTION)

readme.shtml : _readme.shtml $(MAINPARTS) readme.t
	$(ACTION)

readme.t: $(M2SDIR)/README
	txt2plain.pl < $< >$@

changes.shtml : _changes.shtml $(MAINPARTS) changes.t
	$(ACTION)

changes.t: $(M2SDIR)/CHANGES
	txt2plain.pl < $< >$@

regex.shtml : _regex.shtml $(MAINPARTS) regex.t
	$(ACTION)

regex.t: $(M2SDIR)/REGEX
	txt2plain.pl < $< >$@

example.shtml : _example.shtml $(MAINPARTS) example.t
	$(ACTION)

example.t: $(M2SDIR)/example.conf
	txt2plain.pl < $< >$@

