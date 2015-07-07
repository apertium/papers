all: qrcode.png poster.pdf

clean:
	touch poster.aux
	rm poster.aux

%.pdf: %.tex Makefile
	xelatex $<

qrcode.png: Makefile
	qrencode -o $@ -l M "http://wiki.apertium.org/wiki/Compmorphon_2015"

#bib:
#	bibtex poster


