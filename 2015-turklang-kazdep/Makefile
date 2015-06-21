all: paper.pdf

paper.pdf: paper.tex paper.bbl
	xelatex paper
	xelatex paper

paper.bbl: paper.bib
	xelatex paper
	#bibtex8 --wolfgang paper
	biber paper

clean:
	rm *.out *.aux *.bbl *.pdf
