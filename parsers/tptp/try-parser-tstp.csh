#!/bin/csh -f

if ($#argv != 2) then
	echo Usage: $0 TSTPdir parser'    (over)writes try-tstp.out'
	echo '    e.g.' $0 ' TSTP tptp-yl-parser'
	exit $#argv
	endif

set dir = $1
set parsecsh = /projects/algo/Sat/TPTP/Syntax/Linux/try-parser-tstp1.csh
echo -n '' > try-tstp.out

foreach d ($dir/Solutions/*)
    if (! -d $d) then
		echo 'WARNING: Expected dir; found' $d >>& try-tstp.out
		continue
		endif

    foreach dd ($d/*)
	if (! -d $dd) then
			echo 'WARNING: Expected dir; found' $dd >>& try-tstp.out
			continue
			endif


	foreach f ($dd/*)
		if (! -f $f) then
			echo 'WARNING: Expected file; found' $f >>& try-tstp.out
			continue
			endif

		set soln = `egrep '%----TSTP SOLUTION' $f | wc -l`
		if ($soln == 0) continue

		set known1 = `egrep ' *inference\(,' $f | wc -l`
		if ($known1 > 0) echo  $f ' known error 1' >>& try-tstp.out
		if ($known1 > 0) continue

		set known2 = `egrep '^[^%].*[ (][$][^$]' $f | egrep -v '[$](true|false)' | wc -l`
		if ($known2 > 0) echo  $f ' known error 2' >>& try-tstp.out
		if ($known2 > 0) continue

		set known3 = `egrep ' *cnf\(,' $f | wc -l`
		if ($known3 > 0) echo  $f ' known error 3' >>& try-tstp.out
		if ($known3 > 0) continue

		$parsecsh $2 $f >>& try-tstp.out
		end
	end
    end

