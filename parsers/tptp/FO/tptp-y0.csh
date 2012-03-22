#!/bin/csh -f

# Goal for this script is to extract lines that belong in the parser.

# We need echo to collapse \\ to \.  Sadly, this is not standard.
set thisOS = `uname -s`
set ECHO = echo
if ($thisOS == Linux) set ECHO = (/bin/echo -e)
if ($thisOS == SunOs) set ECHO = (/bin/echo)

if ($#argv != 2) then
	echo Usage: $0 tptp-1.txt tptp-1.lex0 '   creates tptp-1.y0'
	exit $#argv
	endif

set inr = $1:r
set outy = $inr.y0

$ECHO '' > $outy
# Output definitions for yacc next.
$ECHO '%{' >> $outy
$ECHO '/* Compile with -DP_VERBOSE=1 for verbose output.                    */' >> $outy
$ECHO '/* Compile with -DP_USERPROC=1 to #include p_user_proc.c.            */' >> $outy
$ECHO '/*   p_user_proc.c should #define P_ACT, P_BUILD, P_TOKEN, P_PRINT to*/' >> $outy
$ECHO '/*   different procedures from those below, and supply code.         */' >> $outy
$ECHO '' >> $outy
$ECHO '/* *_strict rules are documentation; unreachable; hand-code semantic actions.*/' >> $outy
$ECHO '' >> $outy
$ECHO '#include <stdio.h>' >> $outy
$ECHO '#include <string.h>' >> $outy
$ECHO '#include <stdlib.h>' >> $outy
$ECHO '#ifndef P_VERBOSE' >> $outy
$ECHO '#  define P_VERBOSE 0' >> $outy
$ECHO '#endif' >> $outy
$ECHO '#ifdef P_USERPROC' >> $outy
$ECHO '#  include "p_user_proc.c"' >> $outy
$ECHO '#else' >> $outy
$ECHO '#  define P_ACT(ss) if(verbose)printf("%7d %s\\n",yylineno,ss);' >> $outy
$ECHO '#  define P_BUILD(sym,A,B,C,D,E,F,G,H,I,J) pBuildTree(sym,A,B,C,D,E,F,G,H,I,J)' >> $outy
$ECHO '#  define P_TOKEN(tok,sym) pToken(tok,sym)' >> $outy
$ECHO '#  define P_PRINT(ss) if(verbose){printf("\\n\\n");pPrintTree(ss,0);}' >> $outy
$ECHO '#endif' >> $outy
$ECHO '' >> $outy
$ECHO '#define MAX_CH 10' >> $outy
$ECHO 'extern int yylineno;' >> $outy
$ECHO '/* tptp_ff is just an example of lex-er interface; setting to 0 is no-op. */' >> $outy
$ECHO 'extern int tptp_ff;' >> $outy
$ECHO 'int verbose = P_VERBOSE;' >> $outy
$ECHO 'char pTokenBuf[512];' >> $outy
$ECHO '' >> $outy
$ECHO 'typedef struct pTreeNode * pTree;' >> $outy
$ECHO 'struct pTreeNode {char* sym; pTree ch[MAX_CH+1];};' >> $outy
$ECHO '' >> $outy
$ECHO 'pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,' >> $outy
$ECHO '    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J);' >> $outy
$ECHO 'pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,' >> $outy
$ECHO '    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J)' >> $outy
$ECHO '{ pTree ss = (pTree)calloc(1,sizeof(struct pTreeNode));' >> $outy
$ECHO '  ss->sym = sym;' >> $outy
$ECHO '  ss->ch[0] = A; ss->ch[1] = B; ss->ch[2] = C; ss->ch[3] = D;' >> $outy
$ECHO '  ss->ch[4] = E; ss->ch[5] = F; ss->ch[6] = G; ss->ch[7] = H;' >> $outy
$ECHO '  ss->ch[8] = I; ss->ch[9] = J; ss->ch[10] = 0;' >> $outy
$ECHO '  return ss; }' >> $outy
$ECHO '' >> $outy
$ECHO 'pTree pToken(char* tok, char* sym);' >> $outy
$ECHO 'pTree pToken(char* tok, char* sym)' >> $outy
$ECHO '{ pTree ss;' >> $outy
$ECHO '  char* safeSym;' >> $outy
$ECHO '  strcpy(pTokenBuf, tok);' >> $outy
$ECHO '  strcat(pTokenBuf, sym);' >> $outy
$ECHO '  safeSym = strdup(pTokenBuf);' >> $outy
$ECHO '  ss = pBuildTree(safeSym,0,0,0,0,0,0,0,0,0,0);' >> $outy
$ECHO '  return ss; }' >> $outy
$ECHO '' >> $outy
$ECHO 'void pPrintTree(pTree ss, int depth);' >> $outy
$ECHO 'void pPrintTree(pTree ss, int depth)' >> $outy
$ECHO '{ int i, d;' >> $outy
$ECHO '  for (d = 0; d < depth; d++) printf("  ");' >> $outy
$ECHO '  if (ss->ch[0] == 0) printf("%s\\n", ss->sym); else printf("<%s>\\n", ss->sym);' >> $outy
$ECHO '  i = 0;' >> $outy
$ECHO '  while(ss->ch[i] \!= 0) {pPrintTree(ss->ch[i], depth+1); i++;}' >> $outy
$ECHO '  return; }' >> $outy
$ECHO '%}' >> $outy
$ECHO '' >> $outy
$ECHO '%union {int ival; double dval; char* sval; void* pval;}' >> $outy
$ECHO '' >> $outy



cat $1 | \
egrep -v '^/\*' | \
egrep -v '^(comment|system_comment|upper_word|lower_word|atomic_system_word|single_quoted|real|unsigned_integer|decimal_part|double_quoted|distinct_object|char_or_eoln|until_eoln)' | \
awk 'NF>0{print "%start ", $1;exit;}' | \
cat >> $outy

# Find the tokens in the lex file.
cat $2 | \
egrep 'return *\(' | \
sed -e 's/^.*return *( *\([^ )]*\) *);.*$/%token <sval> \1/' | \
sort -u | \
cat >> $outy

# Preserve tokens in unused rules for enumerated types.
cat $1 | \
egrep -v '^/\*' | \
egrep '^(formula_role|theory_name|intro_type|status_value)' | \
awk '{for (i = 1; i <=NF; i++)print $i;}' | \
sort -u | \
awk '/[A-Z][A-Z_][A-Z_]*$/' | \
egrep -v '^(ASCII|CHAR|DQUOTE|ETC_ETC|PERCENT|SLASHSTAR|SQUOTE|STARSLASH)' | \
awk '{print "%token <sval> " $1;}' | \
cat >> $outy



$ECHO '%%' >> $outy
$ECHO '' >> $outy
# Rules for yacc next; all tokens should appear in yacc file (maybe future)


cat $1 | \
egrep -v '^(comment|system_comment|upper_word|lower_word|atomic_system_word|single_quoted|real|unsigned_integer|decimal_part|double_quoted|distinct_object|char_or_eoln|until_eoln)' | \
egrep -v ^sign | \
egrep -v ^decimal_part | \
egrep -v ^CHAR | \
egrep -v ^VLINE | \
egrep -v ^STAR | \
egrep -v ^PLUS | \
sed -e 's/ sign / signed_integer |/' | \
awk '/^source /{sub("[ ]*[|][ ]*UNKNOWN","");print;next;} {print;}' | \
awk '/^file_node_name/{sub("[ ]*[|][ ]*UNKNOWN","");print;next;} {print;}' | \
awk '/^source /{print "source              ::= general_term";sub("[ ]*::=","_strict ::=");print;next;} {print;}' | \
awk '/^info_item /{print "info_item           ::= general_term";sub("[ ]*::=","_strict ::=");print;next;} {print;}' | \
awk '/^formula_role/{print "formula_role        ::= lower_word";sub("[ ]*::=","_strict ::=");print;next;} {print;}' | \
awk '/^theory_name/{print "theory_name         ::= lower_word";sub("[ ]*::=","_strict  ::=");print;next;} {print;}' | \
awk '/^intro_type/{print "intro_type          ::= lower_word";sub("[ ]*::=","_strict   ::=");print;next;} {print;}' | \
awk '/^status_value/{print "status_value        ::= lower_word";sub("[ ]*::=","_strict ::=");print;next;} {print;}' | \
sed -e '/^TPTP_[A-Z_]*file/s/\([A-Za-z0-9_]*\)\( *::= *\)\([A-Za-z0-9_]*\) *[+]/\1\2\3 | \1 \3/' | \
sed -e '/^TPTP_[A-Z_]*file/s/\([A-Za-z0-9_]*\)\( *::= *\)\([A-Za-z0-9_]*\) *[*]/\1\2null | \1 \3/' | \
sed -e 's/\([A-Za-z0-9_]*\)\( *::= *\)\([A-Za-z0-9_]*\) *[+]/\1\2\3 | \3 \1/' | \
cat >> $outy
