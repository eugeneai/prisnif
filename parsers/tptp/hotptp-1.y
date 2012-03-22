
%{
/* Compile with -DP_VERBOSE=1 for verbose output.                    */
/* Compile with -DP_USERPROC=1 to #include p_user_proc.c.            */
/*   p_user_proc.c should #define P_ACT, P_BUILD, P_TOKEN, P_PRINT to*/
/*   different procedures from those below, and supply code.         */

/* *_strict rules are documentation; unreachable; hand-code semantic actions.*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#ifndef P_VERBOSE
#  define P_VERBOSE 0
#endif
#ifdef P_USERPROC
#  include "p_user_proc.c"
#else
#  define P_ACT(ss) if(verbose)printf("%7d %s\n",yylineno,ss);
#  define P_BUILD(sym,A,B,C,D,E,F,G,H,I,J) pBuildTree(sym,A,B,C,D,E,F,G,H,I,J)
#  define P_TOKEN(tok,symIdx) pToken(tok,symIdx)
#  define P_PRINT(ss) if(verbose){printf("\n\n");pPrintTree(ss,0);}
#endif

#ifndef P_USERPROC
#define MAX_CH 12
extern int yylineno;
extern int tptp_store_size;
extern char* tptp_lval[];
int verbose = P_VERBOSE;
char pTokenBuf[8240];
/* pPrintIdx is where to find top-level comments to print
   before a sentence. yywrap() gets those after last sentence. */
int pPrintIdx = 0;

typedef struct pTreeNode * pTree;
struct pTreeNode {char* sym; int symIdx; pTree ch[MAX_CH+1];};

pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,
    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J);
pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,
    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J)
{ pTree ss = (pTree)calloc(1,sizeof(struct pTreeNode));
  ss->sym = sym;
  ss->symIdx = -1;
  ss->ch[0] = A; ss->ch[1] = B; ss->ch[2] = C; ss->ch[3] = D;
  ss->ch[4] = E; ss->ch[5] = F; ss->ch[6] = G; ss->ch[7] = H;
  ss->ch[8] = I; ss->ch[9] = J; ss->ch[10] = 0;
  return ss; }

pTree pToken(char* tok, int symIdx);
pTree pToken(char* tok, int symIdx)
{ pTree ss;
  char* sym = tptp_lval[symIdx];
  char* safeSym;
  strncpy(pTokenBuf, tok, 39);
  strncat(pTokenBuf, sym, 8193);
  safeSym = strdup(pTokenBuf);
  ss = pBuildTree(safeSym,0,0,0,0,0,0,0,0,0,0);
  ss->symIdx = symIdx;
  return ss; }

void pPrintComments(int start, int depth);
void pPrintComments(int start, int depth)
{ int d, j;
  char c1[4] = "%", c2[4] = "/*";
  j = start;
  while (tptp_lval[j] != NULL
  && (tptp_lval[j][0]==c1[0] || (tptp_lval[j][0]==c2[0] && tptp_lval[j][1]==c2[1])))
    { for (d=0; d<depth; d++) printf("  ");
      printf("%s\n",tptp_lval[j]);
      j = (j+1)%tptp_store_size; }
  return; }

void pPrintTree(pTree ss, int depth);
void pPrintTree(pTree ss, int depth)
{ int i, d;
  if (pPrintIdx >= 0)
    { pPrintComments(pPrintIdx, 0); pPrintIdx = -1;}
  if (ss == NULL) return;
  for (d = 0; d < depth; d++) printf("  ");
  if (ss->ch[0] == 0) printf("%s\n", ss->sym);
  else printf("<%s>\n", ss->sym);
  if (strcmp(ss->sym, "PERIOD .") == 0)
    pPrintIdx = (ss->symIdx+1)%tptp_store_size;
  if (ss->symIdx >= 0)
    pPrintComments((ss->symIdx+1)%tptp_store_size, depth);
  i = 0;
  while(ss->ch[i] != 0) {pPrintTree(ss->ch[i], depth+1); i++;}
  return; }

int yywrap(void)
{ P_PRINT(NULL); return 1; }

#endif
%}

%union {int ival; double dval; char* sval; void* pval;}

