#!/bin/csh -f

if ($#argv != 1) then
	echo Usage: $0 hotptp-bnf.txt '   ... or' syntaxBNF-3.1.1.13.txt
	exit $#argv
	endif

setenv LANG C
set inr = $1:r
set inrr = `echo $inr | sed 's/-[^-]*$//' `

tptp-txt-clean.csh $1 > $inrr-clean.txt
tptp-trans.csh $inrr-clean.txt > $inrr-1.txt
tptp-lex.csh $inrr-1.txt
tptp-y0.csh $inrr-1.txt $inrr-1.lex0
tptp-y.csh $inrr-1.y0
mv $inrr-1.y $inrr-1.y1
tptp-y1.awksh $inrr-1.y1 > $inrr-1.y

