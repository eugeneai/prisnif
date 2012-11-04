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
   -z      Archive output file with bzip2.
   -h      This help message.

E.g. Convert all ..../TPTP/Problems/ALG/ALG*.p proglems:

$0 ALG/ALG

EOF
}

OVERWRITE=0
ZIP=0

while getopts “:rpohz” OPTION;
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
         z)
             echo "Ok. Ok. We will zip the ouput file."
             ZIP=1
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
    foz="$fo.bz2"
    if [ $OVERWRITE -eq 0 ] && [ -e $fo ]
    then
        echo "Skipping $indir/$fb as its resulting file exists."
        continue
    fi
    if [ $OVERWRITE -eq 0 ] && [ -e $foz ]
    then
        echo "Skipping $indir/$fb as its bzipped resulting file exists."
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
        rm -f "$sfb.tptp"
	continue
    fi

    $prg < "$sfb.tptp" > $tmp
    if [ "$?" = "0" ]; then
	echo "[$TS] Phase one is Ok $file" >> $log
    else
	echo "[$TS] Phase one is NOT Ok $file" >> $log
        rm -f "$sfb.tptp"
	continue
    fi

    # remove tptp joint file after translation.
    rm -f "$sfb.tptp"

    ln -sf $PWD/$tmp $pcf/input.pl

    cd $pcf
    # ./tptp_tr.sh
    ./tptp_tr_gpro.sh
    rc=$?
    cd - > /dev/null

    if [ "$rc" = "0" ]; then
	echo "[$TS] Phase two is Ok $file" >> $log
	mv -f $pcf/result.p $fo

        if [ $ZIP -eq 1 ]
        then
            echo "Bzipping $indir/$fo."
            bzip2 $fo
        fi
	echo "[$TS]"
        echo "Soure file: $file" >> $out
	echo "----------------------------------" >> $out
	cat $pcf/gram_test.out >> $out
	echo "[$TS]==================================" >> $out
    fi

    # rm -f $tmp $pcf/input.pl $pcf/result.p

done
