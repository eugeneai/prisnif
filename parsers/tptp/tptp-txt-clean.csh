#!/bin/csh -f

if ($#argv != 1) then
	echo Usage: $0 syntaxBNF-v3.1.1  ' > syntaxBNF-bnf.txt'
	exit $#argv
	endif

# Goal for this script is to replace spaces by underscores in grammar symbols
# (i.e., strings beginning with a letter and enclosed in < >); and
# to regularize spelling.  Also replace % by /* ... */ for comments.

setenv LANG C

cat $1 | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/<\([A-Za-z][^ >]*\) \([^>]*\)>/<\1_\2>/g' | \
sed -e 's/^%\(.*$\)/\/*\1 *\//' | \
sed -e 's/\*\/ *\*\//*\//' | \
sed -e 's/rest_of_\([^ ]*\)   /rest_\1      /g' | \
sed -e 's/rest_of_\([^ ]*\)/rest_\1/g' | \
sed -e 's/non-assoc/nonassoc/g' | \
cat
