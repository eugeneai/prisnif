
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
%token <ival> COLON
%token <ival> COMMA
%token <ival> EQUALS
%token <ival> EQUALS_GREATER
%token <ival> EXCLAMATION
%token <ival> EXCLAMATION_EQUALS
%token <ival> LBRKT
%token <ival> LESS_EQUALS
%token <ival> LESS_EQUALS_GREATER
%token <ival> LESS_TILDE_GREATER
%token <ival> LPAREN
%token <ival> MINUS_MINUS
%token <ival> PERIOD
%token <ival> PLUS_PLUS
%token <ival> QUESTION
%token <ival> RBRKT
%token <ival> RPAREN
%token <ival> TILDE
%token <ival> TILDE_AMPERSAND
%token <ival> TILDE_VLINE
%token <ival> VLINE
%token <ival> _DLR_false
%token <ival> _DLR_true
%token <ival> _LIT_cnf
%token <ival> _LIT_fof
%token <ival> _LIT_include
%token <ival> _LIT_input_clause
%token <ival> _LIT_input_formula
%token <ival> atomic_system_word
%token <ival> decimal_part
%token <ival> distinct_object
%token <ival> lower_word
%token <ival> real
%token <ival> signed_integer
%token <ival> single_quoted
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
                    | TPTP_input_formula {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TPTP_input_clause {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

fof_annotated : _LIT_fof LPAREN name COMMA formula_role COMMA fof_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("fof_annotated", P_TOKEN("_LIT_fof ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

cnf_annotated : _LIT_cnf LPAREN name COMMA formula_role COMMA cnf_formula annotations RPAREN PERIOD {$<pval>$ = P_BUILD("cnf_annotated", P_TOKEN("_LIT_cnf ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<ival>9), P_TOKEN("PERIOD ", $<ival>10));}
                    ;

annotations : null {$<pval>$ = P_BUILD("annotations", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | COMMA source {$<pval>$ = P_BUILD("annotations", P_TOKEN("COMMA ", $<ival>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | COMMA source COMMA useful_info {$<pval>$ = P_BUILD("annotations", P_TOKEN("COMMA ", $<ival>1), $<pval>2, P_TOKEN("COMMA ", $<ival>3), $<pval>4, 0, 0, 0, 0, 0, 0);}
                    ;

formula_role : atomic_word {$<pval>$ = P_BUILD("formula_role", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
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

unitary_formula : quantified_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unary_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN fof_formula RPAREN {$<pval>$ = P_BUILD("unitary_formula", P_TOKEN("LPAREN ", $<ival>1), $<pval>2, P_TOKEN("RPAREN ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    | atomic_formula {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
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

atomic_formula : plain_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | defined_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | system_atom {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

plain_atom : plain_term {$<pval>$ = P_BUILD("plain_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

arguments : term {$<pval>$ = P_BUILD("arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | term COMMA arguments {$<pval>$ = P_BUILD("arguments", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_atom : _DLR_true {$<pval>$ = P_BUILD("defined_atom", P_TOKEN("_DLR_true ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | _DLR_false {$<pval>$ = P_BUILD("defined_atom", P_TOKEN("_DLR_false ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | term EQUALS term {$<pval>$ = P_BUILD("defined_atom", $<pval>1, P_TOKEN("EQUALS ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | term EXCLAMATION_EQUALS term {$<pval>$ = P_BUILD("defined_atom", $<pval>1, P_TOKEN("EXCLAMATION_EQUALS ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
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

system_functor : atomic_system_word {$<pval>$ = P_BUILD("system_functor", P_TOKEN("atomic_system_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_constant : atomic_system_word {$<pval>$ = P_BUILD("system_constant", P_TOKEN("atomic_system_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

variable : upper_word {$<pval>$ = P_BUILD("variable", P_TOKEN("upper_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

source : general_function {$<pval>$ = P_BUILD("source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

file_name : atomic_word {$<pval>$ = P_BUILD("file_name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

useful_info : general_list {$<pval>$ = P_BUILD("useful_info", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

include : _LIT_include LPAREN file_name formula_selection RPAREN PERIOD {$<pval>$ = P_BUILD("include", P_TOKEN("_LIT_include ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, $<pval>4, P_TOKEN("RPAREN ", $<ival>5), P_TOKEN("PERIOD ", $<ival>6), 0, 0, 0, 0);}
                    ;

formula_selection : null {$<pval>$ = P_BUILD("formula_selection", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | COMMA LBRKT name_list RBRKT {$<pval>$ = P_BUILD("formula_selection", P_TOKEN("COMMA ", $<ival>1), P_TOKEN("LBRKT ", $<ival>2), $<pval>3, P_TOKEN("RBRKT ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    ;

name_list : name {$<pval>$ = P_BUILD("name_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | name COMMA name_list {$<pval>$ = P_BUILD("name_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_term : general_function {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | general_list {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_list : LBRKT RBRKT {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<ival>1), P_TOKEN("RBRKT ", $<ival>2), 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LBRKT general_arguments RBRKT {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<ival>1), $<pval>2, P_TOKEN("RBRKT ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_function : name {$<pval>$ = P_BUILD("general_function", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | functor LPAREN general_arguments RPAREN {$<pval>$ = P_BUILD("general_function", $<pval>1, P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("RPAREN ", $<ival>4), 0, 0, 0, 0, 0, 0);}
                    ;

general_arguments : general_term {$<pval>$ = P_BUILD("general_arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | general_term COMMA general_arguments {$<pval>$ = P_BUILD("general_arguments", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

name : atomic_word {$<pval>$ = P_BUILD("name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unsigned_integer {$<pval>$ = P_BUILD("name", P_TOKEN("unsigned_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_word : lower_word {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("lower_word ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | single_quoted {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("single_quoted ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

null : {$<pval>$ = P_BUILD("null", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

number : real {$<pval>$ = P_BUILD("number", P_TOKEN("real ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | integer {$<pval>$ = P_BUILD("number", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

integer : signed_integer {$<pval>$ = P_BUILD("integer", P_TOKEN("signed_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | unsigned_integer {$<pval>$ = P_BUILD("integer", P_TOKEN("unsigned_integer ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

TPTP_FOF_file : null {}
                    | TPTP_FOF_file TPTP_FOF_input {}
                    ;

TPTP_FOF_input : TPTP_input_formula {P_PRINT($<pval>$);}
                    | include {P_PRINT($<pval>$);}
                    ;

TPTP_input_formula : _LIT_input_formula LPAREN name COMMA formula_role COMMA fof_formula RPAREN PERIOD {$<pval>$ = P_BUILD("TPTP_input_formula", P_TOKEN("_LIT_input_formula ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, P_TOKEN("RPAREN ", $<ival>8), P_TOKEN("PERIOD ", $<ival>9), 0);}
                    ;

TPTP_CNF_file : null {}
                    | TPTP_CNF_file TPTP_CNF_input {}
                    ;

TPTP_CNF_input : TPTP_input_clause {P_PRINT($<pval>$);}
                    | include {P_PRINT($<pval>$);}
                    ;

TPTP_input_clause : _LIT_input_clause LPAREN name COMMA formula_role COMMA TPTP_literals RPAREN PERIOD {$<pval>$ = P_BUILD("TPTP_input_clause", P_TOKEN("_LIT_input_clause ", $<ival>1), P_TOKEN("LPAREN ", $<ival>2), $<pval>3, P_TOKEN("COMMA ", $<ival>4), $<pval>5, P_TOKEN("COMMA ", $<ival>6), $<pval>7, P_TOKEN("RPAREN ", $<ival>8), P_TOKEN("PERIOD ", $<ival>9), 0);}
                    ;

TPTP_literals : LBRKT RBRKT {$<pval>$ = P_BUILD("TPTP_literals", P_TOKEN("LBRKT ", $<ival>1), P_TOKEN("RBRKT ", $<ival>2), 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LBRKT TPTP_literal_list RBRKT {$<pval>$ = P_BUILD("TPTP_literals", P_TOKEN("LBRKT ", $<ival>1), $<pval>2, P_TOKEN("RBRKT ", $<ival>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

TPTP_literal_list   : TPTP_literal {$<pval>$ = P_BUILD("TPTP_literal_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TPTP_literal COMMA TPTP_literal_list {$<pval>$ = P_BUILD("TPTP_literal_list", $<pval>1, P_TOKEN("COMMA ", $<ival>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

TPTP_literal : TPTP_sign atomic_formula {$<pval>$ = P_BUILD("TPTP_literal", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

TPTP_sign : PLUS_PLUS {$<pval>$ = P_BUILD("TPTP_sign", P_TOKEN("PLUS_PLUS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | MINUS_MINUS {$<pval>$ = P_BUILD("TPTP_sign", P_TOKEN("MINUS_MINUS ", $<ival>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

