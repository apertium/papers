all: paper.pdf

paper.pdf: paper.tex paper.bbl
	xelatex paper
	bibtex paper
	xelatex paper

paper.bbl: paper.bib
	bibtex paper
