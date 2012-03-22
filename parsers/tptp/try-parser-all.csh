#!/bin/csh -f

if ($#argv != 2) then
	echo Usage: $0 TPTPdir parser'    (over)writes try-all.out'
	echo '    e.g.' $0 ' TPTP-v3.1.1 tptp-yl-parser'
	exit $#argv
	endif

set dir = $1
set parsecsh = /projects/algo/Sat/TPTP/Syntax/Linux/try-parser.csh
echo -n '' > try-all.out

foreach d ($dir/Problems/*)
	if (! -d $d) then
		echo 'WARNING: Expected dir; found' $d >>& try-all.out
		continue
		endif

	foreach f ($d/*)
		if (! -f $f) then
			echo 'WARNING: Expected file; found' $f >>& try-all.out
			continue
			endif

		$parsecsh $2 $f >>& try-all.out
		end
	end

