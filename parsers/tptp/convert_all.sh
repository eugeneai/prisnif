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
TIME_OUT=20s

q_tr="GLOBALSZ=1500000 gprolog < tr_s.pl"

prg="./hotptp-yl-parser-verbose"

usage()
{
cat << EOF
usage: $0 options

This script converts some or all files in TPTP/TPTP/Problems/...
directories into tasks.out directory.

OPTIONS:
   -r      Remove ALL tasks in ./tasks.out before conversion.
   -o      Allow to overwrite old files. Else skip converstion if target file elready exists.
   -l      Prune log file at first.
   -h      This help message.

E.g. Convert all ..../TPTP/Problems/ALG/ALG*.p proglems:

$0 ALG/ALG

EOF
}

OVERWRITE=0

while getopts “:rpoh” OPTION;
do
     case $OPTION in
         r)
             #Remove old files from output directory
             cd $outdir
             rm *
             cd - > /dev/null
             ;;
         o)
             #Overwrite old target file.
             OVERWRITE=1
             echo "WARNING:Overwriting old target file."
             ;;
         h)
             usage
             exit
             ;;
         l)
             echo "Pruning the log file."
             #echo > $log
             ;;
         ?)
             echo "OTHER $OPTION"
             ;;
         :)
             echo "Oparg $OPTARG."
             ;;
     esac
done

shift $(( OPTIND-1 ))

# prune the log file and output file.

echo > $out

NPROC=0

for file in $indir/$1*.p
do
    TS=$(LC_ALL=C date)
    fb=$(basename $file)
    fo="$outdir/$fb"
    if [ $OVERWRITE -eq 0 ] && [ -e $fo ]
    then
        echo "Skipping $indir/$fb as it exists."
        continue
    fi
    echo "-----[$TS]--------------------------------------------------"
    echo "Processing $indir/$fb."
    cd $tptpdir

    sfb=$(basename $fb .p)
    pwd
    timeout $TIME_OUT ./$TPTP4X_PRG -x -d../../ ../../$file
    TPTP_RC=$?
    cd -

    if [ "$TPTP_RC" = "124" ]; then
	echo "[$TS] Phase one is NOT Ok $file. Time out." >> $log
	continue
    fi

    $prg < "$sfb.tptp" > $tmp
    if [ "$?" = "0" ]; then
	echo "[$TS] Phase one is Ok $file" >> $log
    else
	echo "[$TS] Phase one is NOT Ok $file" >> $log
	continue
    fi
    rm "$sfb.tptp"

    ln -sf $PWD/$tmp $pcf/input.pl

    cd $pcf
    ./tptp_tr.sh
    rc=$?
    cd - > /dev/null

    if [ "$rc" = "0" ]; then
	echo "[$TS] Phase two is Ok $file" >> $log
	mv -f $pcf/result.p $fo
	echo "[$TS]"
        echo "Soure file: $file" >> $out
	echo "----------------------------------" >> $out
	cat $pcf/gram_test.out >> $out
	echo "[$TS]==================================" >> $out
    fi

    # rm -f $tmp $pcf/input.pl $pcf/result.p

done
