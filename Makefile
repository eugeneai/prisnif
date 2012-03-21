.PHONY: all test clean 
.PHONY: cleanall distrib distr distribution

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


