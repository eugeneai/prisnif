#!/bin/csh -f

# Goal for this script is to extract lines that belong in the lexical analyzer.
#
# Meta-symbols ::= :== ::- ::: were replaced with _GRR _GRS _TRT _TRM resp.
# _GR[RS] denotes "grammar rule" and _TR[TM] denotes "token rule".
# _GRR is "relaxed" grammar rule, actually being parsed.
# _TRT is token rule defining a token; _TRM defines a macro for other tokens.
#
# Self-defining tokens are those that appear literally on the right side
# of some grammar rule.
# If their strings have any letters, their token names are based on
# _LIT_string.  Exception: Beginning $, then letters goes to _DLR_string.
# _LIT_ is stripped or _DLR_ is replaced by [$] to recover string from
# token name later, so the transforms must be inverses of each other.
# If their strings are known symbols or symbol sequences, their token names
# are the symbols, spelled out in capital letters, separated by underscore.
# A nonterminal name could conceivably clash with such a token name.
# token-xref.csh helps to keep in sync with tptp-trans.csh.

if ($#argv != 1) then
	echo Usage: $0 tptp-1.txt  '   creates tptp-1.lex0'
	exit $#argv
	endif

# We need echo to collapse \\ to \.  Sadly, this is not standard.
set thisOS = `uname -s`
set ECHO = echo
if ($thisOS == Linux) set ECHO = (/bin/echo -e)
if ($thisOS == SunOs) set ECHO = (/bin/echo)

setenv LANG C
set inr = $1:r
set outlex = $inr.lex0
set outy = $inr.y0

$ECHO '' > $outlex
$ECHO '%{' >> $outlex
$ECHO '#include <string.h>' >> $outlex
$ECHO '#include <stdlib.h>' >> $outlex
$ECHO '#include "y.tab.h"' >> $outlex
$ECHO '' >> $outlex
$ECHO '#define TPTP_STORE_SIZE 32768' >> $outlex
$ECHO '/* Compile with -DP_VERBOSE=2 to list tokens as they are seen. */' >> $outlex
$ECHO '#ifndef P_VERBOSE' >> $outlex
$ECHO '#  define P_VERBOSE 0' >> $outlex
$ECHO '#  endif' >> $outlex
$ECHO 'int verbose2 = P_VERBOSE;' >> $outlex
$ECHO 'extern int tptp_store_size;' >> $outlex
$ECHO 'extern char* tptp_lval[];' >> $outlex
$ECHO 'int tptp_store_size = TPTP_STORE_SIZE;' >> $outlex
$ECHO '/* If tptp_prev_tok == PERIOD, you are outside any sentence.*/' >> $outlex
$ECHO '#ifndef PERIOD' >> $outlex
$ECHO '#  define PERIOD 46' >> $outlex
$ECHO '#  endif' >> $outlex
$ECHO 'int tptp_prev_tok = PERIOD;' >> $outlex
$ECHO 'int tptp_next_store = 0;' >> $outlex
$ECHO 'char* tptp_lval[TPTP_STORE_SIZE];' >> $outlex
$ECHO 'void tptp_print_tok(char* lval);' >> $outlex
$ECHO 'int tptp_update_lval(char* lval);' >> $outlex
$ECHO 'int tptp_update_lval(char* lval)' >> $outlex
$ECHO '  { int next = tptp_next_store;' >> $outlex
$ECHO '    free(tptp_lval[tptp_next_store]);' >> $outlex
$ECHO '    tptp_lval[tptp_next_store] = strdup(lval);' >> $outlex
$ECHO '    tptp_next_store = (tptp_next_store+1)%TPTP_STORE_SIZE;' >> $outlex
$ECHO '    if (verbose2==2) tptp_print_tok(lval);' >> $outlex
$ECHO '    return next; }' >> $outlex
$ECHO '' >> $outlex
$ECHO 'void tptp_print_tok(char* lval)' >> $outlex
$ECHO '  { printf("%3d:%s;\\n", tptp_prev_tok, lval);' >> $outlex
$ECHO '    return; }' >> $outlex
$ECHO '' >> $outlex
$ECHO '/* %Start: INITIAL begin sentence, B before formula. No others. */' >> $outlex
$ECHO '%}' >> $outlex
# Output definitions for lex next.

cat $1 | \
awk '/[ ][.][.][.]/{next;} $2 ~ "^_TR" {L=length($1); z=substr($1,2,L-2); y=$0; sub("^.* _TR. *", "",y); printf "%-20s", z; print "   ", y; next;}' | \
cat >> $outlex


$ECHO '%Start B FF SQ1 SQ2 Q1 Q2' >> $outlex
$ECHO '%%' >> $outlex
$ECHO '' >> $outlex
# Rules for lex next; all tokens should appear in yacc file (maybe future)
# Only self-defining tokens that appear on the right side of a
# relaxed grammar rule (_GRR) will have lex rules set up for them in this pass.

cat $1 | \
awk '$2 ~ "^_GRR" {for (i = 3; i <=NF; i++){if($i ~ "^[A-Z][A-Z0-9_]*$" || $i ~ "_LIT_[A-Za-z][A-Za-z0-9_]*$" || $i ~ "_DLR_[A-Za-z][A-Za-z0-9_]*$")print $i;}}' | \
sort -u | \
awk '/^AMPERSAND$/{print "\"&\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^AT_SIGN$/{print "\"@\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^BQUOTE$/{print "\"`\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^CARET$/{print "\"^\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^COLON$/{print "\":\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^COMMA$/{print "\",\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^DOLLAR$/{print "[$]" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^DQUOTE$/{print "[\"]" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^EQUALS$/{print "\"=\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^EXCLAMATION$/{print "\"\!\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^COLON_EQUALS$/{print "\":=\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^GREATER$/{print "\">\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LESS_EQUALS$/{print "\"<=\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LESS_EQUALS_GREATER$/{print "\"<=>\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^EQUALS_GREATER$/{print "\"=>\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LBRACE$/{print "\"{\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LBRKT$/{print "\"[\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LESS$/{print "\"<\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LPAREN$/{print "\"(\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^MINUS_GREATER$/{print "\"->\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^MINUS$/{print "\"-\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^MINUS_MINUS$/{print "\"--\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^TILDE_AMPERSAND$/{print "\"~&\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^EXCLAMATION_EQUALS$/{print "\"\!=\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^LESS_TILDE_GREATER$/{print "\"<~>\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^TILDE_VLINE$/{print "\"~|\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^PERCENT$/{print "\"%\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^PERIOD$/{print "\".\"" "    " "{BEGIN INITIAL; tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^PLUS$/{print "\"+\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^PLUS_PLUS$/{print "\"++\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^QUESTION$/{print "\"?\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^RBRACE$/{print "\"}\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^RBRKT$/{print "\"]\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^RPAREN$/{print "\")\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^SEMICOLON$/{print "\";\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^SLASH$/{print "\"/\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^SLASH_STAR$/{print "\"/*\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^SQUOTE$/{print "\"'"'"'\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^STAR$/{print "\"*\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^STAR_SLASH$/{print "\"*/\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^TILDE$/{print "\"~\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^VLINE$/{print "\"|\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^_LIT_file$/{print "\"file\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^_LIT_[fht][fho]f$/ || /^_LIT_cnf$/ || /^_LIT_include$/ {z=substr($0,6,999);print "<INITIAL>\"" z "\"" "    " "{BEGIN B; tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^_LIT_lambda$/{z=substr($0,6,999);print "\"" z "\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^_LIT_/{y=substr($0,6,999); print "\"" y "\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^_DLR_/{y=substr($0,6,999); print "\"$" y "\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
awk '/^[A-Z][A-Z_0-9]*$/{z=$0;print "\"" z "\"" "    " "{tptp_prev_tok=" $1 "; return(" $1 ");}";next;} {print;}' | \
sed -e 's/\(return([^)]*);\)/yylval.ival = tptp_update_lval(yytext); \1/' | \
cat >> $outlex


# All token rules (_TRT) go to lex, whether they are referenced or not.
# Hand-code ETC_ETC cases.
# Presently, no ETC_ETC cases.

# Use the generic rule for _TRT on non-ETC_ETC cases.
cat $1 | \
awk '/[ ][.][.][.]/{next;} $2=="_TRT" {L=length($1); z=substr($1,2,L-2); print $1, "    ", "{tptp_prev_tok=" z "; return(" z ");}";}' | \
sed -e 's/\(return([^)]*);\)/yylval.ival = tptp_update_lval(yytext); \1/' | \
cat >> $outlex


$ECHO '{comment}    tptp_update_lval(yytext);' >> $outlex
$ECHO '[ \\t\\n]    ;' >> $outlex
$ECHO '[\\000-\\040]|[\\177]    ;' >> $outlex
$ECHO '[\\041-\\176]    return(unrecognized);' >> $outlex
$ECHO '%%' >> $outlex
$ECHO '' >> $outlex

# awk '/^system_comment/{print "[ \\t\\n]" "    " ";";next;}{print;}' | \
