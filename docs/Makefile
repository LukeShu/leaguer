docs = ProductBacklog ProjectCharter ProjectLeaguerWorkloadBreakup DesignDocument

pdf: $(addsuffix .pdf,$(docs))
html: $(addsuffix .html,$(docs))

%.pdf: %.md Makefile
	pandoc $($@.args) -s $< -o $@
%.html: %.md Makefile
	pandoc -s $< -o $@
%.png: %.dot Makefile
	dot -Tpng < $< > $@

ProductBacklog.pdf: SystemModel.png
SystemModel.png: stickman.png

DesignDocument.pdf: DesignDocument-classes.png
DesignDocument.pdf.args = --table-of-contents --number-sections -f markdown+definition_lists

clean:
	rm -f -- *.pdf *.html
