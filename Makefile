MAKEFLAGS += --no-print-directory
MARKDOWN=pandoc -f gfm

MAINPARTS= doctype.t body.t footer.t setup.t daniel.t
ACTION=@echo fixing $@; \
       fcpp -WWW -Uunix -H -C -V -LL $(NOW) $(TODAY) $< $@

TODAY=$(shell date +'-D__TODAY__="%B %e, %Y"')
NOW=$(shell date +'-D__NOW__="%H:%M"')

all:	index.html skills.html myopensource.html opensource.html \
	hackers.html about.html \
	datateknik.html no_more_download_sites.html \
	computers.html source.html bredband.html transition.html \
	irchistory.html address.html old.html now.html m3.html \
	rockbox-sandisk-connection.html mynextassignment.html \
	podcasts.html photos.html weekly.html talks.html index2.html \
	us-visa.html how-to-invite-me.html photos2.html \
	my-name-in-products.html
	cd old-photos; make
	cd hexpoetry; make
	cd projects; make
	cd hus; make
	cd docs && make
	cd videos && make
	cd http2 && make
	cd devcons && make
	cd uncurled && make

index.html: index.t $(MAINPARTS) talk.inc
	$(ACTION)

my-name-in-products.html: my-name-in-products.t $(MAINPARTS)
	$(ACTION)

about.html: about.t $(MAINPARTS) about.gen
	$(ACTION)
about.gen: about.md
	$(MARKDOWN) < $< >$@

index2.html: index2.t $(MAINPARTS) talk.inc
	$(ACTION)

address.html: address.t $(MAINPARTS)
	$(ACTION)

photos.html: photos.t $(MAINPARTS)
	$(ACTION)

photos2.html: photos2.t $(MAINPARTS)
	$(ACTION)

old.html: old.t $(MAINPARTS)
	$(ACTION)

now.html: now.t $(MAINPARTS)
	$(ACTION)

podcasts.html: podcasts.t $(MAINPARTS)
	$(ACTION)

m3.html: m3.t $(MAINPARTS)
	$(ACTION)

transition.html: transition.t $(MAINPARTS)
	$(ACTION)

irchistory.gen: docs/irchistory/README.md
	$(MARKDOWN) < $< >$@
irchistory.html: irchistory.t $(MAINPARTS) irchistory.gen
	$(ACTION)

skills.html: skills.t $(MAINPARTS)
	$(ACTION)

no_more_download_sites.html: no_more_download_sites.t $(MAINPARTS)
	$(ACTION)

myopensource.html: myopensource.t $(MAINPARTS)
	$(ACTION)

opensource.html: opensource.t $(MAINPARTS)
	$(ACTION)

hackers.html: hackers.t $(MAINPARTS)
	$(ACTION)

datateknik.html: datateknik.t $(MAINPARTS)
	$(ACTION)

computers.html: computers.t $(MAINPARTS)
	$(ACTION)

source.html: source.t $(MAINPARTS)
	$(ACTION)

bredband.html: bredband.t $(MAINPARTS)
	$(ACTION)

weekly-last.t: weekly-episodes.txt Makefile
	tail -1 weekly-episodes.txt | awk '{ printf("#define WEEKLY_LAST %s\n#define WEEKLY_LAST_SRC \"//www.youtube.com/embed/%s\"\n#define WEEKLY_LAST_NUM %d\n",$$1, $$1, $$2); }' > weekly-last.t

weekly-list.t: weekly-episodes.txt weekly-list.pl 
	perl weekly-list.pl > weekly-list.t

weekly.html: weekly.t $(MAINPARTS) weekly-list.t weekly-last.t
	$(ACTION)

talks.html: talks.t $(MAINPARTS) talk.inc
	$(ACTION)

how-to-invite-me.html: how-to-invite-me.t $(MAINPARTS)
	$(ACTION)

mynextassignment.html: mynextassignment.t $(MAINPARTS)
	$(ACTION)

the-community-wants-or-should.html: the-community-wants-or-should.t  $(MAINPARTS)
	$(ACTION)

rockbox-sandisk-connection.html: rockbox-sandisk-connection.t $(MAINPARTS) sansa/topmenu.t
	$(ACTION)

us-visa.html: us-visa.t $(MAINPARTS)
	$(ACTION)

clean:
	find . -name "*~" -exec rm {} \;
