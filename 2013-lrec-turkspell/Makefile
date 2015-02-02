## Use make to create article pdfs or recreate test results

# {{{ program path settings
TEX=xelatex
BIB=bibtex
SCP=scp
SCPHOST=ruuvi
SCPDIR=public_html/tmp/
WGET=wget
BZCAT=bzcat
SED=sed
AWK=awk
WIKICLEAN=./wikipedia-deform.sh
HFST_COMPOSE=hfst-compose
HFST_CONCATENATE=hfst-concatenate
HFST_FST2FST=hfst-fst2fst
HFST_INVERT=hfst-invert
HFST_MINIMIZE=hfst-minimize
HFST_REGEXP2FST=hfst-regexp2fst
HFST_REPEAT=hfst-repeat
HFST_REWEIGHT=hfst-reweight
HFST_STRINGS2FST=hfst-strings2fst
HFST_TXT2FST=hfst-txt2fst
HFST_UNION=hfst-disjunct
HFST_PROC=hfst-proc
HFST_OSPELL=hfst-ospell-survey
HFST_LOOKUP=hfst-lookup
PYTHON2=python2
PYTHON3=python3
EDITDIST=editdist.py
ASPELL=aspell
HUNSPELL=hunspell
# use GNU time rather than bash builtin
TIME=/usr/bin/time

# }}}

all: paper results

clean: clean-spellers clean-article clean-results

#
# {{{ latex building stuff
PAPER_SOURCES=turk-spell-lrec2013.tex
PAPER_AUXES=turk-spell-lrec2013.aux turk-spell-lrec2013.bbl turk-spell-lrec2013.log turk-spell-lrec2013.blg
PAPER_PDF=turk-spell-lrec2013.pdf
GRAPHICX=
DOTS=

DOCS=README LICENCE

paper: turk-spell-lrec2013.pdf

turk-spell-lrec2013.pdf: turk-spell-lrec2013.tex turkspell.bib $(GRAPHICX)
	$(TEX) turk-spell-lrec2013.tex
	$(BIB) turk-spell-lrec2013
	$(TEX) turk-spell-lrec2013.tex
	$(TEX) turk-spell-lrec2013.tex
	$(TEX) turk-spell-lrec2013.tex

clean-article:
	-rm -f $(PAPER_PDF) $(PAPER_AUXES)


dots/%.dot: hfst/und/%.hfst
	hfst-fst2txt -v -f dot -i $< -o $@

graphicx/%.pdf: dots/%.dot
	dot -Tpdf -o$@ $<

# }}}
#
# {{{ language settings all
PROFILE_FOR_EXPR=1 2 3 4 5

TEST_CORPUS_HUGE=100000000
TEST_CORPUS_LARGE=1000000
TEST_CORPUS_SMALL=10000
TEST_CORPUS_TINY=100

APERTIUM_LANGS=languages/
TARGET_LANGS=bak chv  kaz tat kir uzb
# }}}

# {{{ speller building
spellersloop:
	for ll in $(TARGET_LANGS) ; do \
		$(MAKE) spellers/speller-$$ll.zhfst ; \
	done

spellers/speller-%.zhfst: $(APERTIUM_LANGS)/apertium-%
	cd $< && ./autogen.sh && ./configure --enable-ospell && make
	cp -v -f $</$*.zhfst $@

