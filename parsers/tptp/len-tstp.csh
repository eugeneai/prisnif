#!/bin/csh -f

if ($#argv != 2) then
	echo Usage: $0 TSTPdir solver'    writes len-solver-tstp.out'
	echo '    e.g.' $0 ' TSTP EP---0.91'
	echo '    e.g.' $0 ' TSTP Paradox---1.3'
	exit $#argv
	endif

set dir = $1
set solver = $2
set outf = len-${2}-tstp.out

echo -n '' > $outf

foreach d ($dir/Solutions/*)
    if (! -d $d) then
		echo 'WARNING: Expected dir; found' $d >>& $outf
		continue
		endif

    foreach dd ($d/*)
	if (! -d $dd) then
			echo 'WARNING: Expected dir; found' $dd >>& $outf
			continue
			endif


	foreach f ($dd/*${solver}*)
		if (! -f $f) then
			echo 'WARNING: Expected file; found' $f >>& $outf
			continue
			endif

		set soln = `egrep '%----TSTP SOLUTION' $f | wc -l`
		if ($solver == Paradox---1.3) set soln = 1
		if ($soln == 0) continue

		if ($solver == EP---0.91) then
		  echo -n $f ' ' >>& $outf
		  awk '/Proof object starts/{go=1;next;}/Proof object ends/{go=0;next;}go==1{s++;next;}END{print s;}' $f >>& $outf
		  endif

		if ($solver == Paradox---1.3) then
		  echo -n $f ' ' >>& $outf
		  awk '/== Model/{go=1;next;}/== Result/{go=0;next;}/% *$/{next;}go==1{s++;next;}END{print s;}' $f >>& $outf
		  endif

		end
	end
    end

