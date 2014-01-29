docs = ProductBacklog ProjectCharter ProjectLeaguerWorkloadBreakup

pdf: $(addsuffix .pdf,$(docs))
html: $(addsuffix .html,$(docs))

%.pdf: %.md Makefile
	pandoc -s $< -o $@
%.html: %.md Makefile
	pandoc -s $< -o $@

ProductBacklog.pdf: Diagram01.jpg

clean:
	rm -f -- *.pdf *.html
