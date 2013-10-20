#!/bin/bash

pushd $APERTIUMPATH/languages/apertium-kum/dev/
	./countstems.sh
popd

pushd $APERTIUMPATH/languages/apertium-kaz/dev/
	./countstems.sh
popd

pushd $APERTIUMPATH/languages/apertium-kaz/dev/
	./countstems.sh
popd

