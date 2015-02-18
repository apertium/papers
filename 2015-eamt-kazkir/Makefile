all: 2015-eamt-kazkir 

2015-eamt-kazkir:
	xelatex -papersize a4 2015-eamt-kazkir.tex
	bibtex 2015-eamt-kazkir
	xelatex -papersize a4 2015-eamt-kazkir.tex
	xelatex -papersize a4 2015-eamt-kazkir.tex

clean:
	rm -rf 2015-eamt-kazkir.aux 2015-eamt-kazkir.bbl 2015-eamt-kazkir.blg 2015-eamt-kazkir.log 2015-eamt-kazkir.pdf