%start  TPTP_file
%token <ival> AMPERSAND
%token <ival> AT_SIGN
%token <ival> CARET
%token <ival> COLON
%token <ival> COLON_EQUALS
%token <ival> COMMA
%token <ival> EQUALS
%token <ival> EQUALS_GREATER
%token <ival> EXCLAMATION
%token <ival> EXCLAMATION_EQUALS
%token <ival> GREATER
%token <ival> LBRKT
%token <ival> LESS_EQUALS
%token <ival> LESS_EQUALS_GREATER
%token <ival> LESS_TILDE_GREATER
%token <ival> LPAREN
%token <ival> MINUS_GREATER
%token <ival> PERIOD
%token <ival> QUESTION
%token <ival> RBRKT
%token <ival> RPAREN
%token <ival> STAR
%token <ival> TILDE
%token <ival> TILDE_AMPERSAND
%token <ival> TILDE_VLINE
%token <ival> VLINE
%token <ival> _LIT_cnf
%token <ival> _LIT_fof
%token <ival> _LIT_include
%token <ival> _LIT_lambda
%token <ival> _LIT_letrec
%token <ival> _LIT_tff
%token <ival> _LIT_thf
%token <ival> distinct_object
%token <ival> dollar_dollar_word
%token <ival> dollar_word
%token <ival> falseProp
%token <ival> iType
%token <ival> lower_word
%token <ival> oType
%token <ival> plus
%token <ival> real
%token <ival> signed_integer
%token <ival> single_quoted
%token <ival> tType
%token <ival> trueProp
%token <ival> unrecognized
%token <ival> unsigned_integer
%token <ival> upper_word
%%

TPTP_file : null {}
                    | TPTP_file TPTP_input {}
                    ;

TPTP_input : annotated_formula {P_PRINT($<pval>$);}
                    | include {P_PRINT($<pval>$);}
                    ;

