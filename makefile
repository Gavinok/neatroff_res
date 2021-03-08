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

PRE = cat $< | $(SOIN) | \
		$(REFR) $(REFROPTS) | $(PIC) | $(TBL) | $(EQN)
# Target
ROFFEXT = ms
TARGETFORMAT = pdf
LAST=$(shell ls -t *.$(ROFFEXT) | head -1 | sed -e "s/\.$(ROFFEXT)//")
TARGET := $(addsuffix .$(TARGETFORMAT),$(basename $(LAST)))

# Errors
CLEANLINTERCMD = sed -e 's/\.clean//'
ERRORFILE=log.error

all: $(TARGET)
.SUFFIXES: .$(ROFFEXT) .tr .ps .pdf .PDF .html

lastpdf: $(LAST).pdf

last:
	@echo $(LAST).$(ROFFEXT)

.ps.pdf:
	@ps2pdf $(GSOPTS) $< $@

.$(ROFFEXT).ps:
	cat $< | $(PRE) | $(ROFF) $(ROFFOPTS) $(MACROS) 2>$(ERRORFILE) | $(POST) $(POSTOPTS) >$@
	@$(MAKE) -s checkerrors

tar:
	base=$(basename $PWD)
	tar -czf $(LAST).tar.gz .

checkerrors: $(ERRORFILE)
	@sed "s/<standard input>/$</g" $(ERRORFILE)
	@rm -f $(ERRORFILE)

%.clean: $(SRCS)
	deroff $< > $@


lint: $(SRCS).clean
	-grep -Hn "[−’]" $<  | $(CLEANLINTERCMD)
	writegood --parse $< | $(CLEANLINTERCMD)
	proselint $<         | $(CLEANLINTERCMD)
	diction --suggest --beginner $< | $(CLEANLINTERCMD)
	rm $<

clean:
	rm -f $(LAST).ps $(LAST).pdf

.PHONY: clean all lint test
