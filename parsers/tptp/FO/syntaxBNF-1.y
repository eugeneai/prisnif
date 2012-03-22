
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
#  define P_TOKEN(tok,sym) pToken(tok,sym)
#  define P_PRINT(ss) if(verbose){printf("\n\n");pPrintTree(ss,0);}
#endif

#define MAX_CH 10
extern int yylineno;
/* tptp_ff is just an example of lex-er interface; setting to 0 is no-op. */
extern int tptp_ff;
int verbose = P_VERBOSE;
char pTokenBuf[512];

typedef struct pTreeNode * pTree;
struct pTreeNode {char* sym; pTree ch[MAX_CH+1];};

pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,
    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J);
pTree pBuildTree(char* sym, pTree A, pTree B, pTree C, pTree D,
    pTree E, pTree F, pTree G, pTree H, pTree I, pTree J)
{ pTree ss = (pTree)calloc(1,sizeof(struct pTreeNode));
  ss->sym = sym;
  ss->ch[0] = A; ss->ch[1] = B; ss->ch[2] = C; ss->ch[3] = D;
  ss->ch[4] = E; ss->ch[5] = F; ss->ch[6] = G; ss->ch[7] = H;
  ss->ch[8] = I; ss->ch[9] = J; ss->ch[10] = 0;
  return ss; }

pTree pToken(char* tok, char* sym);
pTree pToken(char* tok, char* sym)
{ pTree ss;
  char* safeSym;
  strcpy(pTokenBuf, tok);
  strcat(pTokenBuf, sym);
  safeSym = strdup(pTokenBuf);
  ss = pBuildTree(safeSym,0,0,0,0,0,0,0,0,0,0);
  return ss; }

void pPrintTree(pTree ss, int depth);
void pPrintTree(pTree ss, int depth)
{ int i, d;
  for (d = 0; d < depth; d++) printf("  ");
  if (ss->ch[0] == 0) printf("%s\n", ss->sym); else printf("<%s>\n", ss->sym);
  i = 0;
  while(ss->ch[i] != 0) {pPrintTree(ss->ch[i], depth+1); i++;}
  return; }
%}

%union {int ival; double dval; char* sval; void* pval;}

%start  TPTP_file
%token <sval> AMPERSAND
%token <sval> CNF
%token <sval> COLON
%token <sval> COMMA
%token <sval> CREATOR
%token <sval> DDOLLAR
%token <sval> DESCRIPTION
%token <sval> EQUALS
%token <sval> EXCLAMATION
%token <sval> FOF
%token <sval> IF
%token <sval> IFF
%token <sval> IMPLIES
%token <sval> INCLUDE
%token <sval> INFERENCE
%token <sval> INTRODUCED
%token <sval> IQUOTE
%token <sval> LBRKT
%token <sval> LPAREN
%token <sval> MINUS
%token <sval> NAMPERSAND
%token <sval> NEQUALS
%token <sval> NIFF
%token <sval> NVLINE
%token <sval> PERIOD
%token <sval> PLUS
%token <sval> QUESTION
%token <sval> RBRKT
%token <sval> REFUTATION
%token <sval> RPAREN
%token <sval> STAR
%token <sval> STATUS
%token <sval> THEORY
%token <sval> TILDE
%token <sval> TOK_FALSE
%token <sval> TOK_FILE
%token <sval> TOK_TRUE
%token <sval> VLINE
%token <sval> atomic_system_word
%token <sval> comment
%token <sval> distinct_object
%token <sval> lower_word
%token <sval> real
%token <sval> signed_integer
%token <sval> single_quoted
%token <sval> system_comment
%token <sval> unrecognized
%token <sval> unsigned_integer
%token <sval> upper_word
%token <sval> AC
%token <sval> AXIOM
%token <sval> AXIOM_OF_CHOICE
%token <sval> CAX
%token <sval> CEQ
%token <sval> CONJECTURE
%token <sval> CSA
%token <sval> CSB
%token <sval> CSM
%token <sval> CSP
%token <sval> CSR
%token <sval> CTH
%token <sval> DEFINITION
%token <sval> EQUALITY
%token <sval> EQV
%token <sval> HYPOTHESIS
%token <sval> LEMMA
%token <sval> LEMMA_CONJECTURE
%token <sval> NEGATED_CONJECTURE
%token <sval> NOC
%token <sval> PLAIN
%token <sval> SAB
%token <sval> SAM
%token <sval> SAP
%token <sval> SAR
%token <sval> SAT
%token <sval> TAC
%token <sval> TAU
%token <sval> TAUTOLOGY
%token <sval> THEOREM
%token <sval> THM
%token <sval> UNC
%token <sval> UNKNOWN
%token <sval> UNS
%%

