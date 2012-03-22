all: hotptp tptp

hotptp:
	tptp-txt-all.csh hotptp-bnf.txt
	lex -l hotptp-1.lex0
	yacc -d -v hotptp-1.y
	gcc -g -o hotptp-yl-parser lex.yy.c y.tab.c -ly -ll
	gcc -g -DP_VERBOSE=1 -o hotptp-yl-parser-verbose lex.yy.c y.tab.c -ly -ll

tptp:
	tptp-txt-all.csh syntaxBNF-3.1.1.13b.txt
	lex -l syntaxBNF-1.lex0
	yacc -d -v syntaxBNF-1.y
	gcc -g -o tptp-yl-parser lex.yy.c y.tab.c -ly -ll
	gcc -g -DP_VERBOSE=1 -o tptp-yl-parser-verbose lex.yy.c y.tab.c -ly -ll

