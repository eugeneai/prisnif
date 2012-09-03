#!/bin/bash

LATEX="/usr/bin/latex"
DVIPS="/usr/bin/dvips"
GS="/usr/bin/gs"
BIBTEX="/usr/bin/bibtex"

$LATEX dis.tex && $LATEX dis.tex && $DVIPS -O-1in,-1in dis.dvi && ps2pdf dis.ps 
#$LATEX dis.tex && $BIBTEX dis.aux && $LATEX dis.tex && $LATEX dis.tex && $DVIPS dis.dvi -t a4 -O -1in,-1in && ps2pdf dis.ps && xdg-open ./dis.pdf 2> /dev/null
rm -f *.log *.out *.aux *.toc *.dvi *.bbl *.blg *-blx.bib
