all: clean poster bib poster poster

clean:
	touch *.tex
	touch poster.aux
	rm poster.aux

poster:
	xelatex poster.tex

bib:
	bibtex poster
