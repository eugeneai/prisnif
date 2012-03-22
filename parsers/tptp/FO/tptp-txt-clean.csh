#!/bin/csh -f

if ($#argv != 1) then
	echo Usage: $0 syntaxBNF-v3.1.1  ' > syntaxBNF-bnf.txt'
	exit $#argv
	endif

cat $1 | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/^%\(.*$\)/\/*\1 *\//' | \
sed -e 's/\*\/ *\*\//*\//' | \
sed -e '/^%--/s/@/$$/g' | \
sed -e '/^<system_atom/s/predicate/proposition/' | \
sed -e 's/fol_formula/fof_formula/g' | \
sed -e 's/rest_of_\([^ ]*\)   /rest_\1      /g' | \
sed -e 's/rest_of_\([^ ]*\)/rest_\1/g' | \
cat
