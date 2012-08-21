.PHONY: all hotptp tptp tptp23 test
LANG=C
all: hotptp tptp

hotptp:
	PATH=./:$(PATH) tptp-txt-all.csh hotptp-bnf2.txt
	lex -l hotptp-1.lex0
	yacc -d -v hotptp-1.y
	gcc -g -o hotptp-yl-parser lex.yy.c y.tab.c terr.c
	#gcc -g -o hotptp-yl-parser lex.yy.c y.tab.c -ly -ll
	#gcc -g -DP_VERBOSE=1 -DP_USERPROC -o hotptp-yl-parser-verbose lex.yy.c y.tab.c terr.c

tptp:
	PATH=./:$(PATH) tptp-txt-all.csh syntaxBNF2-3.1.1.13d.txt
	lex -l syntaxBNF2-1.lex0
	yacc -d -v syntaxBNF2-1.y
	cp -p syntaxBNF2-1.lex0 syntaxBNF2-3.1.1.13d.lex0
	cp -p syntaxBNF2-1.y syntaxBNF2-3.1.1.13d.y
	#gcc -g -o tptp-yl-parser lex.yy.c y.tab.c -ly -ll
	gcc -g -o tptp-yl-parser lex.yy.c y.tab.c terr.c
	#gcc -g -DP_VERBOSE=1 -DP_USERPROC  -o tptp-yl-parser-verbose lex.yy.c y.tab.c terr.c

tptp23:
	PATH=./:$(PATH) tptp-txt-all.csh syntaxBNF2-3.1.1.23.txt
	lex -l syntaxBNF2-1.lex0
	yacc -d -v syntaxBNF2-1.y
	cp -p syntaxBNF2-1.lex0 syntaxBNF2-3.1.1.23.lex0
	cp -p syntaxBNF2-1.y syntaxBNF2-3.1.1.23.y
	#gcc -g -o tptp23-parser lex.yy.c y.tab.c -ly -ll
	gcc -g -o tptp23-parser lex.yy.c y.tab.c terr.c
	#gcc -g -DP_VERBOSE=1 -DP_USERPROC  -o tptp23-parser-verbose lex.yy.c y.tab.c terr.c


test: all
	./hotptp-yl-parser-verbose < KRS064+1.p > _.pl