annotated_formula : fof_annotated {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | cnf_annotated {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_annotated {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_annotated {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

fof_annotated : _LIT_fof LPAREN name COMMA formula_role COMMA fof_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("fof_annotated", P_TOKEN("_LIT_fof ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

cnf_annotated : _LIT_cnf LPAREN name COMMA formula_role COMMA cnf_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("cnf_annotated", P_TOKEN("_LIT_cnf ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

thf_annotated : _LIT_thf LPAREN name COMMA formula_role COMMA thf_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("thf_annotated", P_TOKEN("_LIT_thf ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

tff_annotated : _LIT_tff LPAREN name COMMA formula_role COMMA tff_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("tff_annotated", P_TOKEN("_LIT_tff ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

annotations : null {$<pval>$ = P_BUILD("annotations", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | COMMA source optional_info {$<pval>$ = P_BUILD("annotations", P_TOKEN("COMMA ", $<ival>1), $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

formula_role : lower_word {$<pval>$ = P_BUILD("formula_role", P_TOKEN("lower_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

fof_formula : binary_formula {$<pval>$ = P_BUILD("fof_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unitary_formula {$<pval>$ = P_BUILD("fof_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

binary_formula : nonassoc_binary {$<pval>$ = P_BUILD("binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | assoc_binary {$<pval>$ = P_BUILD("binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

nonassoc_binary : unitary_formula binary_connective unitary_formula {$<pval>$ = P_BUILD("nonassoc_binary", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

binary_connective : LESS_EQUALS_GREATER {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS_GREATER ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | EQUALS_GREATER {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("EQUALS_GREATER ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LESS_EQUALS {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LESS_TILDE_GREATER {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("LESS_TILDE_GREATER ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TILDE_VLINE {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("TILDE_VLINE ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TILDE_AMPERSAND {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("TILDE_AMPERSAND ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

assoc_binary : or_formula {$<pval>$ = P_BUILD("assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | and_formula {$<pval>$ = P_BUILD("assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

or_formula          : unitary_formula VLINE unitary_formula {$<pval>$ = P_BUILD("or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | unitary_formula VLINE or_formula {$<pval>$ = P_BUILD("or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

and_formula         : unitary_formula AMPERSAND unitary_formula {$<pval>$ = P_BUILD("and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | unitary_formula AMPERSAND and_formula {$<pval>$ = P_BUILD("and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

assoc_connective : VLINE {$<pval>$ = P_BUILD("assoc_connective", P_TOKEN("VLINE ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | AMPERSAND {$<pval>$ = P_BUILD("assoc_connective", P_TOKEN("AMPERSAND ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

unitary_formula : quantified_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unary_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | atomic_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN fof_formula RPAREN {$<pval>$ = P_BUILD("unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

quantified_formula : quantifier LBRKT variable_list RBRKT COLON unitary_formula {$<pval>$ = P_BUILD("quantified_formula", $<pval>1, P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), P_TOKEN("COLON ", $<ival>5), $<pval>6, 0, 0, 0, 0);}
                    ;

quantifier : EXCLAMATION {$<pval>$ = P_BUILD("quantifier", P_TOKEN("EXCLAMATION ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | QUESTION {$<pval>$ = P_BUILD("quantifier", P_TOKEN("QUESTION ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

variable_list : variable {$<pval>$ = P_BUILD("variable_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | variable COMMA variable_list {$<pval>$ = P_BUILD("variable_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

unary_formula : unary_connective unitary_formula {$<pval>$ = P_BUILD("unary_formula", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

unary_connective : TILDE {$<pval>$ = P_BUILD("unary_connective", P_TOKEN("TILDE ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

cnf_formula : LPAREN disjunction RPAREN {$<pval>$ = P_BUILD("cnf_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    | disjunction {$<pval>$ = P_BUILD("cnf_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

disjunction         : literal {$<pval>$ = P_BUILD("disjunction", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | literal VLINE disjunction {$<pval>$ = P_BUILD("disjunction", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

literal : atomic_formula {$<pval>$ = P_BUILD("literal", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TILDE atomic_formula {$<pval>$ = P_BUILD("literal", P_TOKEN("TILDE ", $<ival>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_formula : thf_binary_formula {$<pval>$ = P_BUILD("thf_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_formula {$<pval>$ = P_BUILD("thf_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_definition {$<pval>$ = P_BUILD("thf_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_binary_formula : thf_nonassoc_formula {$<pval>$ = P_BUILD("thf_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_assoc_formula {$<pval>$ = P_BUILD("thf_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_apply_formula {$<pval>$ = P_BUILD("thf_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_equality {$<pval>$ = P_BUILD("thf_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_binary_type {$<pval>$ = P_BUILD("thf_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_nonassoc_formula : thf_unitary_formula binary_connective thf_unitary_formula {$<pval>$ = P_BUILD("thf_nonassoc_formula", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_equality : thf_unitary_formula EQUALS thf_unitary_formula {$<pval>$ = P_BUILD("thf_equality", $<pval>1, P_TOKEN("EQUALS ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_assoc_formula : thf_or_formula {$<pval>$ = P_BUILD("thf_assoc_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_and_formula {$<pval>$ = P_BUILD("thf_assoc_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_or_formula : thf_unitary_formula VLINE thf_unitary_formula {$<pval>$ = P_BUILD("thf_or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_or_formula VLINE thf_unitary_formula {$<pval>$ = P_BUILD("thf_or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_and_formula : thf_unitary_formula AMPERSAND thf_unitary_formula {$<pval>$ = P_BUILD("thf_and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_and_formula AMPERSAND thf_unitary_formula {$<pval>$ = P_BUILD("thf_and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_unitary_formula : thf_atom {$<pval>$ = P_BUILD("thf_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_let_rec {$<pval>$ = P_BUILD("thf_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_abstraction {$<pval>$ = P_BUILD("thf_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unary_formula {$<pval>$ = P_BUILD("thf_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_quantified_formula {$<pval>$ = P_BUILD("thf_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN thf_tuple RPAREN {$<pval>$ = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN thf_binary_formula RPAREN {$<pval>$ = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN thf_unitary_formula RPAREN {$<pval>$ = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_quantified_formula : thf_quantifier LBRKT thf_variable_list RBRKT COLON thf_unitary_formula {$<pval>$ = P_BUILD("thf_quantified_formula", $<pval>1, P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), P_TOKEN("COLON ", $<ival>5), $<pval>6, 0, 0, 0, 0);}
                    ;

thf_quantifier : EXCLAMATION {$<pval>$ = P_BUILD("thf_quantifier", P_TOKEN("EXCLAMATION ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | QUESTION {$<pval>$ = P_BUILD("thf_quantifier", P_TOKEN("QUESTION ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_variable_list : thf_variable {$<pval>$ = P_BUILD("thf_variable_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_variable COMMA thf_variable_list {$<pval>$ = P_BUILD("thf_variable_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_unary_formula : unary_connective thf_unitary_formula {$<pval>$ = P_BUILD("thf_unary_formula", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_abstraction : thf_lambda LBRKT thf_variable_list RBRKT COLON thf_unitary_formula {$<pval>$ = P_BUILD("thf_abstraction", $<pval>1, P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), P_TOKEN("COLON ", $<ival>5), $<pval>6, 0, 0, 0, 0);}
                    ;

thf_lambda : _LIT_lambda {$<pval>$ = P_BUILD("thf_lambda", P_TOKEN("_LIT_lambda ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CARET {$<pval>$ = P_BUILD("thf_lambda", P_TOKEN("CARET ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_apply_formula : thf_apply_formula AT_SIGN thf_unitary_formula {$<pval>$ = P_BUILD("thf_apply_formula", $<pval>1, P_TOKEN("AT_SIGN ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_formula AT_SIGN thf_unitary_formula {$<pval>$ = P_BUILD("thf_apply_formula", $<pval>1, P_TOKEN("AT_SIGN ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_tuple : thf_unitary_formula COMMA thf_tuple {$<pval>$ = P_BUILD("thf_tuple", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_formula COMMA thf_unitary_formula {$<pval>$ = P_BUILD("thf_tuple", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_atom : thf_typed_atom {$<pval>$ = P_BUILD("thf_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_untyped_atom {$<pval>$ = P_BUILD("thf_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_typed_atom : thf_typed_constant {$<pval>$ = P_BUILD("thf_typed_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_typed_variable {$<pval>$ = P_BUILD("thf_typed_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_untyped_atom : thf_untyped_constant {$<pval>$ = P_BUILD("thf_untyped_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_untyped_variable {$<pval>$ = P_BUILD("thf_untyped_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_variable : thf_untyped_variable {$<pval>$ = P_BUILD("thf_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_typed_variable {$<pval>$ = P_BUILD("thf_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_typed_variable : thf_untyped_variable COLON thf_unitary_type {$<pval>$ = P_BUILD("thf_typed_variable", $<pval>1, P_TOKEN("COLON ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_untyped_variable : variable {$<pval>$ = P_BUILD("thf_untyped_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_typed_constant : thf_untyped_constant COLON thf_unitary_type {$<pval>$ = P_BUILD("thf_typed_constant", $<pval>1, P_TOKEN("COLON ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_untyped_constant : atomic_word {$<pval>$ = P_BUILD("thf_untyped_constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | number {$<pval>$ = P_BUILD("thf_untyped_constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | distinct_object {$<pval>$ = P_BUILD("thf_untyped_constant", P_TOKEN("distinct_object ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | atomic_system_word {$<pval>$ = P_BUILD("thf_untyped_constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_defined_word {$<pval>$ = P_BUILD("thf_untyped_constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN tptp_operator RPAREN {$<pval>$ = P_BUILD("thf_untyped_constant", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_defined_word : defined_type {$<pval>$ = P_BUILD("thf_defined_word", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_prop {$<pval>$ = P_BUILD("thf_defined_word", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tptp_operator : unary_connective {$<pval>$ = P_BUILD("tptp_operator", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | binary_connective {$<pval>$ = P_BUILD("tptp_operator", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | assoc_connective {$<pval>$ = P_BUILD("tptp_operator", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | quantifier {$<pval>$ = P_BUILD("tptp_operator", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | EQUALS {$<pval>$ = P_BUILD("tptp_operator", P_TOKEN("EQUALS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_binary_type : thf_mapping_type {$<pval>$ = P_BUILD("thf_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_xprod_type {$<pval>$ = P_BUILD("thf_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_union_type {$<pval>$ = P_BUILD("thf_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_mapping_type : thf_unitary_type map_arrow thf_mapping_type {$<pval>$ = P_BUILD("thf_mapping_type", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_type map_arrow thf_unitary_type {$<pval>$ = P_BUILD("thf_mapping_type", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_xprod_type : thf_xprod_type STAR thf_unitary_type {$<pval>$ = P_BUILD("thf_xprod_type", $<pval>1, P_TOKEN("STAR ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_type STAR thf_unitary_type {$<pval>$ = P_BUILD("thf_xprod_type", $<pval>1, P_TOKEN("STAR ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_union_type : thf_union_type plus thf_unitary_type {$<pval>$ = P_BUILD("thf_union_type", $<pval>1, P_TOKEN("plus ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_unitary_type plus thf_unitary_type {$<pval>$ = P_BUILD("thf_union_type", $<pval>1, P_TOKEN("plus ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_unitary_type : thf_unitary_formula {$<pval>$ = P_BUILD("thf_unitary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

map_arrow : MINUS_GREATER {$<pval>$ = P_BUILD("map_arrow", P_TOKEN("MINUS_GREATER ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  GREATER  {$<pval>$ = P_BUILD("map_arrow", P_TOKEN("GREATER ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_let_rec : _LIT_letrec LBRKT thf_definition_list RBRKT COLON thf_unitary_formula {$<pval>$ = P_BUILD("thf_let_rec", P_TOKEN("_LIT_letrec ", $<ival>1), P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), P_TOKEN("COLON ", $<ival>5), $<pval>6, 0, 0, 0, 0);}
                    ;

thf_definition_list : thf_definition {$<pval>$ = P_BUILD("thf_definition_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | thf_definition COMMA thf_definition_list {$<pval>$ = P_BUILD("thf_definition_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

thf_definition : atomic_word COLON_EQUALS thf_unitary_formula {$<pval>$ = P_BUILD("thf_definition", $<pval>1, P_TOKEN("COLON_EQUALS ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN thf_definition RPAREN {$<pval>$ = P_BUILD("thf_definition", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_formula : tff_binary_formula {$<pval>$ = P_BUILD("tff_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_formula {$<pval>$ = P_BUILD("tff_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_typed_atom {$<pval>$ = P_BUILD("tff_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_binary_formula : tff_nonassoc_binary {$<pval>$ = P_BUILD("tff_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_assoc_binary {$<pval>$ = P_BUILD("tff_binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_nonassoc_binary : tff_unitary_formula binary_connective tff_unitary_formula {$<pval>$ = P_BUILD("tff_nonassoc_binary", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_assoc_binary : tff_or_formula {$<pval>$ = P_BUILD("tff_assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_and_formula {$<pval>$ = P_BUILD("tff_assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_or_formula      : tff_unitary_formula VLINE tff_unitary_formula {$<pval>$ = P_BUILD("tff_or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_formula VLINE tff_or_formula {$<pval>$ = P_BUILD("tff_or_formula", $<pval>1, P_TOKEN("VLINE ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_and_formula     : tff_unitary_formula AMPERSAND tff_unitary_formula {$<pval>$ = P_BUILD("tff_and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_formula AMPERSAND tff_and_formula {$<pval>$ = P_BUILD("tff_and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_unitary_formula : tff_quantified_formula {$<pval>$ = P_BUILD("tff_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unary_formula {$<pval>$ = P_BUILD("tff_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | atomic_formula {$<pval>$ = P_BUILD("tff_unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN tff_binary_formula RPAREN {$<pval>$ = P_BUILD("tff_unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN tff_unitary_formula RPAREN {$<pval>$ = P_BUILD("tff_unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_quantified_formula : quantifier LBRKT tff_variable_list RBRKT COLON tff_unitary_formula {$<pval>$ = P_BUILD("tff_quantified_formula", $<pval>1, P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), P_TOKEN("COLON ", $<ival>5), $<pval>6, 0, 0, 0, 0);}
                    ;

tff_variable_list : tff_variable {$<pval>$ = P_BUILD("tff_variable_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_variable COMMA tff_variable_list {$<pval>$ = P_BUILD("tff_variable_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_unary_formula : unary_connective tff_unitary_formula {$<pval>$ = P_BUILD("tff_unary_formula", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_typed_atom : tff_untyped_atom COLON tff_type_spec {$<pval>$ = P_BUILD("tff_typed_atom", $<pval>1, P_TOKEN("COLON ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN tff_typed_atom RPAREN {$<pval>$ = P_BUILD("tff_typed_atom", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_untyped_atom : functor {$<pval>$ = P_BUILD("tff_untyped_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_term {$<pval>$ = P_BUILD("tff_untyped_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | system_functor {$<pval>$ = P_BUILD("tff_untyped_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_variable : tff_untyped_variable {$<pval>$ = P_BUILD("tff_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_typed_variable {$<pval>$ = P_BUILD("tff_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_typed_variable : tff_untyped_variable COLON tff_type_spec {$<pval>$ = P_BUILD("tff_typed_variable", $<pval>1, P_TOKEN("COLON ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_untyped_variable : variable {$<pval>$ = P_BUILD("tff_untyped_variable", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_type_spec : tff_untyped_atom {$<pval>$ = P_BUILD("tff_type_spec", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_type {$<pval>$ = P_BUILD("tff_type_spec", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_type_expr {$<pval>$ = P_BUILD("tff_type_spec", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN tff_type_spec RPAREN {$<pval>$ = P_BUILD("tff_type_spec", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_type_expr : LPAREN tff_binary_type RPAREN {$<pval>$ = P_BUILD("tff_type_expr", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_binary_type : tff_mapping_type {$<pval>$ = P_BUILD("tff_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_xprod_type {$<pval>$ = P_BUILD("tff_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_union_type {$<pval>$ = P_BUILD("tff_binary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_mapping_type : tff_unitary_type map_arrow tff_mapping_type {$<pval>$ = P_BUILD("tff_mapping_type", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_type map_arrow tff_unitary_type {$<pval>$ = P_BUILD("tff_mapping_type", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_xprod_type : tff_xprod_type STAR tff_unitary_type {$<pval>$ = P_BUILD("tff_xprod_type", $<pval>1, P_TOKEN("STAR ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_type STAR tff_unitary_type {$<pval>$ = P_BUILD("tff_xprod_type", $<pval>1, P_TOKEN("STAR ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_union_type : tff_union_type plus tff_unitary_type {$<pval>$ = P_BUILD("tff_union_type", $<pval>1, P_TOKEN("plus ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_unitary_type plus tff_unitary_type {$<pval>$ = P_BUILD("tff_union_type", $<pval>1, P_TOKEN("plus ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

tff_unitary_type : tff_untyped_atom {$<pval>$ = P_BUILD("tff_unitary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_type {$<pval>$ = P_BUILD("tff_unitary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tff_type_expr {$<pval>$ = P_BUILD("tff_unitary_type", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_formula : plain_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | system_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

plain_atom : plain_term {$<pval>$ = P_BUILD("plain_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

arguments : term {$<pval>$ = P_BUILD("arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | term COMMA arguments {$<pval>$ = P_BUILD("arguments", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_atom : defined_prop {$<pval>$ = P_BUILD("defined_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_pred LPAREN arguments RPAREN {$<pval>$ = P_BUILD("defined_atom", $<pval>1, P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("RPAREN ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    | term defined_infix_pred term {$<pval>$ = P_BUILD("defined_atom", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_infix_pred : EQUALS {$<pval>$ = P_BUILD("defined_infix_pred", P_TOKEN("EQUALS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | EXCLAMATION_EQUALS {$<pval>$ = P_BUILD("defined_infix_pred", P_TOKEN("EXCLAMATION_EQUALS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_prop : trueProp {$<pval>$ = P_BUILD("defined_prop", P_TOKEN("trueProp ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | falseProp {$<pval>$ = P_BUILD("defined_prop", P_TOKEN("falseProp ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_pred : atomic_defined_word {$<pval>$ = P_BUILD("defined_pred", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_type : oType {$<pval>$ = P_BUILD("defined_type", P_TOKEN("oType ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | iType {$<pval>$ = P_BUILD("defined_type", P_TOKEN("iType ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | tType {$<pval>$ = P_BUILD("defined_type", P_TOKEN("tType ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_atom : system_term {$<pval>$ = P_BUILD("system_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

term : function_term {$<pval>$ = P_BUILD("term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | variable {$<pval>$ = P_BUILD("term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

function_term : plain_term {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_term {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | system_term {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

plain_term : constant {$<pval>$ = P_BUILD("plain_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | functor LPAREN arguments RPAREN {$<pval>$ = P_BUILD("plain_term", $<pval>1, P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("RPAREN ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    ;

constant : atomic_word {$<pval>$ = P_BUILD("constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

functor : atomic_word {$<pval>$ = P_BUILD("functor", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_term : number {$<pval>$ = P_BUILD("defined_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | distinct_object {$<pval>$ = P_BUILD("defined_term", P_TOKEN("distinct_object ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_term : system_constant {$<pval>$ = P_BUILD("system_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | system_functor LPAREN arguments RPAREN {$<pval>$ = P_BUILD("system_term", $<pval>1, P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("RPAREN ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    ;

system_functor : atomic_system_word {$<pval>$ = P_BUILD("system_functor", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_constant : atomic_system_word {$<pval>$ = P_BUILD("system_constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

variable : upper_word {$<pval>$ = P_BUILD("variable", P_TOKEN("upper_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

source : general_term {$<pval>$ = P_BUILD("source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

optional_info : COMMA useful_info {$<pval>$ = P_BUILD("optional_info", P_TOKEN("COMMA ", $<ival>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | null {$<pval>$ = P_BUILD("optional_info", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

useful_info : general_term_list {$<pval>$ = P_BUILD("useful_info", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

include : _LIT_include LPAREN file_name formula_selection RPAREN PERIOD {$<pval>$ = P_BUILD("include", P_TOKEN("_LIT_include ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, $<pval>4, P_TOKEN("RPAREN ", $<ival>5), P_TOKEN("PERIOD ", $<ival>6), 0, 0, 0, 0);}
                    ;

formula_selection : COMMA LBRKT name_list RBRKT {$<pval>$ = P_BUILD("formula_selection", P_TOKEN("COMMA ", $<ival>1), P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    | null {$<pval>$ = P_BUILD("formula_selection", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

name_list : name {$<pval>$ = P_BUILD("name_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | name COMMA name_list {$<pval>$ = P_BUILD("name_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_term : general_data {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | general_data COLON general_term {$<pval>$ = P_BUILD("general_term", $<pval>1, P_TOKEN("COLON ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | general_list {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_data : atomic_word {$<pval>$ = P_BUILD("general_data", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | atomic_word LPAREN general_arguments RPAREN {$<pval>$ = P_BUILD("general_data", $<pval>1, P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("RPAREN ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    | number {$<pval>$ = P_BUILD("general_data", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | distinct_object {$<pval>$ = P_BUILD("general_data", P_TOKEN("distinct_object ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_arguments : general_term {$<pval>$ = P_BUILD("general_arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | general_term COMMA general_arguments {$<pval>$ = P_BUILD("general_arguments", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_list : LBRKT RBRKT {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<ival>1), P_TOKEN("RBRKT ", $<ival>2), 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LBRKT general_term_list RBRKT {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<ival>1), $<pval>2, P_TOKEN("RBRKT ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_term_list : general_term {$<pval>$ = P_BUILD("general_term_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | general_term COMMA general_term_list {$<pval>$ = P_BUILD("general_term_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

name : atomic_word {$<pval>$ = P_BUILD("name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unsigned_integer {$<pval>$ = P_BUILD("name", P_TOKEN("unsigned_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_word : lower_word {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("lower_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | single_quoted {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("single_quoted ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_defined_word : dollar_word {$<pval>$ = P_BUILD("atomic_defined_word", P_TOKEN("dollar_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_system_word : dollar_dollar_word {$<pval>$ = P_BUILD("atomic_system_word", P_TOKEN("dollar_dollar_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

number : real {$<pval>$ = P_BUILD("number", P_TOKEN("real ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | signed_integer {$<pval>$ = P_BUILD("number", P_TOKEN("signed_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unsigned_integer {$<pval>$ = P_BUILD("number", P_TOKEN("unsigned_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

file_name : atomic_word {$<pval>$ = P_BUILD("file_name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

null : {$<pval>$ = P_BUILD("null", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

