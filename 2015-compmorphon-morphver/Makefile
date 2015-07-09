all: qrcode.png poster.bbl poster.pdf

clean:
	touch poster.aux
	rm poster.aux

%.pdf: %.tex %.bbl Makefile
	xelatex $<

%.bbl: %.bib
	xelatex `echo $< | sed 's/bib/tex/'`
	biber `echo $< | sed 's/\.bib//'`

qrcode.png: Makefile
	qrencode -o qrcode.tmp.png -l M "http://wiki.apertium.org/wiki/Compmorphon_2015"
	convert qrcode.tmp.png $@

#bib:
#	bibtex poster


