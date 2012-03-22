#!/bin/csh -f

if ($#argv != 2) then
	echo Usage: $0 tptp-yl-parser tptp-input-file
	exit $#argv
	endif

echo -n $2 " "
/projects/algo/Sat/TPTP/Syntax/Linux/$1 < $2 >& $$.out
if ($status == 0) echo ''
head $$.out
rm $$.out
