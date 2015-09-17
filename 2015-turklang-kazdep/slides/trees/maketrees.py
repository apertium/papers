#!/usr/bin/env python3

import glob, os

with open('minimal.tex', 'r') as templateFile:
	template = templateFile.read()

for fn in glob.glob("*.dat"):
	graphname=fn.replace(".dat", "")
	with open(fn, 'r') as graphFile:
		contents = graphFile.read()
	output = template.replace("¶", contents)
	with open(graphname+".tex", 'w') as outFile:
		outFile.write(output)

#print(a)

#replacementPlace = re.compile("¶")
#x = replacementPlace.sub(a, template)

#with open('
#
#print(x)
