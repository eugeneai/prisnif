#!/bin/csh -f

# Goal for this script is to extract lines that belong in the lexical analyzer.

if ($#argv != 1) then
	echo Usage: $0 tptp-1.txt  '   creates tptp-1.lex0'
	exit $#argv
	endif

# We need echo to collapse \\ to \.  Sadly, this is not standard.
set thisOS = `uname -s`
set ECHO = echo
if ($thisOS == Linux) set ECHO = (/bin/echo -e)
if ($thisOS == SunOs) set ECHO = (/bin/echo)

set inr = $1:r
set outlex = $inr.lex0
set outy = $inr.y0

$ECHO '' > $outlex
$ECHO '%{' >> $outlex
$ECHO '#include <string.h>' >> $outlex
$ECHO '#include "y.tab.h"' >> $outlex
$ECHO '' >> $outlex
$ECHO 'extern int tptp_ff;' >> $outlex
$ECHO 'int tptp_ff = 0;' >> $outlex
$ECHO '/* %Start: INITIAL begin sentence, B before formula, FF formula finished. */' >> $outlex
$ECHO '/* For now, FF is unreachable; tptp_ff always 0; example only. */'  >> $outlex
$ECHO '%}' >> $outlex
# Output definitions for lex next.

$ECHO '%Start B FF' >> $outlex
$ECHO '%%' >> $outlex
$ECHO '' >> $outlex
# Rules for lex next; all tokens should appear in yacc file (maybe future)
# Values of enumerated types are are lexed as lower_word, but tokens
# might be created for them.

cat $1 | \
egrep -v '^/\*' | \
egrep -v '^(formula_role|source |theory_name|intro_type|file_node_name|status_value)' | \
awk '{for (i = 1; i <=NF; i++)print $i;}' | \
sort -u | \
awk '/[A-Z][A-Z_][A-Z_]*$/' | \
egrep -v '^(ASCII|CHAR|DQUOTE|ETC_ETC|PERCENT|SLASHSTAR|SQUOTE|STARSLASH)' | \
awk '/^AMPERSAND$/{print "\"&\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^AT_SIGN$/{print "\"@\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^CARET$/{print "\"^\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^GREATER$/{print "\">\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^CHAR$/{print "." "    " "return(" $1 ");";next;} {print;}' | \
awk '/^COLON$/{print "\":\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^COMMA$/{print "\",\"" "    " "{if (tptp_ff){BEGIN FF;} return(" $1 ");}";next;} {print;}' | \
awk '/^DDOLLAR$/{print "\"$$\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^DQUOTE$/{print "[\"]" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^EQUALS$/{print "\"=\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^EXCLAMATION$/{print "\"\!\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^IFF$/{print "\"<=>\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^IMPLIES$/{print "\"=>\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^MAP_TO$/{print "\"->\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^IF$/{print "\"<=\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^NIFF$/{print "\"<~>\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^LBRKT$/{print "\"[\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^LPAREN$/{print "\"(\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^MINUS$/{print "\"-\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^MINUSMINUS$/{print "\"--\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^NAMPERSAND$/{print "\"~&\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^NEQUALS$/{print "\"\!=\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^NVLINE$/{print "\"~|\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^PERCENT$/{print "\"%\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^PERIOD$/{print "\".\"" "    " "{BEGIN INITIAL; tptp_ff = 0; return(" $1 ");}";next;} {print;}' | \
awk '/^PLUS$/{print "\"+\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^PLUSPLUS$/{print "\"++\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^QUESTION$/{print "\"?\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^RBRKT$/{print "\"]\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^RPAREN$/{print "\")\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^SLASHSTAR$/{print "\"/*\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^SQUOTE$/{print "\"'"'"'\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^STAR$/{print "\"*\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^STARSLASH$/{print "\"*/\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TILDE$/{print "\"~\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^VLINE$/{print "\"|\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_TRUE$/{print "\"$true\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_FALSE$/{print "\"$false\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_AND$/{print "\"/\\\\\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_OR$/{print "\"\\\\/\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_NOT$/{print "\"$not\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_T$/{print "\"$t\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_NIL$/{print "\"$nil\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_O$/{print "\"$o\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_I$/{print "\"$i\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_TYPE$/{print "\"$type\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^TOK_FILE$/{print "<FF>\"file\"" "    " "return(" $1 ");";next;} {print;}' | \
awk '/^[A-Z]*[FH]OF$/{z=tolower($0);print "<INITIAL>\"" z "\"" "    " "{BEGIN B; return(" $1 ");}";next;} {print;}' | \
awk '/^CNF$/{z=tolower($0);print "<INITIAL>\"" z "\"" "    " "{BEGIN B; return(" $1 ");}";next;} {print;}' | \
awk '/^INCLUDE$/{z=tolower($0);print "<INITIAL>\"" z "\"" "    " "{BEGIN B; return(" $1 ");}";next;} {print;}' | \
awk '/^LAMBDA$/{z=tolower($0);print "\"" z "\"" "    " "{return(" $1 ");}";next;} {print;}' | \
awk '/^[A-Z_][A-Z_0-9]*$/{z=tolower($0);print "<FF>\"" z "\"" "    " "return(" $1 ");";next;} {print;}' | \
sed -e 's/\(return([^)]*);\)/{yylval.sval = strdup(yytext); \1}/' | \
cat >> $outlex

cat $1 | \
egrep '^(comment|system_comment|upper_word|lower_word|atomic_system_word|single_quoted|real|unsigned_integer|double_quoted|distinct_object)' | \
awk '/^upper_word/{print "[A-Z][a-z0-9A-Z_]*" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^lower_word/{print "[a-z][a-z0-9A-Z_]*" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^atomic_system_word/{print "[$][$][a-z][a-z0-9A-Z_]*" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^single_quoted/{print "['"'"']([\\040-\\046]|[\\050-\\133]|[\\135-\\176]|[\\\\][\\\\]|[\\\\]['"'"'])*['"'"']" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^double_quoted/{print "[\"]([\\040-\\041]|[\\043-\\133]|[\\135-\\176]|[\\\\][\\\\]|[\\\\][\"])*[\"]" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^distinct_object/{print "[\"]([\\040-\\041]|[\\043-\\133]|[\\135-\\176]|[\\\\][\\\\]|[\\\\][\"])*[\"]" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^unsigned_integer/{print "[0-9][0-9]*" "    " "return(" $1 ");";}{print;}' | \
awk '/^unsigned_integer/{print "[+-][0-9][0-9]*" "    " "return(signed_integer);";next;}{print;}' | \
awk '/^real/{print "[+-]?[0-9][0-9]*[.][0-9][0-9]*" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^system_comment/{print "\"%\"[ \\t]*\"$$\".*$" "    " "return(" $1 ");";}{print;}' | \
awk '/^system_comment/{print "\"/*\"[ \\t]*\"$$\".*\"*/\"" "    " "return(" $1 ");";next;}{print;}' | \
awk '/^comment/{print "\"%\"[ \\t]*[^$].*$" "    " "return(" $1 ");";}{print;}' | \
awk '/^comment/{print "\"/*\"[ \\t]*[^$].*\"*/\"" "    " "return(" $1 ");";}{print;}' | \
awk '/^comment/{print "\"%\"[ \\t]*\"$\"[^$].*$" "    " "return(" $1 ");";}{print;}' | \
awk '/^comment/{print "\"/*\"[ \\t]*\"$\"[^$].*\"*/\"" "    " "return(" $1 ");";next;}{print;}' | \
sed -e 's/\(return([^)]*);\)/{yylval.sval = strdup(yytext); \1}/' | \
cat >> $outlex

# lex does not do what we expect with [\\000-\\040] etc.

$ECHO '[ \\t\\n]    ;' >> $outlex
$ECHO '[\\000-\\040]|[\\177]    ;' >> $outlex
$ECHO '[\\041-\\176]    return(unrecognized);' >> $outlex
$ECHO '%%' >> $outlex
$ECHO '' >> $outlex

# awk '/^system_comment/{print "[ \\t\\n]" "    " ";";next;}{print;}' | \
