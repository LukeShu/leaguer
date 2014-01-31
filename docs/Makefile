docs = ProductBacklog ProjectCharter ProjectLeaguerWorkloadBreakup

pdf: $(addsuffix .pdf,$(docs))
html: $(addsuffix .html,$(docs))

%.pdf: %.md Makefile
	pandoc -s $< -o $@
%.html: %.md Makefile
	pandoc -s $< -o $@
%.png: %.dot Makefile
	dot -Tpng < $< > $@

ProductBacklog.pdf: SystemModel.png
SystemModel.png: stickman.png

clean:
	rm -f -- *.pdf *.html
