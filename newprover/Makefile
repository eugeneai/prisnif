.PHONY: all test clean
.PHONY: cleanall distrib distr distribution
.PHONY: test

MAINBRANCH=master

SRCS=answer.d misc.d pchunk.d proofnode.d question.d \
	symbol.d gterm.d parserhu.d prisnif.d qformulas.d supervisor.d

DFLAGS=-g

all:	prisnif

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
	# Task about John the boy with a lot of fingers.
	./prisnif problems/john_boy 2000
