#!/bin/csh -f

if ($#argv != 2) then
	echo Usage: $0 file_w_error parser
	exit $#argv
	endif

set LL = `cat $1 | wc -l`
while ($LL)
    head -$LL $1 | $2
    if ($status == 0) break
    @ LL = $LL - 1
    end
echo FILE OK THROUGH LINE $LL
