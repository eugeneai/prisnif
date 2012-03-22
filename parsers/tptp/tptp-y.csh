#!/bin/csh -f

# Goal for this script is to change rules with * to recursive,
# and do final formating for yacc.

if ($#argv != 1) then
	echo Usage: $0 tptp-1.y0 '   creates tptp-1.y'
	exit $#argv
	endif

setenv LANG C
set inr = $1:r
set outy = $inr.y


cat $1 | \
awk '$NF=="*"{star=1;r1=$1;rr=$(NF-1);r3=$3;rf=r3;for(i=4;i<=NF-2;i++){rf=rf " " $i};next;} star==1{if($1!=rr){print "/*WARNING:",rr,"THEN",$1,"*/";print;}else{printf "%-19s _GRR ",r1; print rf, "|", r3, $3, r1;star="";}next;} {print;}' | \
sed -e '/^[^/].* _GRR/s/$/ {P_ACT($<sval>$)} ;/'  -e '/^[^/].* _GRR/s/[|]/{P_ACT($<sval>$)} |/g' -e '/^[^/]/s/ _GRR/ :/' | \
awk '/^\/\*/{print;next;} /^[A-za-z0-9_]*[ \t]*:/{gsub(" [|]","\n                    |");gsub(" ;$","\n                    ;\n");print;next;} {print;next;}' | \
cat > $outy
