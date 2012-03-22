#!/bin/csh -f

# Goal for this script is to replace terminal symbols with capitalized
# names and remove <> from nonterminal symbols.
# Also put continuations all on one line.

if ($#argv != 1) then
	echo Usage: $0 tptp-bnf.txt  ' > tptp-1.txt'
	exit $#argv
	endif

cat $1 | \
sed -e 's/non-assoc/nonassoc/g' | \
sed -e 's/^<\([A-Za-z_][A-Za-z_]*\)>/\1 /' | \
sed -e 's/~<\([A-Za-z_][A-Za-z_]*\)>/~\1 /g' | \
sed -e 's/<\([A-Za-z_][A-Za-z_]*\)>/ \1 /g' | \
sed -e 's/\(::= *\)include\([ (]\)/\1INCLUDE\2/' | \
sed -e 's/\(::= *\)inference\([ (]\)/\1INFERENCE\2/' | \
sed -e 's/\(::= *\)theory\([ (]\)/\1THEORY\2/' | \
sed -e 's/\(::= *\)introduced\([ (]\)/\1INTRODUCED\2/' | \
sed -e 's/\(::= *\)file\([ (]\)/\1TOK_FILE\2/' | \
sed -e 's/\(::= *\)creator\([ (]\)/\1CREATOR\2/' | \
sed -e 's/\(::= *\)description\([ (]\)/\1DESCRIPTION\2/' | \
sed -e 's/\(::= *\)iquote\([ (]\)/\1IQUOTE\2/' | \
sed -e 's/\(::= *\)status\([ (]\)/\1STATUS\2/' | \
sed -e 's/\(::= *\)refutation\([ (]\)/\1REFUTATION\2/' | \
sed -e 's/\(::= *\)input_formula\([ (]\)/\1INPUT_FORMULA\2/' | \
sed -e 's/\(::= *\)input_clause\([ (]\)/\1INPUT_CLAUSE\2/' | \
sed -e 's/\(::= *\)cnf\([ (]\)/\1CNF\2/' | \
sed -e 's/\(::=.*\) fof\([ (]\)/\1 FOF\2/' | \
sed -e 's/^\([ ]*\)fof\([ (]\)/\1FOF\2/' | \
sed -e 's/\(::= *\)hof\([ (]\)/\1HOF\2/' | \
sed -e 's/\(::=.*\) lambda /\1 LAMBDA /' | \
sed -e 's/\(::=.*\) lambda$/\1 LAMBDA/' | \
sed -e '/^TPTP_input/s/\(::=.*\) comment /\1 comment | system_comment /' | \
awk '/^\/\*/{print;next;}{gsub("\""," DQUOTE ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("'"'"'"," SQUOTE ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("`"," BQUOTE ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(","," COMMA ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[.][.][.]"," ETC_ETC ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[.]"," PERIOD ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("~[&]","NAMPERSAND");print;}' | \
awk '/^\/\*/{print;next;}{gsub("~vline","NVLINE");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" <=> "," IFF ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" => "," IMPLIES ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" ->"," MAP_TO");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" <= "," IF ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" <~> "," NIFF ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" \!="," NEQUALS ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" ="," EQUALS ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" : "," COLON ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(" [@] "," AT_SIGN ");print;}' | \
awk '/^\/\*/{print;next;}{gsub(";"," SEMICOLON ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("%"," PERCENT ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[&]"," AMPERSAND ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[\!]"," EXCLAMATION ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[?]"," QUESTION ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("\\^"," CARET ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[~]"," TILDE ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[$][$]"," DDOLLAR ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[[]"," LBRKT ");gsub("]"," RBRKT ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("[(]"," LPAREN ");gsub("[)]"," RPAREN ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("/ *star"," SLASHSTAR ");gsub("star */"," STARSLASH ");print;}' | \
awk '/^\/\*/{print;next;}{gsub("vline","VLINE");gsub("star","STAR");print;}' | \
awk '/^\/\*/{print;next;}{gsub("char ","CHAR ");gsub("plus","PLUS");print;}' | \
awk '/^parent_/{gsub("-","MINUS");print;next;}{print;}' | \
awk '/^sign/{gsub("[+]","PLUS");gsub("-","MINUS");print;next;}{print;}' | \
awk '/^TPTP_sign/{gsub("[+]","PLUS");gsub("-","MINUS");print;next;}{print;}' | \
awk '/^\/\*/{if(s!="")print s;s="";print;next;} /^ *$/{if(s!="")print s;s="";print;next;} / ::=/{if(s!="")print s;s=$0;next;} {sub("  *"," ");s=s $0;next;} END{if(s!="")print s;}' | \
awk '/^atomic_word/{for(i=11;i<=NF;i++){z=toupper($i);if(z!=$i){gsub(" " $i," " z);}}print;next;} {print;}' | \
awk '/^status_value/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}print;next;} {print;}' | \
awk '/^formula_role/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}print;next;} {print;}' | \
awk '/^type[_ ][f ]/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}print;next;} {print;}' | \
awk '/^intro_type/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}print;next;} {print;}' | \
awk '/^type[_ ][f ]/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}print;next;} {print;}' | \
awk '/^theory_name/{for(i=3;i<=NF;i++){z=toupper($i);if(z!=$i){gsub($i,z);}}gsub("[|] *ETC_ETC","");print;next;} {print;}' | \
awk '/map_arrow/{gsub("[ ][>]"," GREATER ");print;next;}{print;}' | \
awk '/^source/{gsub("unknown","UNKNOWN");print;next;} {print;}' | \
awk '/^file_node_name/{gsub("unknown","UNKNOWN");print;next;} {print;}' | \
awk '/^defined_atom/{gsub(" equal "," EQUAL ");print;next;} {print;}' | \
awk '/^defined_hof_atom/{gsub(" equal "," EQUAL ");print;next;} {print;}' | \
awk '/^\/\*/{print;next;} {gsub("[$]true","TOK_TRUE");gsub("[$]false","TOK_FALSE");gsub("/[\\\\]","TOK_AND");gsub("[\\\\]/","TOK_OR");gsub("[$]not","TOK_NOT");print;next;} {print;}' | \
awk '/^\/\*/{print;next;} {gsub("[$]type","TOK_TYPE");gsub("[$]t","TOK_T");gsub("[$]nil","TOK_NIL");gsub("[$]o","TOK_O");gsub("[$]i","TOK_I");print;next;} {print;}' | \
awk '/^\/\*/{print;next;} /LBRKT .* \* *RBRKT/{for (i=1;i<=NF;i++){if($i=="LBRKT")j=i+1;if($i=="RBRKT")k=i-1;} z=$0;sub(" " $j " .*\\*"," " $j "_list", z);print z;y="";for(i=j;i<=k;i++)y=y " "$i;print $j "_list    ::= " y;next;}{print;}' | \
sed -e 's/^\([A-Za-z].* ::= .*LBRKT *\)\([^ ]*\) *\([^ ]* *\*\)\( *RBRKT.*$\)/\1\2_list \4\012\2_list    ::= \2\3/' | \
cat | \
cat
