#!/bin/csh -f

# Goal for this script is to
# Replace meta-symbols ::= :== ::- ::: with _GRR _GRS _TRT _TRM respectively.
# _GR[RS] denotes "grammar rule" and _TR[TM] denotes "token rule".
#
# Remove <> from nonterminal symbols.
# Remove <> from remaining token symbols on right side of a grammar rule.
# Replace <> around token/macro symbols by {} in a token rule; this script
# allows for at most 5 such replacements on the right side of one _TR[TM].
# Also put continuations all on one line.
# Also separate [ x y * ] into [ x_list ] then x_list :?= x y * on next line,
# in grammar rules (but not in token rules).
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

if ($#argv != 1) then
	echo Usage: $0 tptp-bnf.txt  ' > tptp-1.txt'
	exit $#argv
	endif

setenv LANG C
cat $1 | \
awk '/^\/\*/{print;next;} {gsub(" ::="," _GRR ");gsub(" :=="," _GRS ");gsub(" ::-"," _TRT ");gsub(" :::"," _TRM ");print;}' | \
awk '/^\/\*/{if(s!="")print s;s="";print;next;} /^ *$/{if(s!="")print s;s="";print;next;} $2 ~ "^_[GT]R[RSTM]$" {if(s!="")print s;s=$0;next;} {sub("  *"," ");s=s $0;next;} END{if(s!="")print s;}' | \
awk '$2 ~ "^_GR" {gsub(">[*]", "> *");gsub("><", "> <");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[[]", " [ ");gsub("]"," ] ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[(]", " ( ");gsub("[)]"," ) ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[{]", " { ");gsub("[}]"," } ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("\"",      " \" ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("'"'"'",   " '"'"' ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[`]",     " ` ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(",",       " , ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(";",       " ; ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {for(i=3;i<=NF;i++){if($i=="file"){sub($i,"_LIT_file",$i)} if($i ~ "^[A-Za-z][A-Za-z0-9_]*$"){z="_LIT_" $i;sub($i,z,$i);} if($i ~ "^[$][A-Za-z][A-Za-z0-9_]*$"){sub("^[$]","_DLR_",$i);} }print $0;next;} {print;}' | \
awk '$2 ~ "^_GR" {gsub("[.][.][.]", " ETC_ETC ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<=>",     " LESS_EQUALS_GREATER ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<~>",     " LESS_TILDE_GREATER ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("~[&]",    " TILDE_AMPERSAND ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("~<vline>", " TILDE_VLINE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("=>",      " EQUALS_GREATER ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("->",      " MINUS_GREATER ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<=",      " LESS_EQUALS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("\!=",     " EXCLAMATION_EQUALS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(":=",      " COLON_EQUALS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("==",      " EQUALS_EQUALS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[+][+]",  " PLUS_PLUS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[-][-]",  " MINUS_MINUS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("/<star>", " SLASH_STAR ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<star>/", " STAR_SLASH ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("=",       " EQUALS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(":",       " COLON ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[@]",     " AT_SIGN ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(";",       " SEMICOLON ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("%",       " PERCENT ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[&]",     " AMPERSAND ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<vline>", " VLINE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[\!]",    " EXCLAMATION ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[?]",     " QUESTION ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[\\^]",   " CARET ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[~]",     " TILDE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[+]",     " PLUS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[-]",     " MINUS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[/]",     " SLASH ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("<star>",  " STAR ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("\"",      " DQUOTE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("'"'"'",   " SQUOTE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[`]",     " BQUOTE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub(",",       " COMMA ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[.]",     " PERIOD ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[[]", " LBRKT ");gsub("]"," RBRKT ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[(]", " LPAREN ");gsub("[)]"," RPAREN ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[{]", " LBRACE ");gsub("[}]"," RBRACE ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {for(i=1;i<=NF;i++){if($i ~ "^<[A-Za-z][A-Za-z0-9_]*>$"){sub("<","",$i);sub(">","",$i);} }print $0;next;} {print;}' | \
sed -e 's/\( _TR[MT] .*\)<\([A-Za-z][A-Za-z0-9_]*\)>/\1{\2}/' | \
sed -e 's/\( _TR[MT] .*\)<\([A-Za-z][A-Za-z0-9_]*\)>/\1{\2}/' | \
sed -e 's/\( _TR[MT] .*\)<\([A-Za-z][A-Za-z0-9_]*\)>/\1{\2}/' | \
sed -e 's/\( _TR[MT] .*\)<\([A-Za-z][A-Za-z0-9_]*\)>/\1{\2}/' | \
sed -e 's/\( _TR[MT] .*\)<\([A-Za-z][A-Za-z0-9_]*\)>/\1{\2}/' | \
awk '$2 ~ "^_TR[MT]" {if($1 ~ "<[A-Za-z][A-Za-z0-9_]*>"){gsub("<","{",$1);gsub(">","}",$1);} print $0;next;} {print;}' | \
awk '$2 ~ "^_GR" {gsub("[>]",     " GREATER ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[<]",     " LESS ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" {gsub("[$]",     " DOLLAR ");print;next;}{print;}' | \
awk '$2 ~ "^_GR" && /LBRKT .* \* *RBRKT/ {for (i=1;i<=NF;i++){if($i=="LBRKT")j=i+1;if($i=="RBRKT")k=i-1;} z=$0;sub(" " $j " .*\\*"," " $j "_list", z);print z;y="";for(i=j;i<=k;i++)y=y " "$i; print $j "_list    " $2 " " y; next;}{print;}' | \
cat | \
cat
