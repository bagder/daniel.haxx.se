PAGES = index.html

ACTION=@echo fixing $@; \
       fcpp -WWW -Uunix -H -C -V -LL -I.. $< $@

MAINPARTS= ../doctype.t ../body.t ../footer.t ../setup.t ../daniel.t

all: $(PAGES)

clean:
	rm -f $(PAGES) *.gen

index.html: index.t $(MAINPARTS) videos.gen
	$(ACTION)

videos.gen: videolist.txt mkvideos.pl
	perl ./mkvideos.pl < $< > $@
