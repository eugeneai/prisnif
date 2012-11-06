.PHONY: all test clean all-rec
.PHONY: cleanall distrib distr distribution
.PHONY: test

MAINBRANCH=master

SRCS=answer.d misc.d pchunk.d proofnode.d question.d \
	symbol.d gterm.d parserhu.d prisnif.d qformulas.d supervisor.d

DFLAGS=-g

ROOT=$(PWD)

all:	prisnif all-rec

prisnif: $(SRCS)
	dmd $(DFLAGS) $^ -of$@

clean:
	rm *.o

cleanall: clean
	rm prisnif

distrib:
	git archive --format zip --output ../prisnif.zip $(MAINBRANCH)

distr: distrib

distribution: distrib

test:	prisnif
	./prisnif problems/john_boy 2000

all-rec:
	cd parsers/pcf/ && make
	cd parsers/tptp/ && make
