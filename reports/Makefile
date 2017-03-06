# 
# Arya D. McCarthy
# Based on https://drewsilcock.co.uk/using-make-and-latexmk
#
LATEX=pdflatex
LATEXOPT=--shell-escape -synctex=1
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf -quiet -bibtex -use-make
CONTINUOUS=-pvc

MAIN=McCarthy-thesis
SOURCES=$(MAIN).tex FrontPages.tex abstract.tex acknow.tex app.tex customcommands.tex introduction.tex packages.tex results.tex symbols.tex thesisbib.bib
FIGURES := $(shell find fig/* -type f)

all:    $(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
		$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
			-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
		touch .refresh
		rm $(MAIN).pdf
		$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
			-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
		$(LATEXMK) -C -bibtex $(MAIN)
		rm -f $(MAIN).pdfsync
		rm -rf *~ *.tmp
		rm -f *.bbl *.brf *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
		$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
		$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all debug
.PRECIOUS: $(MAIN).pdf

