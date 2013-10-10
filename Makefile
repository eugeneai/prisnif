.PHONY: all test clean all-rec
.PHONY: cleanall distrib distr distribution
.PHONY: test

DCOMPILER=ldc2

MAINBRANCH=master

SRCS= answer.d gterm.d misc.d parserhu.d pchunk.d prisnif.d proofnode.d qformulas.d question.d supervisor.d symbol.d


DFLAGS=-gc

ROOT=$(PWD)

all:	prisnif all-rec

prisnif: $(SRCS)
	$(DCOMPILER) $(DFLAGS) $^ -of$@

clean:
	rm *.o

cleanall: clean
	rm prisnif

distrib:
	git archive --format zip --output ../prisnif.zip $(MAINBRANCH)

distr: distrib

distribution: distrib

test:	prisnif
	# Task about John the boy with a lot of fingers.
	./prisnif problems/john_boy 2000 r

all-rec:
	cd parsers/pcf/ && make
	cd parsers/tptp/ && make
