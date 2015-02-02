#!/bin/bash

pushd $APERTIUMPATH/languages/apertium-kum/dev/
	hfst-lexc --format foma ../apertium-kum.kum.lexc -o /dev/null
	./countstems.sh
popd

pushd $APERTIUMPATH/languages/apertium-kaz/dev/
	hfst-lexc --format foma ../apertium-kaz.kaz.lexc -o /dev/null
	./countstems.sh
popd

pushd $APERTIUMPATH/languages/apertium-tat/dev/
	hfst-lexc --format foma ../apertium-tat.tat.lexc -o /dev/null
	./countstems.sh
popd

