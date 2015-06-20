all: paper.pdf

paper.pdf: paper.tex paper.bbl
	xelatex paper

paper.bbl: paper.bib
	xelatex paper
	bibtex paper
