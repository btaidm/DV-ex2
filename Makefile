MD := $(patsubst %.jmd,%.md,$(wildcard *.jmd))
SLIDES := $(patsubst %.md,%.md.slides.pdf,$(MD))
HANDOUTS := $(patsubst %.md,%.md.handout.pdf,$(MD))

all : $(MD) $(SLIDES) $(HANDOUTS)

%.md : %.jmd header.yaml
	weave.jl $< --doctype "pandoc" --plotlib ":auto" --out_path ":pwd"
	mv $@ $@.tmp
	cat header.yaml $@.tmp > $@
	rm $@.tmp

%.md.slides.pdf : $(MD)
	pandoc $^ -t beamer --highlight-style kate --slide-level 2 -o $@

%.md.handout.pdf : $(MD)
	pandoc $^ -t beamer --highlight-style kate --slide-level 2 -V handout -o $@ 
	pdfnup $@ --nup 1x2 --no-landscape --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $*.md.handout-nup.pdf $@
		

clobber : 
	rm -f $(MD)
	rm -f $(SLIDES)
	rm -f $(HANDOUTS)
