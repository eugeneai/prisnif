#!/bin/bash

# test string

tptpdir=TPTP/TPTP
indir="$tptpdir/Problems"
outdir=tasks.out
pcf=../pcf

tmp=tmp_ast.txt
log="conversion.log"
out="conv_out.txt"

TPTP4X_PRG="Scripts/tptp4X"
TPTP4X="$tptpdir/$TPTP4X_PRG"

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

PRESERVE=1

while getopts “:rph” OPTION;
do
     case $OPTION in
         r)
             #Remove old files from output directory
             cd $outdir
             rm *
             cd - > /dev/null

             ;;
         p)
             #Skip conversion if target file exists.
             PRESERVE=0
             echo "Do not preserve existing files."
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

NPROC=0

for file in $indir/$1*.p
do
    TS=$(LC_ALL=C date)
    fb=$(basename $file)
    fo="$outdir/$fb"
    if [ $PRESERVE -eq 1 ] && [ -e $fo ]
    then
        echo "Skipping $indir/$fb as it exists."
        continue
    fi
    echo "-----[$TS]--------------------------------------------------"
    echo "Processing $indir/$fb."
    cd $tptpdir

    sfb=$(basename $fb .p)
    pwd
    ./$TPTP4X_PRG -x -d../../ ../../$file
    cd -

    $prg < "$sfb.tptp" > $tmp
    rm "$sfb.tptp"
    if [ "$?" = "0" ]; then
	echo "[$TS] Phase one is Ok $file" >> $log
    else
	echo "[$TS] Phase one is NOT Ok $file" >> $log
	continue
    fi

    ln -sf $PWD/$tmp $pcf/input.pl

    cd $pcf
    ./tptp_tr.sh
    rc=$?
    cd - > /dev/null

    if [ "$rc" = "0" ]; then
	echo "[$TS] Phase two is Ok $file" >> $log
	mv $pcf/result.p $fo
	echo "[$TS]"
        echo "Soure file: $file" >> $out
	echo "----------------------------------" >> $out
	cat $pcf/gram_test.out >> $out
	echo "[$TS]==================================" >> $out
    fi

    # rm -f $tmp $pcf/input.pl $pcf/result.p

done
