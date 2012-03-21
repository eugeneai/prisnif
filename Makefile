.PHONY: all test clean

SRCS=answer.d misc.d pchunk.d proofnode.d question.d \
	symbol.d gterm.d parserhu.d prisnif.d qformulas.d supervisor.d

all:	prisnif

prisnif: $(SRCS)
	dmd $^ -of$@

clean:
	rm *.o
