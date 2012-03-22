
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     AMPERSAND = 258,
     AT_SIGN = 259,
     CARET = 260,
     COLON = 261,
     COLON_EQUALS = 262,
     COMMA = 263,
     EQUALS = 264,
     EQUALS_GREATER = 265,
     EXCLAMATION = 266,
     EXCLAMATION_EQUALS = 267,
     GREATER = 268,
     LBRKT = 269,
     LESS_EQUALS = 270,
     LESS_EQUALS_GREATER = 271,
     LESS_TILDE_GREATER = 272,
     LPAREN = 273,
     MINUS_GREATER = 274,
     PERIOD = 275,
     QUESTION = 276,
     RBRKT = 277,
     RPAREN = 278,
     STAR = 279,
     TILDE = 280,
     TILDE_AMPERSAND = 281,
     TILDE_VLINE = 282,
     VLINE = 283,
     _LIT_cnf = 284,
     _LIT_fof = 285,
     _LIT_include = 286,
     _LIT_lambda = 287,
     _LIT_letrec = 288,
     _LIT_tff = 289,
     _LIT_thf = 290,
     distinct_object = 291,
     dollar_dollar_word = 292,
     dollar_word = 293,
     falseProp = 294,
     iType = 295,
     lower_word = 296,
     oType = 297,
     plus = 298,
     real = 299,
     signed_integer = 300,
     single_quoted = 301,
     tType = 302,
     trueProp = 303,
     unrecognized = 304,
     unsigned_integer = 305,
     upper_word = 306
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 96 "hotptp-1.y"
int ival; double dval; char* sval; void* pval;


/* Line 1676 of yacc.c  */
#line 107 "hotptp-1.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