clean-spellers:
	-rm -f spellers/*.zhfst
# }}}

# {{{ external spellers fetching
HUNSPELL_KAZ=http://ftp.fi.debian.org/debian/pool/main/h/hunspell-kk/hunspell-kk_1.1-2_all.deb
# http://packages.debian.org/sid/hunspell-kk
HUNSPELL_TAT=http://hlt.sztaki.hu/resources/hunspell/Tatar/hunspell-tt-20080617.tar
HUNSPELL_CHV=http://hunspell.chv.su/files/dict-cv-1.02-u.oxt
HUNSPELL_KIR=http://ftp.gnu.org/gnu/aspell/dict/ky/aspell6-ky-0.01-0.tar.bz2
HUNSPELL_UZB=http://ftp.de.debian.org/debian/pool/main/u/uzbek-wordlist/hunspell-uz_0.6-3.2_all.deb

hunspell-kk_1.1-2_all.deb:
	wget $(HUNSPELL_KAZ)

hunspell-tt-20080617.tar:
	wget $(HUNSPELL_TAT)

dict-cv-1.02-u.oxt:
	wget $(HUNSPELL_CHV)

aspell6-ky-0.01-0.tar.bz2:
	wget $(HUNSPELL_KIR)

hunspell-uz_0.6-3.2_all.deb:
	wget $(HUNSPELL_UZB)


spellers/kk_KZ.dic: hunspell-kk_1.1-2_all.deb
	dpkg -x $< hunspell-kk
	mv -v -f hunspell-kk/usr/share/hunspell/kk_KZ.* spellers/

spellers/uz_UZ.dic: hunspell-uz_0.6-3.2_all.deb
	dpkg -x $< hunspell-uz
	mv -v -f hunspell-uz/usr/share/hunspell/uz_UZ.* spellers/


spellers/tt_RU.dic: hunspell-tt-20080617.tar
	tar xvf $<
	mv -v -f hunspell-tt-20080617/* spellers/

spellers/cv_RU.dic: dict-cv-1.02-u.oxt
	unzip $<
	mv -v -f cv_RU.* spellers/

spellers/ky_KG.dic: aspell6-ky-0.01-0.tar.bz2
	tar xjf $<
	rm -f aspell6-ky-0.01-0/ky.wl
	preunzip aspell6-ky-0.01-0/ky.cwl
	wc -l < aspell6-ky-0.01-0/ky.wl > spellers/ky_KG.dic
	cat aspell6-ky-0.01-0/ky.wl >> spellers/ky_KG.dic
	cp aspell6-ky-0.01-0/ky_affix.dat spellers/ky_KG.aff
	
	

# }}}

# {{{ speller applying

results: kaz.results tat.results chv.results kir.results uzb.results

kaz.hunspells: errors/kaz.txt
	cd spellers && hunspell -d kk_KZ -1 < ../$< > ../$@

tat.hunspells: errors/tat.txt
	cd spellers && hunspell -d tt_RU -1 < ../$< > ../$@

chv.hunspells: errors/chv.txt
	cd spellers && hunspell -d cv_RU -1 < ../$< > ../$@

kir.hunspells: errors/kir.txt
	cd spellers && hunspell -d ky_KG -1 < ../$< > ../$@

uzb.hunspells: errors/uzb.txt
	cd spellers && hunspell -d uz_UZ -1 < ../$< > ../$@

kaz.ospells: errors/kaz.txt
	hfst-ospell-lrec2013 spellers/speller-kaz.zhfst -X kaz.stats -P kaz.profiles -H kaz.hist < $< > $@

tat.ospells: errors/tat.txt
	hfst-ospell-lrec2013 spellers/speller-tat.zhfst -X tat.stats -P tat.profiles -H tat.hist < $< > $@

chv.ospells: errors/chv.txt
	hfst-ospell-lrec2013 spellers/speller-chv.zhfst -X chv.stats -P chv.profiles -H chv.hist < $< > $@

kir.ospells: errors/kir.txt
	hfst-ospell-lrec2013 spellers/speller-kir.zhfst -X kir.stats -P kir.profiles -H kir.hist < $< > $@

uzb.ospells: errors/uzb.txt
	hfst-ospell-lrec2013 spellers/speller-uzb.zhfst -X uzb.stats -P uzb.profiles -H uzb.hist < $< > $@

%.results: %.ospells %.hunspells
	echo "HUNSPELL $*" > $@
	tail -n +2 $*.hunspells |\
		tr -s '\n' |\
		paste - errors/$*.txt |\
		$(AWK) -f hunspells2results.awk >> $@
	echo "OSPELL $*" >> $@
	cat $*.stats >> $@

clean-results:
	-rm -f *.results *.ospells *.hunspells

# }}}

# vim: set foldmethod=marker:
