# Neatroff settings
BASE = $(PWD)/..
ROFF = $(BASE)/neatroff/roff
POST = $(BASE)/neatpost/post
PPDF = $(BASE)/neatpost/pdf
EQN = $(BASE)/neateqn/eqn
REFR = $(BASE)/neatrefer/refer
PIC = $(BASE)/troff/pic/pic
TBL = $(BASE)/troff/tbl/tbl
SOIN = $(BASE)/soin/soin

ROFFOPTS = -F$(BASE) -M$(BASE)/tmac
MACROS = -mpost -mtbl -mkeep -msrefs -mgr -mfp
POSTOPTS = -F$(BASE) -pa4
REFROPTS = -m -e -o ct -p ref.bib
GSOPTS = -dPDFSETTINGS=/prepress -dEmbedAllFonts=true \
		-sPAPERSIZE=letter\
		-sFONTPATH=$(BASE)/fonts/ -sFONTMAP=$(BASE)/fonts/Fontmap 

PRE = $(SOIN) | \
		$(REFR) $(REFROPTS) | $(PIC) | $(TBL) | $(EQN)
# Target
ROFFEXT = ms
TARGETFORMAT = pdf

all: res.pdf
.SUFFIXES: .$(ROFFEXT) .tr .ps .pdf .PDF .html

.ps.pdf:
	@ps2pdf $(GSOPTS) $< $@

.$(ROFFEXT).ps:
	cat $< | $(PRE) | $(ROFF) $(ROFFOPTS) $(MACROS) | $(POST) $(POSTOPTS) >$@

.PHONY: deploy
deploy: res.pdf
	./deploy $< 

.PHONY: clean
clean:
	rm -f *.ps *.pdf
