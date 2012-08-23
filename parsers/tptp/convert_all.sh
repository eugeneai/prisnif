#!/bin/bash

indir=tasks.in
outdir=tasks.out
tmp=tmp_ast.txt
pcf=../pcf
log="conversion.log"


q_tr="GLOBALSZ=150000 gprolog < tr_s.pl"


prg="./hotptp-yl-parser-verbose"

# Remove all old resulting files.

cd $outdir
rm *
cd - > /dev/null

# prune the log file

echo > $log

for file in $indir/*.p
do
    fb=$(basename $file)
    echo "Processing $fb."
    fo="$outdir/$fb"
    
    $prg < $file > $tmp
    if [ "$?" = "0" ]; then
	echo "Phase one is Ok $file" >> $log
    fi

    ln -sf $PWD/$tmp $pcf/input.pl

    cd $pcf
    ./tptp_tr.sh
    rc=$?
    cd - > /dev/null

    if [ "$rc" = "0" ]; then
	echo "Phase two is Ok $file" >> $log
	mv $pcf/result.p $fo
    fi

    rm -f $tmp $pcf/input.pl $pcf/result.p

done