/*----Version 3.1.1.13b (TPTP version.internal development number) */
/*----Intended uses of the various parts of the TPTP syntax are explained */
/*----in the TPTP technical manual, linked from www.tptp.org. */
/*----See the  comment  entries regarding text that can be discarded before  */
/*----tokenizing for this syntax. */
/*----White space is almost irrelevant, but, for the Prolog people, all tokens */
/*----consisting of non-alphanumeric characters shuold be followed bya space. */

/*----Files. Empty file is OK. */
TPTP_file           :  null {}
                    | TPTP_file TPTP_input {}
                    ;

TPTP_input          :  annotated_formula  {P_PRINT($<pval>$);}
                    |  include  {P_PRINT($<pval>$);}
                    | comment  {P_PRINT(P_TOKEN("comment ", $<sval>1));}
                    |  system_comment  {P_PRINT(P_TOKEN("system_comment ", $<sval>1));}
                    ;


/*----Formula records */
annotated_formula   :  fof_annotated  {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  cnf_annotated  {$<pval>$ = P_BUILD("annotated_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Future languages may include ...  english | efof | tfof | mathml | ... */
fof_annotated       : FOF LPAREN  name  COMMA  formula_role  COMMA  fof_formula  annotations  RPAREN  PERIOD  {$<pval>$ = P_BUILD("fof_annotated", P_TOKEN("FOF ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("COMMA ", $<sval>4), $<pval>5, P_TOKEN("COMMA ", $<sval>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<sval>9), P_TOKEN("PERIOD ", $<sval>10));}
                    ;

cnf_annotated       : CNF LPAREN  name  COMMA  formula_role  COMMA  cnf_formula  annotations  RPAREN  PERIOD  {$<pval>$ = P_BUILD("cnf_annotated", P_TOKEN("CNF ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("COMMA ", $<sval>4), $<pval>5, P_TOKEN("COMMA ", $<sval>6), $<pval>7, $<pval>8, P_TOKEN("RPAREN ", $<sval>9), P_TOKEN("PERIOD ", $<sval>10));}
                    ;

annotations         :  null  {$<pval>$ = P_BUILD("annotations", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  COMMA  source  {$<pval>$ = P_BUILD("annotations", P_TOKEN("COMMA ", $<sval>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  COMMA  source  COMMA  useful_info  {$<pval>$ = P_BUILD("annotations", P_TOKEN("COMMA ", $<sval>1), $<pval>2, P_TOKEN("COMMA ", $<sval>3), $<pval>4, 0, 0, 0, 0, 0, 0);}
                    ;


/*----Types for problems. */
/*----Note: The previous  source_type  from ... */
/*----    formula_role  ::=  user_role - source   */
/*----... is now gone. Parsers may choose to be tolerant of it for backwards  */
/*----compatibility. */
formula_role        : lower_word {$<pval>$ = P_BUILD("formula_role", P_TOKEN("lower_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

formula_role_strict : AXIOM {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("AXIOM ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | HYPOTHESIS {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("HYPOTHESIS ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | DEFINITION {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("DEFINITION ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LEMMA {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("LEMMA ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | THEOREM {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("THEOREM ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CONJECTURE {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("CONJECTURE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LEMMA_CONJECTURE {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("LEMMA_CONJECTURE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | NEGATED_CONJECTURE {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("NEGATED_CONJECTURE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | PLAIN {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("PLAIN ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | UNKNOWN {$<pval>$ = P_BUILD("formula_role_strict", P_TOKEN("UNKNOWN ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----"axiom"s are accepted, without proof, as a basis for proving "conjecture"s  */
/*----and "lemma_conjecture"s in FOF problems. In CNF problems "axiom"s are  */
/*----accepted as part of the set whose satisfiability has to be established. */
/*----There is no guarantee that the axioms of a problem are consistent. */
/*----"hypothesis"s are assumed to be true for a particular problem, and are  */
/*----used like "axiom"s. */
/*----"definition"s are used to define symbols, and are used like "axiom"s. */
/*----"lemma"s and "theorem"s have been proven from the "axiom"s, can be used  */
/*----like "axiom"s, but are redundant wrt the "axiom"s. "lemma" is used as the  */
/*----role of proven "lemma_conjecture"s, and "theorem" is used as the role of  */
/*----proven "conjecture"s, in output. A problem containing a "lemma" or  */
/*----"theorem" that is not redundant wrt the "axiom"s is ill-formed. "theorem"s */
/*----are more important than "lemma"s from the user perspective. */
/*----"conjecture"s occur in only FOF problems, and are to all be proven from  */
/*----the "axiom"(-like) formulae. A problem is solved only when all  */
/*----"conjecture"s are proven. */
/*----"lemma_conjecture"s are expected to be provable, and may be useful to  */
/*----prove, while proving "conjecture"s. */
/*----"negated_conjecture"s ocuur in only CNF problems, and are formed from */
/*----negation of a "conjecture" in a FOF to CNF conversion. */
/*----"plain"s have no special user semantics, and can be used like "axiom"s. */
/*----"unknown"s have unknown role, and this is an error situation. */

/*----FOF formulae. All formulae must be closed. */
fof_formula         :  binary_formula  {$<pval>$ = P_BUILD("fof_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0); tptp_ff = 0;}
                    |  unitary_formula  {$<pval>$ = P_BUILD("fof_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0); tptp_ff = 0;}
                    ;

binary_formula      :  nonassoc_binary  {$<pval>$ = P_BUILD("binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  assoc_binary  {$<pval>$ = P_BUILD("binary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Only some binary connectives are associative */
/*----There's no precedence amoung binary connectives */
nonassoc_binary     :  unitary_formula   binary_connective   unitary_formula  {$<pval>$ = P_BUILD("nonassoc_binary", $<pval>1, $<pval>2, $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

binary_connective   : IFF {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("IFF ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | IMPLIES {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("IMPLIES ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | IF {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("IF ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | NIFF {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("NIFF ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | NVLINE  {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("NVLINE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | NAMPERSAND {$<pval>$ = P_BUILD("binary_connective", P_TOKEN("NAMPERSAND ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Associative connectives & and | are in  assoc_binary  */
assoc_binary        :  or_formula  {$<pval>$ = P_BUILD("assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  and_formula  {$<pval>$ = P_BUILD("assoc_binary", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

or_formula          : unitary_formula VLINE unitary_formula {$<pval>$ = P_BUILD("or_formula", $<pval>1, P_TOKEN("VLINE ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | unitary_formula VLINE or_formula {$<pval>$ = P_BUILD("or_formula", $<pval>1, P_TOKEN("VLINE ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

and_formula         : unitary_formula AMPERSAND unitary_formula {$<pval>$ = P_BUILD("and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    | unitary_formula AMPERSAND and_formula {$<pval>$ = P_BUILD("and_formula", $<pval>1, P_TOKEN("AMPERSAND ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*---- unitary_formula  are in ()s or do not have a  binary_connective  at the  */
/*----top level. */
unitary_formula     :  quantified_formula  {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  unary_formula  {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | LPAREN  fof_formula  RPAREN  {$<pval>$ = P_BUILD("unitary_formula", P_TOKEN("LPAREN ", $<sval>1), $<pval>2, P_TOKEN("RPAREN ", $<sval>3), 0, 0, 0, 0, 0, 0, 0);}
                    |  atomic_formula  {$<pval>$ = P_BUILD("unitary_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

quantified_formula  :  quantifier   LBRKT  variable_list  RBRKT  COLON  unitary_formula  {$<pval>$ = P_BUILD("quantified_formula", $<pval>1, P_TOKEN("LBRKT ", $<sval>2), $<pval>3, P_TOKEN("RBRKT ", $<sval>4), P_TOKEN("COLON ", $<sval>5), $<pval>6, 0, 0, 0, 0);}
                    ;

quantifier          :  EXCLAMATION  {$<pval>$ = P_BUILD("quantifier", P_TOKEN("EXCLAMATION ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  QUESTION  {$<pval>$ = P_BUILD("quantifier", P_TOKEN("QUESTION ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----! is universal quantification and ? is existential. Syntactically, the  */
/*----quantification is the left operand of :, and the  unitary_formula  is  */
/*----the right operand. Although : is a binary operator syntactically, it is  */
/*----not a  binary_connective , and thus a  quantified_formula  is a  */
/*---- unitary_formula . */
/*----Universal   example: ! [X,Y] : ((p(X) & p(Y)) => q(X,Y)). */
/*----Existential example: ? [X,Y] : (p(X) & p(Y)) & ~ q(X,Y). */
/*----Quantifiers have higher precedence than binary connectives, so in */
/*----the existential example the quantifier applies to only (p(X) & p(Y)). */
variable_list       :  variable  {$<pval>$ = P_BUILD("variable_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  variable  COMMA  variable_list  {$<pval>$ = P_BUILD("variable_list", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Future variables may have sorts and existential counting */
/*----Unary connectives bind more tightly than binary */
unary_formula       :  unary_connective   unitary_formula  {$<pval>$ = P_BUILD("unary_formula", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

unary_connective    :  TILDE  {$<pval>$ = P_BUILD("unary_connective", P_TOKEN("TILDE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----CNF formulae (variables implicitly universally quantified) */
cnf_formula         :  LPAREN  disjunction  RPAREN  {$<pval>$ = P_BUILD("cnf_formula", P_TOKEN("LPAREN ", $<sval>1), $<pval>2, P_TOKEN("RPAREN ", $<sval>3), 0, 0, 0, 0, 0, 0, 0); tptp_ff = 0;}
                    |  disjunction  {$<pval>$ = P_BUILD("cnf_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0); tptp_ff = 0;}
                    ;

disjunction         : literal {$<pval>$ = P_BUILD("disjunction", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | literal VLINE disjunction {$<pval>$ = P_BUILD("disjunction", $<pval>1, P_TOKEN("VLINE ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

literal             :  atomic_formula  {$<pval>$ = P_BUILD("literal", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  TILDE   atomic_formula  {$<pval>$ = P_BUILD("literal", P_TOKEN("TILDE ", $<sval>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----Atoms ( predicate  is not used currently) */
atomic_formula      :  plain_atom  {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  defined_atom  {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  system_atom  {$<pval>$ = P_BUILD("atomic_formula", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

plain_atom          :  plain_term  {$<pval>$ = P_BUILD("plain_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----A  plain_atom  looks like a  plain_term , but really we mean */
/*----   plain_atom          ::=  proposition  |  predicate ( arguments ) */
/*----   proposition         ::=  atomic_word  */
/*----   predicate           ::=  atomic_word  */
/*----Using  plain_term  removes a reduce/reduce ambiguity in lex/yacc. */
arguments           :  term  {$<pval>$ = P_BUILD("arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  term  COMMA  arguments  {$<pval>$ = P_BUILD("arguments", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

defined_atom        : TOK_TRUE {$<pval>$ = P_BUILD("defined_atom", P_TOKEN("TOK_TRUE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TOK_FALSE {$<pval>$ = P_BUILD("defined_atom", P_TOKEN("TOK_FALSE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | term  EQUALS   term  {$<pval>$ = P_BUILD("defined_atom", $<pval>1, P_TOKEN("EQUALS ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    |  term  NEQUALS   term  {$<pval>$ = P_BUILD("defined_atom", $<pval>1, P_TOKEN("NEQUALS ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Some systems still interprete equal/2 as equality. The use of equal/2 */
/*----for other purposes is therefore discouraged. Please refrain from either  */
/*----use. Use infix '=' for equality. Note:  term  !=  term  is equivalent */
/*----to ~  term  =  term  */
/*----More defined atoms may be added in the future. */
system_atom         :  system_term  {$<pval>$ = P_BUILD("system_atom", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*---- system_atom s are used for evaluable predicates that are available */
/*----in particular tools. The predicate names are not controlled by the */
/*----TPTP syntax, so use with due care. The same is true for  system_term s. */

/*----Terms */
term                :  function_term  {$<pval>$ = P_BUILD("term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  variable  {$<pval>$ = P_BUILD("term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

function_term       :  plain_term  {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  defined_term  {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  system_term  {$<pval>$ = P_BUILD("function_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

plain_term          :  constant  {$<pval>$ = P_BUILD("plain_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  functor  LPAREN  arguments  RPAREN  {$<pval>$ = P_BUILD("plain_term", $<pval>1, P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

constant            :  atomic_word  {$<pval>$ = P_BUILD("constant", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

functor             :  atomic_word  {$<pval>$ = P_BUILD("functor", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*---- numbers s and  distinct_object s are always interpreted as themselves */
defined_term        :  number  {$<pval>$ = P_BUILD("defined_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  distinct_object  {$<pval>$ = P_BUILD("defined_term", P_TOKEN("distinct_object ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_term         :  system_constant  {$<pval>$ = P_BUILD("system_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  system_functor  LPAREN  arguments  RPAREN  {$<pval>$ = P_BUILD("system_term", $<pval>1, P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

system_functor      :  atomic_system_word  {$<pval>$ = P_BUILD("system_functor", P_TOKEN("atomic_system_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

system_constant     :  atomic_system_word  {$<pval>$ = P_BUILD("system_constant", P_TOKEN("atomic_system_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

variable            :  upper_word  {$<pval>$ = P_BUILD("variable", P_TOKEN("upper_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----Formula sources */
source              : general_term {$<pval>$ = P_BUILD("source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

source_strict :  dag_source  {$<pval>$ = P_BUILD("source_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  internal_source  {$<pval>$ = P_BUILD("source_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  external_source {$<pval>$ = P_BUILD("source_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Only a  dag_source  can be a  name , i.e., derived formulae can be */
/*----identified by a  name  or an  inference_record   */
dag_source          :  name  {$<pval>$ = P_BUILD("dag_source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  inference_record  {$<pval>$ = P_BUILD("dag_source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

inference_record    : INFERENCE LPAREN  inference_rule  COMMA  useful_info  COMMA  LBRKT  parent_info_list  RBRKT  RPAREN  {$<pval>$ = P_BUILD("inference_record", P_TOKEN("INFERENCE ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("COMMA ", $<sval>4), $<pval>5, P_TOKEN("COMMA ", $<sval>6), P_TOKEN("LBRKT ", $<sval>7), $<pval>8, P_TOKEN("RBRKT ", $<sval>9), P_TOKEN("RPAREN ", $<sval>10));}
                    ;

inference_rule      :  atomic_word  {$<pval>$ = P_BUILD("inference_rule", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Examples are        deduction | modus_tollens | modus_ponens | rewrite |  */
/*                        resolution | paramodulation | factorization |  */
/*                        cnf_conversion | cnf_refutation | ... */
parent_info_list    :  parent_info  {$<pval>$ = P_BUILD("parent_info_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  parent_info  COMMA  parent_info_list  {$<pval>$ = P_BUILD("parent_info_list", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

parent_info         :  source  parent_details  {$<pval>$ = P_BUILD("parent_info", $<pval>1, $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

theory              : THEORY LPAREN  theory_name  RPAREN  {$<pval>$ = P_BUILD("theory", P_TOKEN("THEORY ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

theory_name         : lower_word {$<pval>$ = P_BUILD("theory_name", P_TOKEN("lower_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

theory_name_strict  : EQUALITY {$<pval>$ = P_BUILD("theory_name_strict", P_TOKEN("EQUALITY ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | AC {$<pval>$ = P_BUILD("theory_name_strict", P_TOKEN("AC ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----More theory names may be added in the future. */
parent_details      : COLON atomic_word  {$<pval>$ = P_BUILD("parent_details", P_TOKEN("COLON ", $<sval>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  null  {$<pval>$ = P_BUILD("parent_details", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

internal_source     : INTRODUCED LPAREN  intro_type  intro_info  RPAREN  {$<pval>$ = P_BUILD("internal_source", P_TOKEN("INTRODUCED ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, $<pval>4, P_TOKEN("RPAREN ", $<sval>5), 0, 0, 0, 0, 0);}
                    ;

intro_type          : lower_word {$<pval>$ = P_BUILD("intro_type", P_TOKEN("lower_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

intro_type_strict   : DEFINITION {$<pval>$ = P_BUILD("intro_type_strict", P_TOKEN("DEFINITION ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | AXIOM_OF_CHOICE {$<pval>$ = P_BUILD("intro_type_strict", P_TOKEN("AXIOM_OF_CHOICE ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TAUTOLOGY {$<pval>$ = P_BUILD("intro_type_strict", P_TOKEN("TAUTOLOGY ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----This should be used to record the symbol being defined, or the function */
/*----for the axiom of choice */
intro_info          :  COMMA  useful_info  {$<pval>$ = P_BUILD("intro_info", P_TOKEN("COMMA ", $<sval>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  null  {$<pval>$ = P_BUILD("intro_info", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

external_source     :  file_source  {$<pval>$ = P_BUILD("external_source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  creator_source  {$<pval>$ = P_BUILD("external_source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  theory  {$<pval>$ = P_BUILD("external_source", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

file_source         : TOK_FILE LPAREN  file_name  COMMA  file_node_name  RPAREN  {$<pval>$ = P_BUILD("file_source", P_TOKEN("TOK_FILE ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("COMMA ", $<sval>4), $<pval>5, P_TOKEN("RPAREN ", $<sval>6), 0, 0, 0, 0);}
                    ;

file_name           :  atomic_word  {$<pval>$ = P_BUILD("file_name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

file_node_name      :  name {$<pval>$ = P_BUILD("file_node_name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

creator_source      : CREATOR LPAREN  creator_name  creator_info  RPAREN  {$<pval>$ = P_BUILD("creator_source", P_TOKEN("CREATOR ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, $<pval>4, P_TOKEN("RPAREN ", $<sval>5), 0, 0, 0, 0, 0);}
                    ;

creator_name        :  atomic_word  {$<pval>$ = P_BUILD("creator_name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

creator_info        :  COMMA  useful_info  {$<pval>$ = P_BUILD("creator_info", P_TOKEN("COMMA ", $<sval>1), $<pval>2, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  null  {$<pval>$ = P_BUILD("creator_info", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----Useful info fields */
useful_info         :  LBRKT  RBRKT  {$<pval>$ = P_BUILD("useful_info", P_TOKEN("LBRKT ", $<sval>1), P_TOKEN("RBRKT ", $<sval>2), 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  LBRKT  info_items  RBRKT  {$<pval>$ = P_BUILD("useful_info", P_TOKEN("LBRKT ", $<sval>1), $<pval>2, P_TOKEN("RBRKT ", $<sval>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

info_items          :  info_item  {$<pval>$ = P_BUILD("info_items", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  info_item  COMMA  info_items  {$<pval>$ = P_BUILD("info_items", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

info_item           : general_term {$<pval>$ = P_BUILD("info_item", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

info_item_strict :  formula_item  {$<pval>$ = P_BUILD("info_item_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  inference_item  {$<pval>$ = P_BUILD("info_item_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  general_function  {$<pval>$ = P_BUILD("info_item_strict", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----Useful info for formula records */
formula_item        :  description_item  {$<pval>$ = P_BUILD("formula_item", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  iquote_item   {$<pval>$ = P_BUILD("formula_item", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

description_item    : DESCRIPTION LPAREN  atomic_word  RPAREN  {$<pval>$ = P_BUILD("description_item", P_TOKEN("DESCRIPTION ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

iquote_item         : IQUOTE LPAREN  atomic_word  RPAREN  {$<pval>$ = P_BUILD("iquote_item", P_TOKEN("IQUOTE ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

/*----Useful info for inference records */
inference_item      :  inference_status  {$<pval>$ = P_BUILD("inference_item", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  refutation  {$<pval>$ = P_BUILD("inference_item", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

inference_status    : STATUS LPAREN  status_value  RPAREN  {$<pval>$ = P_BUILD("inference_status", P_TOKEN("STATUS ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

/*----These are the status values from the SZS ontology */
status_value        : lower_word {$<pval>$ = P_BUILD("status_value", P_TOKEN("lower_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

status_value_strict : TAU {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("TAU ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | TAC {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("TAC ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | EQV {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("EQV ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | THM {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("THM ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | SAT {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("SAT ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CAX {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CAX ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | NOC {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("NOC ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CSA {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CSA ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CTH {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CTH ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CEQ {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CEQ ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | UNC {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("UNC ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | UNS {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("UNS ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | SAB {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("SAB ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | SAM {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("SAM ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | SAR {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("SAR ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | SAP {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("SAP ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CSP {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CSP ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CSR {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CSR ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CSM {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CSM ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    | CSB {$<pval>$ = P_BUILD("status_value_strict", P_TOKEN("CSB ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

inference_info      :  inference_rule  LPAREN  atomic_word  COMMA  general_list  RPAREN  {$<pval>$ = P_BUILD("inference_info", $<pval>1, P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("COMMA ", $<sval>4), $<pval>5, P_TOKEN("RPAREN ", $<sval>6), 0, 0, 0, 0);}
                    ;

refutation          : REFUTATION LPAREN  file_source  RPAREN  {$<pval>$ = P_BUILD("refutation", P_TOKEN("REFUTATION ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

/*----Useful info for creators is just  general_function  */

/*----Include directives */
include             : INCLUDE LPAREN  file_name  formula_selection  RPAREN  PERIOD  {$<pval>$ = P_BUILD("include", P_TOKEN("INCLUDE ", $<sval>1), P_TOKEN("LPAREN ", $<sval>2), $<pval>3, $<pval>4, P_TOKEN("RPAREN ", $<sval>5), P_TOKEN("PERIOD ", $<sval>6), 0, 0, 0, 0);}
                    ;

formula_selection   :  null  {$<pval>$ = P_BUILD("formula_selection", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  COMMA  LBRKT  name_list  RBRKT  {$<pval>$ = P_BUILD("formula_selection", P_TOKEN("COMMA ", $<sval>1), P_TOKEN("LBRKT ", $<sval>2), $<pval>3, P_TOKEN("RBRKT ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

name_list           :  name  {$<pval>$ = P_BUILD("name_list", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  name  COMMA  name_list  {$<pval>$ = P_BUILD("name_list", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----General purpose */
general_term        :  general_function  {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  general_list  {$<pval>$ = P_BUILD("general_term", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_list        :  LBRKT  RBRKT  {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<sval>1), P_TOKEN("RBRKT ", $<sval>2), 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  LBRKT  general_arguments  RBRKT  {$<pval>$ = P_BUILD("general_list", P_TOKEN("LBRKT ", $<sval>1), $<pval>2, P_TOKEN("RBRKT ", $<sval>3), 0, 0, 0, 0, 0, 0, 0);}
                    ;

general_function    :  constant  {$<pval>$ = P_BUILD("general_function", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  functor  LPAREN  general_arguments  RPAREN  {$<pval>$ = P_BUILD("general_function", $<pval>1, P_TOKEN("LPAREN ", $<sval>2), $<pval>3, P_TOKEN("RPAREN ", $<sval>4), 0, 0, 0, 0, 0, 0);}
                    ;

general_arguments   :  general_term  {$<pval>$ = P_BUILD("general_arguments", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  general_term  COMMA  general_arguments  {$<pval>$ = P_BUILD("general_arguments", $<pval>1, P_TOKEN("COMMA ", $<sval>2), $<pval>3, 0, 0, 0, 0, 0, 0, 0);}
                    ;

/*----The following are reserved  name s: unknown file inference creator */
name                :  atomic_word  {$<pval>$ = P_BUILD("name", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  unsigned_integer  {$<pval>$ = P_BUILD("name", P_TOKEN("unsigned_integer ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

atomic_word         :  lower_word  {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("lower_word ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  single_quoted  {$<pval>$ = P_BUILD("atomic_word", P_TOKEN("single_quoted ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

null                : {$<pval>$ = P_BUILD("null", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*----All numbers are implicitly distinct */
number              :  real  {$<pval>$ = P_BUILD("number", P_TOKEN("real ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  integer  {$<pval>$ = P_BUILD("number", $<pval>1, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;

integer             :  signed_integer  {$<pval>$ = P_BUILD("integer", P_TOKEN("signed_integer ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    |  unsigned_integer  {$<pval>$ = P_BUILD("integer", P_TOKEN("unsigned_integer ", $<sval>1), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
                    ;


/*------------------------------------------------------------------------------ */
/*----Rules from here on down are for building tokens in the lexer. */

/*----System Comments are used for system specific annotation of anything. */
/*----They look like comments (see next), so by default they are discarded. */
/*----However, a wily user of the syntax can notice the $$ and store/extract */
/*----information from the "comment". */
/*----System specific annotations should begin $$, then identify the system, */
/*----followed by a :, e.g., /*$$Otter 3.3: Demodulator */
/*----Comments. These may be retained for non-logical purposes. Comments */
/*----can occur only between annotated formulae (see  TPTP_input ), but */
/*----it seems likely that people will put them elsewhere and simply */
/*----strip them before tokenising. */
/*----A string that matches both  system_comment  and  comment  should be */
/*----recognized as  system_comment . */

/*----\ is used as the escape character for ' and \, i.e., \' is  a quote and */
/*----\\ is a backslash. For input and output in TPTP syntax the \ is printed. */
/*----All  distinct_object  are implicitly distinct.  */
/*----\ is used as the escape character for " and \, i.e., \" is  a quote and */
/*----\\ is a backslash. For input and output in TPTP syntax the \ is printed. */

