#!/usr/bin/env bash

python3 maketrees.py
#for i in *.tex; do
#	xelatex $i;
#done;

find *.tex ! -name minimal.tex -exec xelatex {} \;

find *.pdf -exec inkscape {} -d 200 -D -e {}.png \;
find *.pdf -exec inkscape {} -D -l {}.svg \;
