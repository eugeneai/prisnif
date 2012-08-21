/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison implementation for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.5"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 268 of yacc.c  */
#line 2 "syntaxBNF2-1.y"

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


/* Line 268 of yacc.c  */
#line 168 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
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

/* Line 293 of yacc.c  */
#line 98 "syntaxBNF2-1.y"
int ival; double dval; char* sval; void* pval;


/* Line 293 of yacc.c  */
#line 290 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 343 of yacc.c  */
#line 302 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   220

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  42
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  60
/* YYNRULES -- Number of rules.  */
#define YYNRULES  110
/* YYNRULES -- Number of states.  */
#define YYNSTATES  191

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   296

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    16,    18,
      20,    31,    42,    44,    47,    52,    54,    56,    58,    60,
      62,    66,    68,    70,    72,    74,    76,    78,    80,    82,
      86,    90,    94,    98,   100,   102,   106,   108,   115,   117,
     119,   121,   125,   128,   130,   134,   136,   138,   142,   144,
     147,   149,   151,   153,   155,   157,   161,   163,   165,   169,
     173,   175,   177,   179,   181,   183,   185,   187,   192,   194,
     196,   198,   200,   202,   207,   209,   211,   213,   215,   217,
     219,   226,   228,   233,   235,   239,   241,   243,   246,   250,
     252,   257,   259,   263,   265,   267,   269,   271,   272,   274,
     276,   278,   280,   290,   300,   303,   307,   309,   313,   316,
     318
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      43,     0,    -1,    93,    -1,    43,    44,    -1,    45,    -1,
      84,    -1,    46,    -1,    47,    -1,    96,    -1,    97,    -1,
      28,    14,    91,     5,    49,     5,    50,    48,    20,    16,
      -1,    27,    14,    91,     5,    49,     5,    63,    48,    20,
      16,    -1,    93,    -1,     5,    81,    -1,     5,    81,     5,
      83,    -1,    92,    -1,    51,    -1,    57,    -1,    52,    -1,
      54,    -1,    57,    53,    57,    -1,    12,    -1,     7,    -1,
      11,    -1,    13,    -1,    23,    -1,    22,    -1,    55,    -1,
      56,    -1,    57,    24,    57,    -1,    57,    24,    55,    -1,
      57,     3,    57,    -1,    57,     3,    56,    -1,    58,    -1,
      61,    -1,    14,    50,    20,    -1,    66,    -1,    59,    10,
      60,    19,     4,    57,    -1,     8,    -1,    18,    -1,    80,
      -1,    80,     5,    60,    -1,    62,    57,    -1,    21,    -1,
      14,    64,    20,    -1,    64,    -1,    65,    -1,    65,    24,
      64,    -1,    66,    -1,    21,    66,    -1,    67,    -1,    69,
      -1,    70,    -1,    73,    -1,    71,    -1,    71,     5,    68,
      -1,    26,    -1,    25,    -1,    71,     6,    71,    -1,    71,
       9,    71,    -1,    77,    -1,    72,    -1,    80,    -1,    73,
      -1,    76,    -1,    77,    -1,    74,    -1,    75,    14,    68,
      20,    -1,    92,    -1,    92,    -1,    94,    -1,    34,    -1,
      79,    -1,    78,    14,    68,    20,    -1,    32,    -1,    32,
      -1,    41,    -1,    89,    -1,    92,    -1,    88,    -1,    29,
      14,    82,    85,    20,    16,    -1,    93,    -1,     5,    10,
      86,    19,    -1,    91,    -1,    91,     5,    86,    -1,    89,
      -1,    88,    -1,    10,    19,    -1,    10,    90,    19,    -1,
      91,    -1,    75,    14,    90,    20,    -1,    87,    -1,    87,
       5,    90,    -1,    92,    -1,    40,    -1,    35,    -1,    38,
      -1,    -1,    36,    -1,    95,    -1,    37,    -1,    40,    -1,
      31,    14,    91,     5,    49,     5,    50,    20,    16,    -1,
      30,    14,    91,     5,    49,     5,    98,    20,    16,    -1,
      10,    19,    -1,    10,    99,    19,    -1,   100,    -1,   100,
       5,    99,    -1,   101,    66,    -1,    17,    -1,    15,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   142,   142,   143,   146,   147,   150,   151,   152,   153,
     156,   159,   162,   163,   164,   167,   170,   171,   174,   175,
     178,   181,   182,   183,   184,   185,   186,   189,   190,   193,
     194,   197,   198,   201,   202,   203,   204,   207,   210,   211,
     214,   215,   218,   221,   224,   225,   228,   229,   232,   233,
     236,   237,   238,   241,   244,   245,   248,   249,   250,   251,
     254,   257,   258,   261,   262,   263,   266,   267,   270,   273,
     276,   277,   280,   281,   284,   287,   290,   293,   296,   299,
     302,   305,   306,   309,   310,   313,   314,   317,   318,   321,
     322,   325,   326,   329,   330,   333,   334,   337,   340,   341,
     344,   345,   356,   367,   370,   371,   374,   375,   378,   381,
     382
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "AMPERSAND", "COLON", "COMMA", "EQUALS",
  "EQUALS_GREATER", "EXCLAMATION", "EXCLAMATION_EQUALS", "LBRKT",
  "LESS_EQUALS", "LESS_EQUALS_GREATER", "LESS_TILDE_GREATER", "LPAREN",
  "MINUS_MINUS", "PERIOD", "PLUS_PLUS", "QUESTION", "RBRKT", "RPAREN",
  "TILDE", "TILDE_AMPERSAND", "TILDE_VLINE", "VLINE", "_DLR_false",
  "_DLR_true", "_LIT_cnf", "_LIT_fof", "_LIT_include", "_LIT_input_clause",
  "_LIT_input_formula", "atomic_system_word", "decimal_part",
  "distinct_object", "lower_word", "real", "signed_integer",
  "single_quoted", "unrecognized", "unsigned_integer", "upper_word",
  "$accept", "TPTP_file", "TPTP_input", "annotated_formula",
  "fof_annotated", "cnf_annotated", "annotations", "formula_role",
  "fof_formula", "binary_formula", "nonassoc_binary", "binary_connective",
  "assoc_binary", "or_formula", "and_formula", "unitary_formula",
  "quantified_formula", "quantifier", "variable_list", "unary_formula",
  "unary_connective", "cnf_formula", "disjunction", "literal",
  "atomic_formula", "plain_atom", "arguments", "defined_atom",
  "system_atom", "term", "function_term", "plain_term", "constant",
  "functor", "defined_term", "system_term", "system_functor",
  "system_constant", "variable", "source", "file_name", "useful_info",
  "include", "formula_selection", "name_list", "general_term",
  "general_list", "general_function", "general_arguments", "name",
  "atomic_word", "null", "number", "integer", "TPTP_input_formula",
  "TPTP_input_clause", "TPTP_literals", "TPTP_literal_list",
  "TPTP_literal", "TPTP_sign", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    42,    43,    43,    44,    44,    45,    45,    45,    45,
      46,    47,    48,    48,    48,    49,    50,    50,    51,    51,
      52,    53,    53,    53,    53,    53,    53,    54,    54,    55,
      55,    56,    56,    57,    57,    57,    57,    58,    59,    59,
      60,    60,    61,    62,    63,    63,    64,    64,    65,    65,
      66,    66,    66,    67,    68,    68,    69,    69,    69,    69,
      70,    71,    71,    72,    72,    72,    73,    73,    74,    75,
      76,    76,    77,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    85,    86,    86,    87,    87,    88,    88,    89,
      89,    90,    90,    91,    91,    92,    92,    93,    94,    94,
      95,    95,    96,    97,    98,    98,    99,    99,   100,   101,
     101
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     1,     1,
      10,    10,     1,     2,     4,     1,     1,     1,     1,     1,
       3,     1,     1,     1,     1,     1,     1,     1,     1,     3,
       3,     3,     3,     1,     1,     3,     1,     6,     1,     1,
       1,     3,     2,     1,     3,     1,     1,     3,     1,     2,
       1,     1,     1,     1,     1,     3,     1,     1,     3,     3,
       1,     1,     1,     1,     1,     1,     1,     4,     1,     1,
       1,     1,     1,     4,     1,     1,     1,     1,     1,     1,
       6,     1,     4,     1,     3,     1,     1,     2,     3,     1,
       4,     1,     3,     1,     1,     1,     1,     0,     1,     1,
       1,     1,     9,     9,     2,     3,     1,     3,     2,     1,
       1
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
      97,     0,     2,     1,     0,     0,     0,     0,     0,     3,
       4,     6,     7,     5,     8,     9,     0,     0,     0,     0,
       0,    95,    96,    94,     0,    93,     0,    97,    78,     0,
       0,     0,     0,     0,     0,    81,     0,     0,     0,    15,
       0,     0,     0,     0,     0,     0,     0,     0,    83,    80,
       0,     0,     0,     0,    57,    56,    75,    71,    98,   100,
     101,    76,    97,    45,    46,    48,    50,    51,    52,     0,
      61,    53,    66,     0,    64,    60,     0,    72,    62,    68,
      70,    99,    38,     0,    39,    43,    97,    16,    18,    19,
      27,    28,    17,    33,     0,    34,     0,    36,    82,     0,
       0,     0,     0,     0,    49,     0,     0,    12,     0,     0,
       0,     0,     0,     0,     0,     0,    22,    23,    21,    24,
      26,    25,     0,     0,     0,    42,    84,   110,   109,   104,
       0,   106,     0,     0,     0,    44,     0,    13,    77,    89,
      93,     0,    47,    58,    63,    65,    59,     0,    54,     0,
      35,     0,    32,    31,    30,    29,    20,     0,    40,   105,
       0,   108,   103,   102,     0,     0,    11,    67,     0,    73,
      10,     0,     0,   107,     0,    91,    86,    85,     0,    14,
      79,    55,     0,    41,    87,     0,     0,    90,    37,    88,
      92
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     9,    10,    11,    12,   106,    38,    86,    87,
      88,   123,    89,    90,    91,    92,    93,    94,   157,    95,
      96,    62,    63,    64,    97,    66,   147,    67,    68,    69,
      70,    71,    72,    73,    74,    75,    76,    77,    78,   137,
      27,   179,    13,    34,    47,   175,   176,   177,   178,   139,
      79,   107,    80,    81,    14,    15,   101,   130,   131,   132
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -132
static const yytype_int16 yypact[] =
{
    -132,    29,  -132,  -132,     9,    18,    32,    33,    48,  -132,
    -132,  -132,  -132,  -132,  -132,  -132,    10,    10,    26,    10,
      10,  -132,  -132,  -132,    19,  -132,    58,    66,  -132,    72,
      83,    26,    26,    81,    85,  -132,    26,    26,   106,  -132,
     107,    10,    97,   110,   116,   115,    82,   108,   120,  -132,
     125,    82,   139,   156,  -132,  -132,   112,  -132,  -132,  -132,
    -132,  -132,   126,  -132,   113,  -132,  -132,  -132,  -132,    93,
    -132,    95,  -132,   124,  -132,   100,   128,  -132,  -132,   132,
    -132,  -132,  -132,    82,  -132,  -132,   126,  -132,  -132,  -132,
    -132,  -132,   121,  -132,   129,  -132,    82,  -132,  -132,    10,
      61,   134,   137,   141,  -132,    10,   142,  -132,   139,   166,
     166,   166,   166,   143,   146,    82,  -132,  -132,  -132,  -132,
    -132,  -132,    82,    82,    89,  -132,  -132,  -132,  -132,  -132,
     140,   162,   156,   152,   153,  -132,   158,   173,  -132,  -132,
     132,   167,  -132,  -132,  -132,  -132,  -132,   164,   180,   169,
    -132,   170,  -132,   184,  -132,   171,  -132,   186,   194,  -132,
      80,  -132,  -132,  -132,    44,   198,  -132,  -132,   166,  -132,
    -132,   205,    89,  -132,    34,   206,  -132,  -132,   190,  -132,
    -132,  -132,    82,  -132,  -132,   193,    44,  -132,  -132,  -132,
    -132
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -132,  -132,  -132,  -132,  -132,  -132,   127,    49,   -32,  -132,
    -132,  -132,  -132,    92,   101,   -89,  -132,  -132,    43,  -132,
    -132,  -132,   -38,  -132,   -40,  -132,   -95,  -132,  -132,  -101,
    -132,   -74,  -132,   -99,  -132,   -70,  -132,  -132,  -106,  -132,
    -132,  -132,  -132,  -132,   118,  -132,    53,   114,  -131,    11,
     -16,    22,  -132,  -132,  -132,  -132,  -132,    60,  -132,  -132
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -75
static const yytype_int16 yytable[] =
{
      25,    25,    28,    25,    25,    65,   136,   125,   143,   146,
     148,   148,    65,   104,   103,    39,    39,   149,   158,   102,
      39,    39,     2,    16,    31,    25,   153,    24,    26,     3,
      29,    30,    17,   155,   156,   144,   144,   144,   144,   145,
     145,   145,   145,   185,   174,    21,    18,    19,    22,    35,
      23,   113,    48,   184,   174,   190,     4,     5,     6,     7,
       8,    21,    20,    32,    22,   136,   158,   148,    65,    21,
     142,    33,    22,   181,    23,   136,   127,    36,   128,    21,
     129,    40,    22,    25,    23,    43,    44,   136,    37,   140,
      82,    41,   161,   188,   144,   127,    83,   128,   145,   109,
      84,   -63,   110,    85,   -63,    42,   -65,    54,    55,   -65,
      48,    45,    46,    49,    56,    50,    57,    21,    58,    59,
      22,    51,    60,    61,   115,    99,   -74,    98,   116,    52,
      61,   105,   117,   118,   119,   100,    53,   108,   111,   124,
      54,    55,   112,   120,   121,   122,   -69,    56,   140,    57,
      21,    58,    59,    22,   133,    60,    61,   134,   140,   159,
      53,   135,   141,   150,    54,    55,   151,   160,   162,   163,
     140,    56,   164,    57,    21,    58,    59,    22,   165,    60,
      61,    54,    55,   166,   167,   168,   170,   115,    56,   169,
      57,    21,    58,    59,    22,   122,    60,    61,    56,   172,
      57,    21,    58,    59,    22,   171,    60,    61,   174,   182,
     187,   186,   189,   114,   154,   183,   152,   126,   180,   138,
     173
};

#define yypact_value_is_default(yystate) \
  ((yystate) == (-132))

#define yytable_value_is_error(yytable_value) \
  YYID (0)

static const yytype_uint8 yycheck[] =
{
      16,    17,    18,    19,    20,    45,   105,    96,   109,   110,
     111,   112,    52,    53,    52,    31,    32,   112,   124,    51,
      36,    37,     0,    14,     5,    41,   115,    16,    17,     0,
      19,    20,    14,   122,   123,   109,   110,   111,   112,   109,
     110,   111,   112,   174,    10,    35,    14,    14,    38,    27,
      40,    83,    41,    19,    10,   186,    27,    28,    29,    30,
      31,    35,    14,     5,    38,   164,   172,   168,   108,    35,
     108,     5,    38,   168,    40,   174,    15,     5,    17,    35,
      19,    32,    38,    99,    40,    36,    37,   186,     5,   105,
       8,    10,   132,   182,   168,    15,    14,    17,   168,     6,
      18,     6,     9,    21,     9,    20,     6,    25,    26,     9,
      99,     5,     5,    16,    32,     5,    34,    35,    36,    37,
      38,     5,    40,    41,     3,     5,    14,    19,     7,    14,
      41,     5,    11,    12,    13,    10,    21,    24,    14,    10,
      25,    26,    14,    22,    23,    24,    14,    32,   164,    34,
      35,    36,    37,    38,    20,    40,    41,    20,   174,    19,
      21,    20,    20,    20,    25,    26,    20,     5,    16,    16,
     186,    32,    14,    34,    35,    36,    37,    38,     5,    40,
      41,    25,    26,    16,    20,     5,    16,     3,    32,    20,
      34,    35,    36,    37,    38,    24,    40,    41,    32,     5,
      34,    35,    36,    37,    38,    19,    40,    41,    10,     4,
      20,     5,    19,    86,   122,   172,   115,    99,   165,   105,
     160
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    43,    93,     0,    27,    28,    29,    30,    31,    44,
      45,    46,    47,    84,    96,    97,    14,    14,    14,    14,
      14,    35,    38,    40,    91,    92,    91,    82,    92,    91,
      91,     5,     5,     5,    85,    93,     5,     5,    49,    92,
      49,    10,    20,    49,    49,     5,     5,    86,    91,    16,
       5,     5,    14,    21,    25,    26,    32,    34,    36,    37,
      40,    41,    63,    64,    65,    66,    67,    69,    70,    71,
      72,    73,    74,    75,    76,    77,    78,    79,    80,    92,
      94,    95,     8,    14,    18,    21,    50,    51,    52,    54,
      55,    56,    57,    58,    59,    61,    62,    66,    19,     5,
      10,    98,    50,    64,    66,     5,    48,    93,    24,     6,
       9,    14,    14,    50,    48,     3,     7,    11,    12,    13,
      22,    23,    24,    53,    10,    57,    86,    15,    17,    19,
      99,   100,   101,    20,    20,    20,    75,    81,    89,    91,
      92,    20,    64,    71,    73,    77,    71,    68,    71,    68,
      20,    20,    56,    57,    55,    57,    57,    60,    80,    19,
       5,    66,    16,    16,    14,     5,    16,    20,     5,    20,
      16,    19,     5,    99,    10,    87,    88,    89,    90,    83,
      88,    68,     4,    60,    19,    90,     5,    20,    57,    19,
      90
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* This macro is provided for backward compatibility. */

#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (0, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  YYSIZE_T yysize1;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = 0;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                yysize1 = yysize + yytnamerr (0, yytname[yyx]);
                if (! (yysize <= yysize1
                       && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                  return 2;
                yysize = yysize1;
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  yysize1 = yysize + yystrlen (yyformat);
  if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
    return 2;
  yysize = yysize1;

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */
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


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1806 of yacc.c  */
#line 142 "syntaxBNF2-1.y"
    {}
    break;

  case 3:

/* Line 1806 of yacc.c  */
#line 143 "syntaxBNF2-1.y"
    {}
    break;

  case 4:

/* Line 1806 of yacc.c  */
#line 146 "syntaxBNF2-1.y"
    {P_PRINT((yyval.pval));}
    break;

  case 5:

/* Line 1806 of yacc.c  */
#line 147 "syntaxBNF2-1.y"
    {P_PRINT((yyval.pval));}
    break;

  case 6:

/* Line 1806 of yacc.c  */
#line 150 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 7:

/* Line 1806 of yacc.c  */
#line 151 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 8:

/* Line 1806 of yacc.c  */
#line 152 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 9:

/* Line 1806 of yacc.c  */
#line 153 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 10:

/* Line 1806 of yacc.c  */
#line 156 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("fof_annotated", P_TOKEN("_LIT_fof ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));}
    break;

  case 11:

/* Line 1806 of yacc.c  */
#line 159 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("cnf_annotated", P_TOKEN("_LIT_cnf ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));}
    break;

  case 12:

/* Line 1806 of yacc.c  */
#line 162 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotations", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 13:

/* Line 1806 of yacc.c  */
#line 163 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotations", P_TOKEN("COMMA ", (yyvsp[(1) - (2)].ival)), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 14:

/* Line 1806 of yacc.c  */
#line 164 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("annotations", P_TOKEN("COMMA ", (yyvsp[(1) - (4)].ival)), (yyvsp[(2) - (4)].pval), P_TOKEN("COMMA ", (yyvsp[(3) - (4)].ival)), (yyvsp[(4) - (4)].pval), 0, 0, 0, 0, 0, 0);}
    break;

  case 15:

/* Line 1806 of yacc.c  */
#line 167 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("formula_role", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 16:

/* Line 1806 of yacc.c  */
#line 170 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("fof_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 17:

/* Line 1806 of yacc.c  */
#line 171 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("fof_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 18:

/* Line 1806 of yacc.c  */
#line 174 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 19:

/* Line 1806 of yacc.c  */
#line 175 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 20:

/* Line 1806 of yacc.c  */
#line 178 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("nonassoc_binary", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 21:

/* Line 1806 of yacc.c  */
#line 181 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 22:

/* Line 1806 of yacc.c  */
#line 182 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("EQUALS_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 23:

/* Line 1806 of yacc.c  */
#line 183 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 24:

/* Line 1806 of yacc.c  */
#line 184 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_TILDE_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 25:

/* Line 1806 of yacc.c  */
#line 185 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("TILDE_VLINE ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 26:

/* Line 1806 of yacc.c  */
#line 186 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("TILDE_AMPERSAND ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 27:

/* Line 1806 of yacc.c  */
#line 189 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 28:

/* Line 1806 of yacc.c  */
#line 190 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 29:

/* Line 1806 of yacc.c  */
#line 193 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 30:

/* Line 1806 of yacc.c  */
#line 194 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 31:

/* Line 1806 of yacc.c  */
#line 197 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 32:

/* Line 1806 of yacc.c  */
#line 198 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 33:

/* Line 1806 of yacc.c  */
#line 201 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 34:

/* Line 1806 of yacc.c  */
#line 202 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 35:

/* Line 1806 of yacc.c  */
#line 203 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 36:

/* Line 1806 of yacc.c  */
#line 204 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 37:

/* Line 1806 of yacc.c  */
#line 207 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("quantified_formula", (yyvsp[(1) - (6)].pval), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);}
    break;

  case 38:

/* Line 1806 of yacc.c  */
#line 210 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("quantifier", P_TOKEN("EXCLAMATION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 39:

/* Line 1806 of yacc.c  */
#line 211 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("quantifier", P_TOKEN("QUESTION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 40:

/* Line 1806 of yacc.c  */
#line 214 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("variable_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 41:

/* Line 1806 of yacc.c  */
#line 215 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("variable_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 42:

/* Line 1806 of yacc.c  */
#line 218 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unary_formula", (yyvsp[(1) - (2)].pval), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 43:

/* Line 1806 of yacc.c  */
#line 221 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("unary_connective", P_TOKEN("TILDE ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 44:

/* Line 1806 of yacc.c  */
#line 224 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("cnf_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 45:

/* Line 1806 of yacc.c  */
#line 225 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("cnf_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 46:

/* Line 1806 of yacc.c  */
#line 228 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("disjunction", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 47:

/* Line 1806 of yacc.c  */
#line 229 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("disjunction", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 48:

/* Line 1806 of yacc.c  */
#line 232 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("literal", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 49:

/* Line 1806 of yacc.c  */
#line 233 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("literal", P_TOKEN("TILDE ", (yyvsp[(1) - (2)].ival)), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 50:

/* Line 1806 of yacc.c  */
#line 236 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 51:

/* Line 1806 of yacc.c  */
#line 237 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 52:

/* Line 1806 of yacc.c  */
#line 238 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 53:

/* Line 1806 of yacc.c  */
#line 241 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("plain_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 54:

/* Line 1806 of yacc.c  */
#line 244 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("arguments", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 55:

/* Line 1806 of yacc.c  */
#line 245 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("arguments", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 56:

/* Line 1806 of yacc.c  */
#line 248 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", P_TOKEN("_DLR_true ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 57:

/* Line 1806 of yacc.c  */
#line 249 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", P_TOKEN("_DLR_false ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 58:

/* Line 1806 of yacc.c  */
#line 250 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", (yyvsp[(1) - (3)].pval), P_TOKEN("EQUALS ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 59:

/* Line 1806 of yacc.c  */
#line 251 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", (yyvsp[(1) - (3)].pval), P_TOKEN("EXCLAMATION_EQUALS ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 60:

/* Line 1806 of yacc.c  */
#line 254 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("system_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 61:

/* Line 1806 of yacc.c  */
#line 257 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 62:

/* Line 1806 of yacc.c  */
#line 258 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 63:

/* Line 1806 of yacc.c  */
#line 261 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 64:

/* Line 1806 of yacc.c  */
#line 262 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 65:

/* Line 1806 of yacc.c  */
#line 263 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 66:

/* Line 1806 of yacc.c  */
#line 266 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("plain_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 67:

/* Line 1806 of yacc.c  */
#line 267 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("plain_term", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);}
    break;

  case 68:

/* Line 1806 of yacc.c  */
#line 270 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 69:

/* Line 1806 of yacc.c  */
#line 273 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("functor", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 70:

/* Line 1806 of yacc.c  */
#line 276 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 71:

/* Line 1806 of yacc.c  */
#line 277 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("defined_term", P_TOKEN("distinct_object ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 72:

/* Line 1806 of yacc.c  */
#line 280 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("system_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 73:

/* Line 1806 of yacc.c  */
#line 281 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("system_term", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);}
    break;

  case 74:

/* Line 1806 of yacc.c  */
#line 284 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("system_functor", P_TOKEN("atomic_system_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 75:

/* Line 1806 of yacc.c  */
#line 287 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("system_constant", P_TOKEN("atomic_system_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 76:

/* Line 1806 of yacc.c  */
#line 290 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("variable", P_TOKEN("upper_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 77:

/* Line 1806 of yacc.c  */
#line 293 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("source", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 78:

/* Line 1806 of yacc.c  */
#line 296 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("file_name", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 79:

/* Line 1806 of yacc.c  */
#line 299 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("useful_info", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 80:

/* Line 1806 of yacc.c  */
#line 302 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("include", P_TOKEN("_LIT_include ", (yyvsp[(1) - (6)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), (yyvsp[(4) - (6)].pval), P_TOKEN("RPAREN ", (yyvsp[(5) - (6)].ival)), P_TOKEN("PERIOD ", (yyvsp[(6) - (6)].ival)), 0, 0, 0, 0);}
    break;

  case 81:

/* Line 1806 of yacc.c  */
#line 305 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("formula_selection", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 82:

/* Line 1806 of yacc.c  */
#line 306 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("formula_selection", P_TOKEN("COMMA ", (yyvsp[(1) - (4)].ival)), P_TOKEN("LBRKT ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);}
    break;

  case 83:

/* Line 1806 of yacc.c  */
#line 309 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("name_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 84:

/* Line 1806 of yacc.c  */
#line 310 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("name_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 85:

/* Line 1806 of yacc.c  */
#line 313 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 86:

/* Line 1806 of yacc.c  */
#line 314 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 87:

/* Line 1806 of yacc.c  */
#line 317 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_list", P_TOKEN("LBRKT ", (yyvsp[(1) - (2)].ival)), P_TOKEN("RBRKT ", (yyvsp[(2) - (2)].ival)), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 88:

/* Line 1806 of yacc.c  */
#line 318 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_list", P_TOKEN("LBRKT ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RBRKT ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 89:

/* Line 1806 of yacc.c  */
#line 321 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_function", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 90:

/* Line 1806 of yacc.c  */
#line 322 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_function", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);}
    break;

  case 91:

/* Line 1806 of yacc.c  */
#line 325 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_arguments", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 92:

/* Line 1806 of yacc.c  */
#line 326 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("general_arguments", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 93:

/* Line 1806 of yacc.c  */
#line 329 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("name", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 94:

/* Line 1806 of yacc.c  */
#line 330 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("name", P_TOKEN("unsigned_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 95:

/* Line 1806 of yacc.c  */
#line 333 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("atomic_word", P_TOKEN("lower_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 96:

/* Line 1806 of yacc.c  */
#line 334 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("atomic_word", P_TOKEN("single_quoted ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 97:

/* Line 1806 of yacc.c  */
#line 337 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("null", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 98:

/* Line 1806 of yacc.c  */
#line 340 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("number", P_TOKEN("real ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 99:

/* Line 1806 of yacc.c  */
#line 341 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("number", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 100:

/* Line 1806 of yacc.c  */
#line 344 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("integer", P_TOKEN("signed_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 101:

/* Line 1806 of yacc.c  */
#line 345 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("integer", P_TOKEN("unsigned_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 102:

/* Line 1806 of yacc.c  */
#line 356 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_input_formula", P_TOKEN("_LIT_input_formula ", (yyvsp[(1) - (9)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (9)].ival)), (yyvsp[(3) - (9)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (9)].ival)), (yyvsp[(5) - (9)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (9)].ival)), (yyvsp[(7) - (9)].pval), P_TOKEN("RPAREN ", (yyvsp[(8) - (9)].ival)), P_TOKEN("PERIOD ", (yyvsp[(9) - (9)].ival)), 0);}
    break;

  case 103:

/* Line 1806 of yacc.c  */
#line 367 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_input_clause", P_TOKEN("_LIT_input_clause ", (yyvsp[(1) - (9)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (9)].ival)), (yyvsp[(3) - (9)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (9)].ival)), (yyvsp[(5) - (9)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (9)].ival)), (yyvsp[(7) - (9)].pval), P_TOKEN("RPAREN ", (yyvsp[(8) - (9)].ival)), P_TOKEN("PERIOD ", (yyvsp[(9) - (9)].ival)), 0);}
    break;

  case 104:

/* Line 1806 of yacc.c  */
#line 370 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_literals", P_TOKEN("LBRKT ", (yyvsp[(1) - (2)].ival)), P_TOKEN("RBRKT ", (yyvsp[(2) - (2)].ival)), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 105:

/* Line 1806 of yacc.c  */
#line 371 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_literals", P_TOKEN("LBRKT ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RBRKT ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 106:

/* Line 1806 of yacc.c  */
#line 374 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_literal_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 107:

/* Line 1806 of yacc.c  */
#line 375 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_literal_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 108:

/* Line 1806 of yacc.c  */
#line 378 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_literal", (yyvsp[(1) - (2)].pval), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 109:

/* Line 1806 of yacc.c  */
#line 381 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_sign", P_TOKEN("PLUS_PLUS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;

  case 110:

/* Line 1806 of yacc.c  */
#line 382 "syntaxBNF2-1.y"
    {(yyval.pval) = P_BUILD("TPTP_sign", P_TOKEN("MINUS_MINUS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);}
    break;



/* Line 1806 of yacc.c  */
#line 2490 "y.tab.c"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



