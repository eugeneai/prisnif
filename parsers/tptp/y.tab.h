/* A Bison parser, made by GNU Bison 2.6.4.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     AMPERSAND = 258,
     COLON = 259,
     COMMA = 260,
     EQUALS = 261,
     EQUALS_GREATER = 262,
     EXCLAMATION = 263,
     EXCLAMATION_EQUALS = 264,
     LBRKT = 265,
     LESS_EQUALS = 266,
     LESS_EQUALS_GREATER = 267,
     LESS_TILDE_GREATER = 268,
     LPAREN = 269,
     MINUS_MINUS = 270,
     PERIOD = 271,
     PLUS_PLUS = 272,
     QUESTION = 273,
     RBRKT = 274,
     RPAREN = 275,
     TILDE = 276,
     TILDE_AMPERSAND = 277,
     TILDE_VLINE = 278,
     VLINE = 279,
     _DLR_false = 280,
     _DLR_true = 281,
     _LIT_cnf = 282,
     _LIT_fof = 283,
     _LIT_include = 284,
     _LIT_input_clause = 285,
     _LIT_input_formula = 286,
     atomic_system_word = 287,
     decimal_part = 288,
     distinct_object = 289,
     lower_word = 290,
     real = 291,
     signed_integer = 292,
     single_quoted = 293,
     unrecognized = 294,
     unsigned_integer = 295,
     upper_word = 296
   };
#endif
/* Tokens.  */
#define AMPERSAND 258
#define COLON 259
#define COMMA 260
#define EQUALS 261
#define EQUALS_GREATER 262
#define EXCLAMATION 263
#define EXCLAMATION_EQUALS 264
#define LBRKT 265
#define LESS_EQUALS 266
#define LESS_EQUALS_GREATER 267
#define LESS_TILDE_GREATER 268
#define LPAREN 269
#define MINUS_MINUS 270
#define PERIOD 271
#define PLUS_PLUS 272
#define QUESTION 273
#define RBRKT 274
#define RPAREN 275
#define TILDE 276
#define TILDE_AMPERSAND 277
#define TILDE_VLINE 278
#define VLINE 279
#define _DLR_false 280
#define _DLR_true 281
#define _LIT_cnf 282
#define _LIT_fof 283
#define _LIT_include 284
#define _LIT_input_clause 285
#define _LIT_input_formula 286
#define atomic_system_word 287
#define decimal_part 288
#define distinct_object 289
#define lower_word 290
#define real 291
#define signed_integer 292
#define single_quoted 293
#define unrecognized 294
#define unsigned_integer 295
#define upper_word 296



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2077 of yacc.c  */
#line 98 "syntaxBNF2-1.y"
int ival; double dval; char* sval; void* pval;

/* Line 2077 of yacc.c  */
#line 142 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
