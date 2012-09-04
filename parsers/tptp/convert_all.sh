#!/bin/bash

indir=TPTP/TPTP/Problems
outdir=tasks.out
tmp=tmp_ast.txt
pcf=../pcf
log="conversion.log"
out="conv_out.txt"

q_tr="GLOBALSZ=1500000 gprolog < tr_s.pl"

prg="./hotptp-yl-parser-verbose"

usage()
{
cat << EOF
usage: $0 options

This script converts som or all files in TPTP/TPTP/Problems/...
directories into tasks.out directory.

OPTIONS:
   -e      Remove old tasks in tasks.out.
   -h      This help message.
EOF
}

while getopts “r” OPTION
do
     case $OPTION in
         r)
             #Remove old files from output directory
             cd $outdir
             rm *
             cd - > /dev/null

             ;;
         h)
             usage
             exit
             ;;
     esac
done

# prune the log file and output file.

echo > $log
echo > $out

for file in $indir/$1*+*.*
do
    fb=$(basename $file)
    echo "Processing $indir/$fb."
    fo="$outdir/$fb"

    $prg < $file > $tmp
    if [ "$?" = "0" ]; then
	echo "Phase one is Ok $file" >> $log
    else
	echo "Phase one is NOT Ok $file" >> $log
	continue
    fi

    ln -sf $PWD/$tmp $pcf/input.pl

    cd $pcf
    ./tptp_tr.sh
    rc=$?
    cd - > /dev/null

    if [ "$rc" = "0" ]; then
	echo "Phase two is Ok $file" >> $log
	mv $pcf/result.p $fo
	echo "Soure file: $file" >> $out
	echo "----------------------------------" >> $out
	cat $pcf/gram_test.out >> $out
	echo "==================================" >> $out
    fi

    # rm -f $tmp $pcf/input.pl $pcf/result.p

done
