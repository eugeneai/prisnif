.PHONY: all test clean all-rec
.PHONY: cleanall distrib distr distribution
.PHONY: test lib

DCOMPILER=dmd

MAINBRANCH=master

SRCS= answer.d gterm.d misc.d parserhu.d pchunk.d prisnif.d proofnode.d qformulas.d question.d supervisor.d symbol.d
MAIN_SRC = main.d


DFLAGS=-gc -property

ROOT=$(PWD)

all:	prisnif all-rec
lib:	libprisnif.a

prisnif: $(MAIN_SRC) libprisnif.a
	$(DCOMPILER) $(DFLAGS) $^ -of$@

libprisnif.a: $(SRCS)
	$(DCOMPILER) $(DFLAGS) -lib $^ -of$@

clean:
	rm -f *.o

cleanall: clean
	rm -f prisnif

distrib:
	git archive --format zip --output ../prisnif.zip $(MAINBRANCH)

distr: distrib

distribution: distrib

test:	prisnif
	# Task about John the boy with a lot of fingers.
	echo "-- Breadt-first test------------------------------------"
	./prisnif problems/john_boy 15 w
	#echo "-- Depth-first test ------------------------------------"
	#./prisnif problems/john_boy 70 q
	#./prisnif problems/john_boy 2000 r
	echo "--------------------------------------------------------"

all-rec:
	cd parsers/pcf/ && make
	cd parsers/tptp/ && make
