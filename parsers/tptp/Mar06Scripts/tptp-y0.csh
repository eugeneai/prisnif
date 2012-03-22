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

setenv LANG C
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
$ECHO '#  define P_TOKEN(tok,symIdx) pToken(tok,symIdx)' >> $outy
$ECHO '#  define P_PRINT(ss) if(verbose){printf("\\n\\n");pPrintTree(ss,0);}' >> $outy
$ECHO '#endif' >> $outy
$ECHO '' >> $outy
$ECHO '#define MAX_CH 12' >> $outy
$ECHO 'extern int yylineno;' >> $outy
$ECHO '/* tptp_ff is just an example of lex-er interface; setting to 0 is no-op. */' >> $outy
$ECHO 'extern int tptp_ff;' >> $outy
$ECHO 'extern int tptp_store_size;' >> $outy
$ECHO 'extern char* tptp_lval[];' >> $outy
$ECHO 'int verbose = P_VERBOSE;' >> $outy
$ECHO 'char pTokenBuf[8240];' >> $outy
$ECHO '/* pPrintIdx is where to find top-level comments to print' >> $outy
$ECHO '   before a sentence. yywrap() gets those after last sentence. */' >> $outy
$ECHO 'int pPrintIdx = 0;' >> $outy
$ECHO '' >> $outy
$ECHO 'typedef struct pTreeNode * pTree;' >> $outy
$ECHO 'struct pTreeNode {char* sym; int symIdx; pTree ch[MAX_CH+1];};' >> $outy
$ECHO '' >> $outy
$ECHO 'pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,' >> $outy
$ECHO '    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J);' >> $outy
$ECHO 'pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,' >> $outy
$ECHO '    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J)' >> $outy
$ECHO '{ pTree ss = (pTree)calloc(1,sizeof(struct pTreeNode));' >> $outy
$ECHO '  ss->sym = sym;' >> $outy
$ECHO '  ss->symIdx = -1;' >> $outy
$ECHO '  ss->ch[0] = A; ss->ch[1] = B; ss->ch[2] = C; ss->ch[3] = D;' >> $outy
$ECHO '  ss->ch[4] = E; ss->ch[5] = F; ss->ch[6] = G; ss->ch[7] = H;' >> $outy
$ECHO '  ss->ch[8] = I; ss->ch[9] = J; ss->ch[10] = 0;' >> $outy
$ECHO '  return ss; }' >> $outy
$ECHO '' >> $outy
$ECHO 'pTree pToken(char* tok, int symIdx);' >> $outy
$ECHO 'pTree pToken(char* tok, int symIdx)' >> $outy
$ECHO '{ pTree ss;' >> $outy
$ECHO '  char* sym = tptp_lval[symIdx];' >> $outy
$ECHO '  char* safeSym;' >> $outy
$ECHO '  strncpy(pTokenBuf, tok, 39);' >> $outy
$ECHO '  strncat(pTokenBuf, sym, 8193);' >> $outy
$ECHO '  safeSym = strdup(pTokenBuf);' >> $outy
$ECHO '  ss = pBuildTree(safeSym,0,0,0,0,0,0,0,0,0,0);' >> $outy
$ECHO '  ss->symIdx = symIdx;' >> $outy
$ECHO '  return ss; }' >> $outy
$ECHO '' >> $outy
$ECHO 'void pPrintComments(int start, int depth);' >> $outy
$ECHO 'void pPrintComments(int start, int depth)' >> $outy
$ECHO '{ int d, j;' >> $outy
$ECHO '  char c1[4] = "%", c2[4] = "/*";' >> $outy
$ECHO '  j = start;' >> $outy
$ECHO '  while (tptp_lval[j] \!= NULL' >> $outy
$ECHO '  && (tptp_lval[j][0]==c1[0] || (tptp_lval[j][0]==c2[0] && tptp_lval[j][1]==c2[1])))' >> $outy
$ECHO '    { for (d=0; d<depth; d++) printf("  ");' >> $outy
$ECHO '      printf("%s\\n",tptp_lval[j]);' >> $outy
$ECHO '      j = (j+1)%tptp_store_size; }' >> $outy
$ECHO '  return; }' >> $outy
$ECHO '' >> $outy
$ECHO 'void pPrintTree(pTree ss, int depth);' >> $outy
$ECHO 'void pPrintTree(pTree ss, int depth)' >> $outy
$ECHO '{ int i, d;' >> $outy
$ECHO '  if (pPrintIdx >= 0)' >> $outy
$ECHO '    { pPrintComments(pPrintIdx, 0); pPrintIdx = -1;}' >> $outy
$ECHO '  if (ss == NULL) return;' >> $outy
$ECHO '  for (d = 0; d < depth; d++) printf("  ");' >> $outy
$ECHO '  if (ss->ch[0] == 0) printf("%s\\n", ss->sym);' >> $outy
$ECHO '  else printf("<%s>\\n", ss->sym);' >> $outy
$ECHO '  if (strcmp(ss->sym, "PERIOD .") == 0)' >> $outy
$ECHO '    pPrintIdx = (ss->symIdx+1)%tptp_store_size;' >> $outy
$ECHO '  if (ss->symIdx >= 0)' >> $outy
$ECHO '    pPrintComments((ss->symIdx+1)%tptp_store_size, depth);' >> $outy
$ECHO '  i = 0;' >> $outy
$ECHO '  while(ss->ch[i] \!= 0) {pPrintTree(ss->ch[i], depth+1); i++;}' >> $outy
$ECHO '  return; }' >> $outy
$ECHO '' >> $outy
$ECHO 'int yywrap(void)' >> $outy
$ECHO '{ P_PRINT(NULL); return 1; }' >> $outy
$ECHO '' >> $outy
$ECHO '%}' >> $outy
$ECHO '' >> $outy
$ECHO '%union {int ival; double dval; char* sval; void* pval;}' >> $outy
$ECHO '' >> $outy


# Find the start symbol
cat $1 | \
awk '$2 == "_GRR" {print "%start ", $1;exit;}' | \
cat >> $outy

# Find the tokens in the lex file.
cat $2 | \
egrep 'return *\(' | \
sed -e 's/^.*return *( *\([^ )]*\) *);.*$/%token <ival> \1/' | \
sort -u | \
cat >> $outy



$ECHO '%%' >> $outy
$ECHO '' >> $outy
# Rules for yacc next; all tokens should appear in yacc file (maybe future)


cat $1 | \
awk '$2 == "_GRR"' | \
sed -e '/^TPTP_[A-Z_]*file/s/\([A-Za-z0-9_]*\)\( *_GRR *\)\([A-Za-z0-9_]*\) *[+]/\1\2\3 | \1 \3/' | \
sed -e '/^TPTP_[A-Z_]*file/s/\([A-Za-z0-9_]*\)\( *_GRR *\)\([A-Za-z0-9_]*\) *[*]/\1\2null | \1 \3/' | \
sed -e 's/\([A-Za-z0-9_]*\)\( *_GRR *\)\([A-Za-z0-9_]*\) *[+]/\1\2\3 | \3 \1/' | \
cat >> $outy
