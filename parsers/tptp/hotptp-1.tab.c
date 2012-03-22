
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
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
#define YYBISON_VERSION "2.4.1"

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

/* Line 189 of yacc.c  */
#line 2 "hotptp-1.y"

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



/* Line 189 of yacc.c  */
#line 168 "hotptp-1.tab.c"

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

/* Line 214 of yacc.c  */
#line 96 "hotptp-1.y"
int ival; double dval; char* sval; void* pval;


/* Line 214 of yacc.c  */
#line 259 "hotptp-1.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 271 "hotptp-1.tab.c"

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
# if YYENABLE_NLS
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
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
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
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
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

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1023

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  121
/* YYNRULES -- Number of rules.  */
#define YYNRULES  244
/* YYNRULES -- Number of states.  */
#define YYNSTATES  410

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

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
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    16,    18,
      20,    31,    42,    53,    64,    66,    70,    72,    74,    76,
      78,    80,    84,    86,    88,    90,    92,    94,    96,    98,
     100,   104,   108,   112,   116,   118,   120,   122,   124,   126,
     130,   137,   139,   141,   143,   147,   150,   152,   156,   158,
     160,   164,   166,   169,   171,   173,   175,   177,   179,   181,
     183,   185,   189,   193,   195,   197,   201,   205,   209,   213,
     215,   217,   219,   221,   223,   227,   231,   235,   242,   244,
     246,   248,   252,   255,   262,   264,   266,   270,   274,   278,
     282,   284,   286,   288,   290,   292,   294,   296,   298,   302,
     304,   308,   310,   312,   314,   316,   318,   322,   324,   326,
     328,   330,   332,   334,   336,   338,   340,   342,   346,   350,
     354,   358,   362,   366,   368,   370,   372,   379,   381,   385,
     389,   393,   395,   397,   399,   401,   403,   407,   409,   411,
     415,   419,   423,   427,   429,   431,   433,   437,   441,   448,
     450,   454,   457,   461,   465,   467,   469,   471,   473,   475,
     479,   481,   483,   485,   487,   491,   495,   497,   499,   501,
     505,   509,   513,   517,   521,   525,   527,   529,   531,   533,
     535,   537,   539,   541,   545,   547,   552,   556,   558,   560,
     562,   564,   566,   568,   570,   572,   574,   576,   578,   580,
     582,   584,   586,   591,   593,   595,   597,   599,   601,   606,
     608,   610,   612,   614,   617,   619,   621,   628,   633,   635,
     637,   641,   643,   647,   649,   651,   656,   658,   660,   662,
     666,   669,   673,   675,   679,   681,   683,   685,   687,   689,
     691,   693,   695,   697,   699
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int16 yyrhs[] =
{
      53,     0,    -1,   172,    -1,    53,    54,    -1,    55,    -1,
     158,    -1,    56,    -1,    57,    -1,    58,    -1,    59,    -1,
      30,    18,   166,     8,    61,     8,    62,    60,    23,    20,
      -1,    29,    18,   166,     8,    61,     8,    76,    60,    23,
      20,    -1,    35,    18,   166,     8,    61,     8,    79,    60,
      23,    20,    -1,    34,    18,   166,     8,    61,     8,   114,
      60,    23,    20,    -1,   172,    -1,     8,   155,   156,    -1,
      41,    -1,    63,    -1,    70,    -1,    64,    -1,    66,    -1,
      70,    65,    70,    -1,    16,    -1,    10,    -1,    15,    -1,
      17,    -1,    27,    -1,    26,    -1,    67,    -1,    68,    -1,
      70,    28,    70,    -1,    70,    28,    67,    -1,    70,     3,
      70,    -1,    70,     3,    68,    -1,    28,    -1,     3,    -1,
      71,    -1,    74,    -1,   136,    -1,    18,    62,    23,    -1,
      72,    14,    73,    22,     6,    70,    -1,    11,    -1,    21,
      -1,   154,    -1,   154,     8,    73,    -1,    75,    70,    -1,
      25,    -1,    18,    77,    23,    -1,    77,    -1,    78,    -1,
      78,    28,    77,    -1,   136,    -1,    25,   136,    -1,    80,
      -1,    86,    -1,   113,    -1,    81,    -1,    83,    -1,    93,
      -1,    82,    -1,   105,    -1,    86,    65,    86,    -1,    86,
       9,    86,    -1,    84,    -1,    85,    -1,    86,    28,    86,
      -1,    84,    28,    86,    -1,    86,     3,    86,    -1,    85,
       3,    86,    -1,    95,    -1,   111,    -1,    91,    -1,    90,
      -1,    87,    -1,    18,    94,    23,    -1,    18,    80,    23,
      -1,    18,    86,    23,    -1,    88,    14,    89,    22,     6,
      86,    -1,    11,    -1,    21,    -1,    98,    -1,    98,     8,
      89,    -1,    75,    86,    -1,    92,    14,    89,    22,     6,
      86,    -1,    32,    -1,     5,    -1,    93,     4,    86,    -1,
      86,     4,    86,    -1,    86,     8,    94,    -1,    86,     8,
      86,    -1,    96,    -1,    97,    -1,   101,    -1,    99,    -1,
     102,    -1,   100,    -1,   100,    -1,    99,    -1,   100,     6,
     109,    -1,   154,    -1,   102,     6,   109,    -1,   167,    -1,
     170,    -1,    36,    -1,   169,    -1,   103,    -1,    18,   104,
      23,    -1,   143,    -1,   141,    -1,    75,    -1,    65,    -1,
      69,    -1,    72,    -1,     9,    -1,   106,    -1,   107,    -1,
     108,    -1,   109,   110,   106,    -1,   109,   110,   109,    -1,
     107,    24,   109,    -1,   109,    24,   109,    -1,   108,    43,
     109,    -1,   109,    43,   109,    -1,    86,    -1,    19,    -1,
      13,    -1,    33,    14,   112,    22,     6,    86,    -1,   113,
      -1,   113,     8,   112,    -1,   167,     7,    86,    -1,    18,
     113,    23,    -1,   115,    -1,   120,    -1,   124,    -1,   116,
      -1,   117,    -1,   120,    65,   120,    -1,   118,    -1,   119,
      -1,   120,    28,   120,    -1,   120,    28,   118,    -1,   120,
       3,   120,    -1,   120,     3,   119,    -1,   121,    -1,   123,
      -1,   136,    -1,    18,   115,    23,    -1,    18,   120,    23,
      -1,    72,    14,   122,    22,     6,   120,    -1,   126,    -1,
     126,     8,   122,    -1,    75,   120,    -1,   125,     6,   129,
      -1,    18,   124,    23,    -1,   149,    -1,   150,    -1,   152,
      -1,   128,    -1,   127,    -1,   128,     6,   129,    -1,   154,
      -1,   125,    -1,   143,    -1,   130,    -1,    18,   129,    23,
      -1,    18,   131,    23,    -1,   132,    -1,   133,    -1,   134,
      -1,   135,   110,   132,    -1,   135,   110,   135,    -1,   133,
      24,   135,    -1,   135,    24,   135,    -1,   134,    43,   135,
      -1,   135,    43,   135,    -1,   125,    -1,   143,    -1,   130,
      -1,   137,    -1,   139,    -1,   144,    -1,   147,    -1,   145,
      -1,   145,     8,   138,    -1,   141,    -1,   142,    18,   138,
      23,    -1,   145,   140,   145,    -1,     9,    -1,    12,    -1,
      48,    -1,    39,    -1,   168,    -1,    42,    -1,    40,    -1,
      47,    -1,   151,    -1,   146,    -1,   154,    -1,   147,    -1,
     150,    -1,   151,    -1,   148,    -1,   149,    18,   138,    23,
      -1,   167,    -1,   167,    -1,   170,    -1,    36,    -1,   153,
      -1,   152,    18,   138,    23,    -1,   169,    -1,   169,    -1,
      51,    -1,   161,    -1,     8,   157,    -1,   172,    -1,   165,
      -1,    31,    18,   171,   159,    23,    20,    -1,     8,    14,
     160,    22,    -1,   172,    -1,   166,    -1,   166,     8,   160,
      -1,   162,    -1,   162,     6,   161,    -1,   164,    -1,   167,
      -1,   167,    18,   163,    23,    -1,   170,    -1,    36,    -1,
     161,    -1,   161,     8,   163,    -1,    14,    22,    -1,    14,
     165,    22,    -1,   161,    -1,   161,     8,   165,    -1,   167,
      -1,    50,    -1,    41,    -1,    46,    -1,    38,    -1,    37,
      -1,    44,    -1,    45,    -1,    50,    -1,   167,    -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   150,   150,   151,   154,   155,   158,   159,   160,   161,
     164,   167,   170,   173,   176,   177,   180,   183,   184,   187,
     188,   191,   194,   195,   196,   197,   198,   199,   202,   203,
     206,   207,   210,   211,   214,   215,   218,   219,   220,   221,
     224,   227,   228,   231,   232,   235,   238,   241,   242,   245,
     246,   249,   250,   253,   254,   255,   258,   259,   260,   261,
     262,   265,   268,   271,   272,   275,   276,   279,   280,   283,
     284,   285,   286,   287,   288,   289,   290,   293,   296,   297,
     300,   301,   304,   307,   310,   311,   314,   315,   318,   319,
     322,   323,   326,   327,   330,   331,   334,   335,   338,   341,
     344,   347,   348,   349,   350,   351,   352,   355,   356,   359,
     360,   361,   362,   363,   366,   367,   368,   371,   372,   375,
     376,   379,   380,   383,   386,   387,   390,   393,   394,   397,
     398,   401,   402,   403,   406,   407,   410,   413,   414,   417,
     418,   421,   422,   425,   426,   427,   428,   429,   432,   435,
     436,   439,   442,   443,   446,   447,   448,   451,   452,   455,
     458,   461,   462,   463,   464,   467,   470,   471,   472,   475,
     476,   479,   480,   483,   484,   487,   488,   489,   492,   493,
     494,   497,   500,   501,   504,   505,   506,   509,   510,   513,
     514,   517,   520,   521,   522,   525,   528,   529,   532,   533,
     534,   537,   538,   541,   544,   547,   548,   551,   552,   555,
     558,   561,   564,   567,   568,   571,   574,   577,   578,   581,
     582,   585,   586,   587,   590,   591,   592,   593,   596,   597,
     600,   601,   604,   605,   608,   609,   612,   613,   616,   619,
     622,   623,   624,   627,   630
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "AMPERSAND", "AT_SIGN", "CARET", "COLON",
  "COLON_EQUALS", "COMMA", "EQUALS", "EQUALS_GREATER", "EXCLAMATION",
  "EXCLAMATION_EQUALS", "GREATER", "LBRKT", "LESS_EQUALS",
  "LESS_EQUALS_GREATER", "LESS_TILDE_GREATER", "LPAREN", "MINUS_GREATER",
  "PERIOD", "QUESTION", "RBRKT", "RPAREN", "STAR", "TILDE",
  "TILDE_AMPERSAND", "TILDE_VLINE", "VLINE", "_LIT_cnf", "_LIT_fof",
  "_LIT_include", "_LIT_lambda", "_LIT_letrec", "_LIT_tff", "_LIT_thf",
  "distinct_object", "dollar_dollar_word", "dollar_word", "falseProp",
  "iType", "lower_word", "oType", "plus", "real", "signed_integer",
  "single_quoted", "tType", "trueProp", "unrecognized", "unsigned_integer",
  "upper_word", "$accept", "TPTP_file", "TPTP_input", "annotated_formula",
  "fof_annotated", "cnf_annotated", "thf_annotated", "tff_annotated",
  "annotations", "formula_role", "fof_formula", "binary_formula",
  "nonassoc_binary", "binary_connective", "assoc_binary", "or_formula",
  "and_formula", "assoc_connective", "unitary_formula",
  "quantified_formula", "quantifier", "variable_list", "unary_formula",
  "unary_connective", "cnf_formula", "disjunction", "literal",
  "thf_formula", "thf_binary_formula", "thf_nonassoc_formula",
  "thf_equality", "thf_assoc_formula", "thf_or_formula", "thf_and_formula",
  "thf_unitary_formula", "thf_quantified_formula", "thf_quantifier",
  "thf_variable_list", "thf_unary_formula", "thf_abstraction",
  "thf_lambda", "thf_apply_formula", "thf_tuple", "thf_atom",
  "thf_typed_atom", "thf_untyped_atom", "thf_variable",
  "thf_typed_variable", "thf_untyped_variable", "thf_typed_constant",
  "thf_untyped_constant", "thf_defined_word", "tptp_operator",
  "thf_binary_type", "thf_mapping_type", "thf_xprod_type",
  "thf_union_type", "thf_unitary_type", "map_arrow", "thf_let_rec",
  "thf_definition_list", "thf_definition", "tff_formula",
  "tff_binary_formula", "tff_nonassoc_binary", "tff_assoc_binary",
  "tff_or_formula", "tff_and_formula", "tff_unitary_formula",
  "tff_quantified_formula", "tff_variable_list", "tff_unary_formula",
  "tff_typed_atom", "tff_untyped_atom", "tff_variable",
  "tff_typed_variable", "tff_untyped_variable", "tff_type_spec",
  "tff_type_expr", "tff_binary_type", "tff_mapping_type", "tff_xprod_type",
  "tff_union_type", "tff_unitary_type", "atomic_formula", "plain_atom",
  "arguments", "defined_atom", "defined_infix_pred", "defined_prop",
  "defined_pred", "defined_type", "system_atom", "term", "function_term",
  "plain_term", "constant", "functor", "defined_term", "system_term",
  "system_functor", "system_constant", "variable", "source",
  "optional_info", "useful_info", "include", "formula_selection",
  "name_list", "general_term", "general_data", "general_arguments",
  "general_list", "general_term_list", "name", "atomic_word",
  "atomic_defined_word", "atomic_system_word", "number", "file_name",
  "null", 0
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
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    53,    54,    54,    55,    55,    55,    55,
      56,    57,    58,    59,    60,    60,    61,    62,    62,    63,
      63,    64,    65,    65,    65,    65,    65,    65,    66,    66,
      67,    67,    68,    68,    69,    69,    70,    70,    70,    70,
      71,    72,    72,    73,    73,    74,    75,    76,    76,    77,
      77,    78,    78,    79,    79,    79,    80,    80,    80,    80,
      80,    81,    82,    83,    83,    84,    84,    85,    85,    86,
      86,    86,    86,    86,    86,    86,    86,    87,    88,    88,
      89,    89,    90,    91,    92,    92,    93,    93,    94,    94,
      95,    95,    96,    96,    97,    97,    98,    98,    99,   100,
     101,   102,   102,   102,   102,   102,   102,   103,   103,   104,
     104,   104,   104,   104,   105,   105,   105,   106,   106,   107,
     107,   108,   108,   109,   110,   110,   111,   112,   112,   113,
     113,   114,   114,   114,   115,   115,   116,   117,   117,   118,
     118,   119,   119,   120,   120,   120,   120,   120,   121,   122,
     122,   123,   124,   124,   125,   125,   125,   126,   126,   127,
     128,   129,   129,   129,   129,   130,   131,   131,   131,   132,
     132,   133,   133,   134,   134,   135,   135,   135,   136,   136,
     136,   137,   138,   138,   139,   139,   139,   140,   140,   141,
     141,   142,   143,   143,   143,   144,   145,   145,   146,   146,
     146,   147,   147,   148,   149,   150,   150,   151,   151,   152,
     153,   154,   155,   156,   156,   157,   158,   159,   159,   160,
     160,   161,   161,   161,   162,   162,   162,   162,   163,   163,
     164,   164,   165,   165,   166,   166,   167,   167,   168,   169,
     170,   170,   170,   171,   172
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     1,     1,
      10,    10,    10,    10,     1,     3,     1,     1,     1,     1,
       1,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       3,     3,     3,     3,     1,     1,     1,     1,     1,     3,
       6,     1,     1,     1,     3,     2,     1,     3,     1,     1,
       3,     1,     2,     1,     1,     1,     1,     1,     1,     1,
       1,     3,     3,     1,     1,     3,     3,     3,     3,     1,
       1,     1,     1,     1,     3,     3,     3,     6,     1,     1,
       1,     3,     2,     6,     1,     1,     3,     3,     3,     3,
       1,     1,     1,     1,     1,     1,     1,     1,     3,     1,
       3,     1,     1,     1,     1,     1,     3,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     3,     3,     3,
       3,     3,     3,     1,     1,     1,     6,     1,     3,     3,
       3,     1,     1,     1,     1,     1,     3,     1,     1,     3,
       3,     3,     3,     1,     1,     1,     3,     3,     6,     1,
       3,     2,     3,     3,     1,     1,     1,     1,     1,     3,
       1,     1,     1,     1,     3,     3,     1,     1,     1,     3,
       3,     3,     3,     3,     3,     1,     1,     1,     1,     1,
       1,     1,     1,     3,     1,     4,     3,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     4,     1,     1,     1,     1,     1,     4,     1,
       1,     1,     1,     2,     1,     1,     6,     4,     1,     1,
       3,     1,     3,     1,     1,     4,     1,     1,     1,     3,
       2,     3,     1,     3,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
     244,     0,     2,     1,     0,     0,     0,     0,     0,     3,
       4,     6,     7,     8,     9,     5,     0,     0,     0,     0,
       0,   236,   237,   235,     0,   234,     0,   243,   244,     0,
       0,     0,     0,     0,     0,   218,     0,     0,    16,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   219,   216,
       0,     0,     0,     0,   206,   239,   238,   190,   240,   241,
     189,   242,   211,   244,    48,    49,    51,   178,   179,   184,
       0,   180,     0,   196,   181,   201,     0,   199,   195,     0,
     207,   197,   203,   191,   210,   205,    41,     0,    42,    46,
     244,    17,    19,    20,    28,    29,    18,    36,     0,    37,
       0,    38,   217,     0,     0,     0,     0,   244,   131,   134,
     135,   137,   138,   132,   143,   144,   133,     0,   145,   154,
     199,   156,    85,    78,     0,    79,    84,     0,   103,   193,
     192,   194,     0,   244,    53,    56,    59,    57,    63,    64,
     123,    73,     0,    72,    71,     0,    58,    69,    90,    91,
      93,    95,    92,    94,   105,    60,   114,   115,   116,     0,
      70,    55,   108,   107,    99,   101,   104,   102,     0,    52,
       0,     0,    14,     0,     0,   187,   188,     0,     0,     0,
       0,     0,     0,    23,    24,    22,    25,    27,    26,     0,
       0,     0,    45,   220,     0,     0,     0,     0,     0,   151,
       0,     0,     0,     0,     0,    35,   113,    41,    42,    34,
     110,   111,   112,   109,     0,   123,     0,     0,     0,     0,
       0,    82,   101,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   125,   124,
       0,     0,     0,     0,    47,     0,   227,   244,   212,   221,
     223,   224,   226,     0,    50,     0,   182,   198,   200,   186,
       0,     0,    39,     0,    33,    32,    31,    30,    21,     0,
      43,   146,   147,   153,     0,   149,   158,   157,   160,     0,
     142,   141,   140,   139,   136,     0,   161,   152,   163,   162,
     154,   155,   156,   204,   209,    75,     0,    76,    74,   106,
     130,     0,     0,   127,     0,     0,    66,    68,    67,    87,
      62,    65,    61,     0,    80,    97,    96,     0,    86,   123,
      98,   100,   119,   121,   120,   122,   117,   118,   129,   230,
     232,     0,     0,    15,   214,     0,     0,    11,   185,     0,
     202,   208,    10,     0,     0,     0,     0,     0,    13,   175,
       0,   177,     0,   166,   167,   168,     0,   176,    89,    88,
       0,     0,    12,     0,     0,     0,     0,   231,   213,   215,
     222,   228,     0,   183,     0,    44,     0,   150,   159,   164,
     165,     0,     0,     0,     0,     0,     0,   128,     0,    81,
       0,   233,     0,   225,    40,   148,     0,   175,   177,   171,
     176,   173,   172,   174,   169,   170,   126,    77,    83,   229
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     9,    10,    11,    12,    13,    14,   171,    39,
      90,    91,    92,   203,    93,    94,    95,   211,    96,    97,
     105,   269,    99,   132,    63,    64,    65,   133,   214,   135,
     136,   137,   138,   139,   319,   141,   142,   313,   143,   144,
     145,   146,   216,   147,   148,   149,   314,   150,   151,   152,
     153,   154,   217,   155,   156,   157,   158,   159,   242,   160,
     302,   218,   107,   194,   109,   110,   111,   112,   195,   114,
     274,   115,   116,   397,   275,   276,   277,   287,   398,   352,
     353,   354,   355,   356,   118,    67,   255,    68,   177,   162,
      70,   163,    71,    72,    73,    74,    75,    76,    77,    78,
      79,    80,   164,   247,   333,   368,    15,    34,    47,   330,
     249,   372,   250,   331,    48,    82,    83,   166,    85,    28,
     172
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -312
static const yytype_int16 yypact[] =
{
    -312,    92,  -312,  -312,    29,    40,    47,    59,    70,  -312,
    -312,  -312,  -312,  -312,  -312,  -312,    22,    22,    71,    22,
      22,  -312,  -312,  -312,    78,  -312,    89,  -312,    93,    96,
     107,    72,    72,   106,   110,  -312,    72,    72,  -312,   122,
     130,    22,   119,   132,   133,   871,   227,   123,   138,  -312,
     832,   735,   906,   756,  -312,  -312,  -312,  -312,  -312,  -312,
    -312,  -312,  -312,   139,  -312,   121,  -312,  -312,  -312,  -312,
     134,  -312,    64,  -312,   102,  -312,   135,  -312,   116,   140,
    -312,  -312,    46,  -312,    48,  -312,  -312,   227,  -312,  -312,
     139,  -312,  -312,  -312,  -312,  -312,   991,  -312,   146,  -312,
     227,  -312,  -312,    22,   832,   148,   854,   139,  -312,  -312,
    -312,  -312,  -312,   995,  -312,  -312,  -312,   159,  -312,   135,
     167,   140,  -312,  -312,   648,  -312,  -312,   160,  -312,  -312,
    -312,  -312,   794,   139,  -312,  -312,  -312,  -312,   149,   175,
     955,  -312,   165,  -312,  -312,   166,   179,  -312,  -312,  -312,
    -312,   188,  -312,   189,  -312,  -312,  -312,   172,   155,    36,
    -312,  -312,  -312,  -312,  -312,   192,  -312,  -312,   183,  -312,
      39,   184,  -312,   906,   462,  -312,  -312,   462,   462,   462,
     193,   199,   227,  -312,  -312,  -312,  -312,  -312,  -312,   227,
     227,   164,  -312,  -312,   200,   605,   205,   164,   854,  -312,
     214,   854,   854,   854,   486,  -312,  -312,   218,   228,  -312,
    -312,  -312,  -312,   794,   220,   976,   221,   226,   230,    49,
     697,  -312,  -312,   231,   794,   794,   794,   794,   794,   794,
     794,   164,   164,   794,   794,   794,   794,   794,  -312,  -312,
     794,   794,   794,   794,  -312,   450,  -312,   242,  -312,   250,
    -312,   249,  -312,   254,  -312,   247,   268,  -312,  -312,  -312,
     256,   259,  -312,   264,  -312,   284,  -312,   261,  -312,   269,
     282,  -312,  -312,  -312,   277,   292,  -312,   297,  -312,   285,
    -312,   301,  -312,   279,  -312,   486,  -312,  -312,  -312,  -312,
    -312,  -312,  -312,  -312,  -312,  -312,   794,  -312,  -312,  -312,
    -312,    49,   286,   302,   192,   289,  -312,  -312,  -312,  -312,
    -312,  -312,  -312,   290,   307,  -312,   188,   295,  -312,  -312,
    -312,  -312,  -312,  -312,  -312,  -312,  -312,    37,  -312,  -312,
     313,   300,    39,  -312,  -312,    39,    39,  -312,  -312,   462,
    -312,  -312,  -312,   317,   164,   324,   164,   486,  -312,   309,
     310,   311,   320,  -312,   322,   304,   105,   321,   341,  -312,
     347,    49,  -312,   348,   164,   349,    39,  -312,  -312,  -312,
    -312,   355,   334,  -312,   227,  -312,   854,  -312,  -312,  -312,
    -312,   888,   888,   888,   888,   888,   794,  -312,   794,  -312,
     794,  -312,    39,  -312,  -312,  -312,   888,  -312,  -312,  -312,
    -312,  -312,  -312,  -312,  -312,    37,  -312,  -312,  -312,  -312
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -312,  -312,  -312,  -312,  -312,  -312,  -312,  -312,   -33,    99,
     288,  -312,  -312,   -78,  -312,   190,   196,  -312,   -91,  -312,
     -18,    27,  -312,   447,  -312,   -41,  -312,  -312,   326,  -312,
    -312,  -312,  -312,  -312,    68,  -312,  -312,  -195,  -312,  -312,
    -312,  -312,    85,  -312,  -312,  -312,  -312,  -208,  -189,  -312,
    -312,  -312,  -312,  -312,   145,  -312,  -312,   209,  -311,  -312,
      28,   -43,  -312,   338,  -312,  -312,   191,   197,   -35,  -312,
      44,  -312,   287,   -34,  -312,  -312,  -312,  -251,  -192,  -312,
       7,  -312,  -312,   -56,   -39,  -312,  -146,  -312,  -312,   437,
    -312,   195,  -312,  -157,  -312,  -148,  -312,   -45,   -23,  -138,
       1,  -312,   415,  -312,  -312,  -312,  -312,  -312,   291,  -151,
    -312,     8,  -312,  -288,   170,   -16,  -312,    57,   182,  -312,
      10
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -210
static const yytype_int16 yytable[] =
{
      25,    25,    27,    25,    25,   119,    66,   101,   161,   192,
       2,   168,   288,    66,   169,   113,   117,   256,   190,   248,
     259,   256,   256,   315,   315,    25,   257,   120,    98,   257,
     257,   257,   260,   261,   350,   165,   258,   317,    35,   258,
     258,   258,   316,   316,   369,   385,   210,    16,   101,   238,
     238,   121,  -204,   245,  -209,   239,   239,   181,    17,   119,
     240,   101,   230,    21,  -204,    18,  -209,   301,    22,    98,
     117,   199,    23,   175,   200,   246,   176,    19,   391,   241,
      21,   120,    98,    58,    59,    22,    31,    25,    20,    61,
      21,   265,     3,   351,   385,    22,   378,    32,   267,   268,
     223,    33,    84,    84,    36,   121,   212,    84,   165,    84,
      84,  -198,    21,    38,  -198,    37,   222,    22,   238,   140,
      41,     4,     5,     6,   239,  -200,     7,     8,  -200,   383,
      45,    40,   254,    42,    66,    43,    44,   230,    46,    49,
      50,    51,   210,   101,    84,   102,   103,   170,   384,   173,
     101,   101,   174,   178,   251,   288,   315,    84,   179,   290,
     191,    84,   197,    84,    98,   204,   281,   283,   284,   389,
     286,    98,    98,  -155,   219,   316,   303,   224,   225,   231,
     232,   291,   256,   233,   370,   371,    24,    26,   293,    29,
      30,   257,   215,   373,   234,   235,   236,   222,   237,   243,
     221,   258,   212,   304,   222,   292,   244,   253,   222,   222,
     222,   222,   222,   222,   222,    62,   262,   222,   222,   222,
     222,   222,   263,   271,   222,   222,   222,   222,   273,   251,
      84,    84,   -78,   167,    84,    84,    84,   279,    86,    84,
     290,   371,   -79,   295,   298,    87,    84,    84,    88,   299,
     332,   349,    89,   300,   305,    84,   335,   334,    84,    84,
      84,   294,   291,    54,    55,    56,    57,   336,    21,   293,
     338,    58,    59,    22,   337,    60,   339,    61,    62,   340,
     222,   221,   341,   394,   342,   304,   292,   182,   215,   189,
     344,   343,   306,   307,   308,   309,   310,   311,   312,   345,
     346,   318,   290,   347,   201,   348,   167,   202,   360,   362,
     361,   328,   363,   286,   167,   364,   251,   365,   303,   251,
     251,   366,   367,   374,   291,   399,   401,   402,   403,   405,
     376,   293,  -161,   379,  -163,   101,   290,   290,   290,   290,
     290,   395,   294,   380,  -162,   304,   381,   382,   292,   296,
     251,   290,   252,   386,   388,   390,    98,   393,   291,   291,
     291,   291,   291,   392,   358,   293,   293,   293,   293,   293,
     222,   375,   222,   291,   222,   180,   251,   134,   264,   266,
     293,   359,   292,   292,   292,   292,   292,   326,   108,   387,
     377,   196,   404,   282,   193,   167,    84,   292,   280,   289,
     409,     0,   167,     0,   294,     0,   167,   167,   167,   167,
     167,   167,   167,     0,     0,   167,   167,   167,   167,   167,
       0,     0,   167,   167,   167,   167,     0,   252,     0,     0,
       0,    84,     0,    84,     0,     0,     0,     0,   294,   294,
     294,   294,   294,   320,   321,   322,   323,     0,     0,   324,
     325,   327,     0,   294,   406,     0,   407,     0,   408,     0,
      81,    81,     0,     0,   245,    81,     0,    81,    81,     0,
       0,     0,   329,     0,     0,     0,     0,     0,   167,     0,
     357,     0,    69,    69,     0,     0,   246,    69,     0,    69,
      69,    21,     0,   100,    58,    59,    22,   106,    54,    55,
      61,     0,    81,    21,   285,     0,    58,    59,    22,     0,
       0,     0,    61,    62,   252,    81,     0,   252,   252,    81,
       0,    81,    54,    55,    69,     0,   129,    21,   130,     0,
      58,    59,    22,   131,   100,     0,    61,    69,     0,     0,
       0,    69,   289,    69,     0,     0,     0,   100,   252,     0,
       0,   106,     0,   106,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   167,     0,
     167,   213,   167,     0,   252,     0,   400,   400,   400,   400,
     400,     0,     0,     0,     0,     0,     0,     0,    81,    81,
       0,   400,    81,    81,    81,     0,     0,    81,     0,     0,
       0,     0,     0,     0,    81,    81,   270,     0,   201,     0,
      69,     0,   278,    81,     0,   183,    81,    81,    81,    69,
     184,   185,   186,     0,     0,     0,    69,    69,   272,   100,
       0,   187,   188,   202,     0,    69,   100,   100,    69,    69,
      69,     0,     0,     0,     0,   106,     0,     0,   106,   106,
     106,   205,     0,   122,     0,     0,     0,   206,   183,   207,
       0,     0,     0,   184,   185,   186,   124,   213,     0,   208,
       0,     0,     0,    89,   187,   188,   209,     0,     0,     0,
     126,   127,     0,     0,   128,    55,     0,    57,   129,    21,
     130,     0,    58,    59,    22,   131,    60,     0,    61,    62,
     205,     0,   122,     0,     0,     0,   206,   183,   207,     0,
       0,     0,   184,   185,   186,   220,     0,     0,   208,     0,
       0,     0,    89,   187,   188,   209,     0,     0,     0,   126,
     127,     0,     0,   128,    55,     0,    57,   129,    21,   130,
     122,    58,    59,    22,   131,    60,   123,    61,    62,     0,
       0,     0,     0,   124,    81,     0,   125,     0,     0,   270,
      89,   278,     0,     0,     0,     0,     0,   126,   127,     0,
       0,   128,    55,     0,    57,   129,    21,   130,     0,    58,
      59,    22,   131,    60,     0,    61,    62,     0,     0,    81,
       0,    81,    54,    55,    56,    57,     0,    21,     0,   122,
      58,    59,    22,     0,    60,   123,    61,    62,     0,     0,
       0,    69,   220,    69,     0,   125,     0,     0,     0,    89,
       0,   100,     0,   106,     0,     0,   126,   127,     0,     0,
     128,    55,     0,    57,   129,    21,   130,     0,    58,    59,
      22,   131,    60,    86,    61,    62,     0,     0,     0,     0,
     104,     0,     0,    88,     0,     0,     0,    89,     0,     0,
       0,     0,     0,     0,     0,    86,     0,     0,    54,    55,
      56,    57,   198,    21,     0,    88,    58,    59,    22,    89,
      60,     0,    61,    62,     0,     0,     0,     0,     0,    52,
      54,    55,    56,    57,     0,    21,    53,     0,    58,    59,
      22,     0,    60,     0,    61,    62,   396,    54,    55,    56,
      57,     0,    21,     0,     0,    58,    59,    22,     0,    60,
       0,    61,    62,     0,    54,    55,     0,     0,   129,    21,
     130,    53,    58,    59,    22,   131,     0,     0,    61,     0,
       0,     0,    54,    55,    56,    57,     0,    21,     0,     0,
      58,    59,    22,     0,    60,     0,    61,    62,   226,   227,
       0,     0,     0,   -54,   228,   183,     0,     0,     0,     0,
     184,   185,   186,     0,     0,     0,     0,     0,   -54,   226,
     227,   187,   188,   229,   296,   228,   183,     0,     0,     0,
       0,   184,   185,   186,   182,     0,     0,     0,   201,   297,
       0,   183,   187,   188,   229,   183,   184,   185,   186,     0,
     184,   185,   186,     0,     0,     0,     0,   187,   188,   189,
       0,   187,   188,   202
};

static const yytype_int16 yycheck[] =
{
      16,    17,    18,    19,    20,    50,    45,    46,    51,   100,
       0,    52,   204,    52,    53,    50,    50,   174,    96,   170,
     177,   178,   179,   231,   232,    41,   174,    50,    46,   177,
     178,   179,   178,   179,   285,    51,   174,   232,    28,   177,
     178,   179,   231,   232,   332,   356,   124,    18,    87,    13,
      13,    50,     6,    14,     6,    19,    19,    90,    18,   104,
      24,   100,   140,    41,    18,    18,    18,    18,    46,    87,
     104,   106,    50,     9,   107,    36,    12,    18,   366,    43,
      41,   104,   100,    44,    45,    46,     8,   103,    18,    50,
      41,   182,     0,   285,   405,    46,   347,     8,   189,   190,
     133,     8,    45,    46,     8,   104,   124,    50,   124,    52,
      53,     9,    41,    41,    12,     8,   132,    46,    13,    51,
      14,    29,    30,    31,    19,     9,    34,    35,    12,    24,
       8,    32,   173,    23,   173,    36,    37,   215,     8,    20,
       8,     8,   220,   182,    87,    22,     8,     8,    43,    28,
     189,   190,    18,    18,   170,   347,   364,   100,    18,   204,
      14,   104,    14,   106,   182,     6,   201,   202,   203,   364,
     204,   189,   190,     6,    14,   364,   219,    28,     3,    14,
      14,   204,   339,     4,   335,   336,    16,    17,   204,    19,
      20,   339,   124,   339,     6,     6,    24,   213,    43,     7,
     132,   339,   220,   219,   220,   204,    23,    23,   224,   225,
     226,   227,   228,   229,   230,    51,    23,   233,   234,   235,
     236,   237,    23,    23,   240,   241,   242,   243,    23,   245,
     173,   174,    14,    51,   177,   178,   179,    23,    11,   182,
     285,   392,    14,    23,    23,    18,   189,   190,    21,    23,
       8,   285,    25,    23,    23,   198,     6,   247,   201,   202,
     203,   204,   285,    36,    37,    38,    39,    18,    41,   285,
      23,    44,    45,    46,    20,    48,     8,    50,    51,    23,
     296,   213,    23,   374,    20,   301,   285,     3,   220,    28,
       8,    22,   224,   225,   226,   227,   228,   229,   230,    22,
       8,   233,   347,     6,     3,    20,   124,    28,    22,    20,
       8,   243,    22,   347,   132,     8,   332,    22,   361,   335,
     336,     8,    22,     6,   347,   381,   382,   383,   384,   385,
       6,   347,    23,    23,    23,   374,   381,   382,   383,   384,
     385,   376,   285,    23,    23,   361,    24,    43,   347,     8,
     366,   396,   170,     6,     6,     6,   374,    23,   381,   382,
     383,   384,   385,     8,   296,   381,   382,   383,   384,   385,
     386,   344,   388,   396,   390,    87,   392,    51,   182,   189,
     396,   296,   381,   382,   383,   384,   385,   242,    50,   361,
     346,   104,   385,   202,   103,   213,   339,   396,   201,   204,
     392,    -1,   220,    -1,   347,    -1,   224,   225,   226,   227,
     228,   229,   230,    -1,    -1,   233,   234,   235,   236,   237,
      -1,    -1,   240,   241,   242,   243,    -1,   245,    -1,    -1,
      -1,   374,    -1,   376,    -1,    -1,    -1,    -1,   381,   382,
     383,   384,   385,   234,   235,   236,   237,    -1,    -1,   240,
     241,   242,    -1,   396,   386,    -1,   388,    -1,   390,    -1,
      45,    46,    -1,    -1,    14,    50,    -1,    52,    53,    -1,
      -1,    -1,    22,    -1,    -1,    -1,    -1,    -1,   296,    -1,
     285,    -1,    45,    46,    -1,    -1,    36,    50,    -1,    52,
      53,    41,    -1,    46,    44,    45,    46,    50,    36,    37,
      50,    -1,    87,    41,    18,    -1,    44,    45,    46,    -1,
      -1,    -1,    50,    51,   332,   100,    -1,   335,   336,   104,
      -1,   106,    36,    37,    87,    -1,    40,    41,    42,    -1,
      44,    45,    46,    47,    87,    -1,    50,   100,    -1,    -1,
      -1,   104,   347,   106,    -1,    -1,    -1,   100,   366,    -1,
      -1,   104,    -1,   106,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   386,    -1,
     388,   124,   390,    -1,   392,    -1,   381,   382,   383,   384,
     385,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   173,   174,
      -1,   396,   177,   178,   179,    -1,    -1,   182,    -1,    -1,
      -1,    -1,    -1,    -1,   189,   190,   191,    -1,     3,    -1,
     173,    -1,   197,   198,    -1,    10,   201,   202,   203,   182,
      15,    16,    17,    -1,    -1,    -1,   189,   190,    23,   182,
      -1,    26,    27,    28,    -1,   198,   189,   190,   201,   202,
     203,    -1,    -1,    -1,    -1,   198,    -1,    -1,   201,   202,
     203,     3,    -1,     5,    -1,    -1,    -1,     9,    10,    11,
      -1,    -1,    -1,    15,    16,    17,    18,   220,    -1,    21,
      -1,    -1,    -1,    25,    26,    27,    28,    -1,    -1,    -1,
      32,    33,    -1,    -1,    36,    37,    -1,    39,    40,    41,
      42,    -1,    44,    45,    46,    47,    48,    -1,    50,    51,
       3,    -1,     5,    -1,    -1,    -1,     9,    10,    11,    -1,
      -1,    -1,    15,    16,    17,    18,    -1,    -1,    21,    -1,
      -1,    -1,    25,    26,    27,    28,    -1,    -1,    -1,    32,
      33,    -1,    -1,    36,    37,    -1,    39,    40,    41,    42,
       5,    44,    45,    46,    47,    48,    11,    50,    51,    -1,
      -1,    -1,    -1,    18,   339,    -1,    21,    -1,    -1,   344,
      25,   346,    -1,    -1,    -1,    -1,    -1,    32,    33,    -1,
      -1,    36,    37,    -1,    39,    40,    41,    42,    -1,    44,
      45,    46,    47,    48,    -1,    50,    51,    -1,    -1,   374,
      -1,   376,    36,    37,    38,    39,    -1,    41,    -1,     5,
      44,    45,    46,    -1,    48,    11,    50,    51,    -1,    -1,
      -1,   374,    18,   376,    -1,    21,    -1,    -1,    -1,    25,
      -1,   374,    -1,   376,    -1,    -1,    32,    33,    -1,    -1,
      36,    37,    -1,    39,    40,    41,    42,    -1,    44,    45,
      46,    47,    48,    11,    50,    51,    -1,    -1,    -1,    -1,
      18,    -1,    -1,    21,    -1,    -1,    -1,    25,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    11,    -1,    -1,    36,    37,
      38,    39,    18,    41,    -1,    21,    44,    45,    46,    25,
      48,    -1,    50,    51,    -1,    -1,    -1,    -1,    -1,    18,
      36,    37,    38,    39,    -1,    41,    25,    -1,    44,    45,
      46,    -1,    48,    -1,    50,    51,    18,    36,    37,    38,
      39,    -1,    41,    -1,    -1,    44,    45,    46,    -1,    48,
      -1,    50,    51,    -1,    36,    37,    -1,    -1,    40,    41,
      42,    25,    44,    45,    46,    47,    -1,    -1,    50,    -1,
      -1,    -1,    36,    37,    38,    39,    -1,    41,    -1,    -1,
      44,    45,    46,    -1,    48,    -1,    50,    51,     3,     4,
      -1,    -1,    -1,     8,     9,    10,    -1,    -1,    -1,    -1,
      15,    16,    17,    -1,    -1,    -1,    -1,    -1,    23,     3,
       4,    26,    27,    28,     8,     9,    10,    -1,    -1,    -1,
      -1,    15,    16,    17,     3,    -1,    -1,    -1,     3,    23,
      -1,    10,    26,    27,    28,    10,    15,    16,    17,    -1,
      15,    16,    17,    -1,    -1,    -1,    -1,    26,    27,    28,
      -1,    26,    27,    28
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    53,   172,     0,    29,    30,    31,    34,    35,    54,
      55,    56,    57,    58,    59,   158,    18,    18,    18,    18,
      18,    41,    46,    50,   166,   167,   166,   167,   171,   166,
     166,     8,     8,     8,   159,   172,     8,     8,    41,    61,
      61,    14,    23,    61,    61,     8,     8,   160,   166,    20,
       8,     8,    18,    25,    36,    37,    38,    39,    44,    45,
      48,    50,    51,    76,    77,    78,   136,   137,   139,   141,
     142,   144,   145,   146,   147,   148,   149,   150,   151,   152,
     153,   154,   167,   168,   169,   170,    11,    18,    21,    25,
      62,    63,    64,    66,    67,    68,    70,    71,    72,    74,
      75,   136,    22,     8,    18,    72,    75,   114,   115,   116,
     117,   118,   119,   120,   121,   123,   124,   125,   136,   149,
     150,   152,     5,    11,    18,    21,    32,    33,    36,    40,
      42,    47,    75,    79,    80,    81,    82,    83,    84,    85,
      86,    87,    88,    90,    91,    92,    93,    95,    96,    97,
      99,   100,   101,   102,   103,   105,   106,   107,   108,   109,
     111,   113,   141,   143,   154,   167,   169,   170,    77,   136,
       8,    60,   172,    28,    18,     9,    12,   140,    18,    18,
      62,    60,     3,    10,    15,    16,    17,    26,    27,    28,
      65,    14,    70,   160,   115,   120,   124,    14,    18,   120,
      60,     3,    28,    65,     6,     3,     9,    11,    21,    28,
      65,    69,    72,    75,    80,    86,    94,   104,   113,    14,
      18,    86,   167,    60,    28,     3,     3,     4,     9,    28,
      65,    14,    14,     4,     6,     6,    24,    43,    13,    19,
      24,    43,   110,     7,    23,    14,    36,   155,   161,   162,
     164,   167,   170,    23,    77,   138,   145,   147,   151,   145,
     138,   138,    23,    23,    68,    70,    67,    70,    70,    73,
     154,    23,    23,    23,   122,   126,   127,   128,   154,    23,
     119,   120,   118,   120,   120,    18,   125,   129,   130,   143,
     149,   150,   152,   167,   169,    23,     8,    23,    23,    23,
      23,    18,   112,   113,   167,    23,    86,    86,    86,    86,
      86,    86,    86,    89,    98,    99,   100,    89,    86,    86,
     109,   109,   109,   109,   109,   109,   106,   109,    86,    22,
     161,   165,     8,   156,   172,     6,    18,    20,    23,     8,
      23,    23,    20,    22,     8,    22,     8,     6,    20,   125,
     129,   130,   131,   132,   133,   134,   135,   143,    86,    94,
      22,     8,    20,    22,     8,    22,     8,    22,   157,   165,
     161,   161,   163,   138,     6,    73,     6,   122,   129,    23,
      23,    24,    43,    24,    43,   110,     6,   112,     6,    89,
       6,   165,     8,    23,    70,   120,    18,   125,   130,   135,
     143,   135,   135,   135,   132,   135,    86,    86,    86,   163
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
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
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


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
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

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
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



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

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
  if (yyn == YYPACT_NINF)
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
      if (yyn == 0 || yyn == YYTABLE_NINF)
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

/* Line 1455 of yacc.c  */
#line 150 "hotptp-1.y"
    {;}
    break;

  case 3:

/* Line 1455 of yacc.c  */
#line 151 "hotptp-1.y"
    {;}
    break;

  case 4:

/* Line 1455 of yacc.c  */
#line 154 "hotptp-1.y"
    {P_PRINT((yyval.pval));;}
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 155 "hotptp-1.y"
    {P_PRINT((yyval.pval));;}
    break;

  case 6:

/* Line 1455 of yacc.c  */
#line 158 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 7:

/* Line 1455 of yacc.c  */
#line 159 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 8:

/* Line 1455 of yacc.c  */
#line 160 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 9:

/* Line 1455 of yacc.c  */
#line 161 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotated_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 164 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("fof_annotated", P_TOKEN("_LIT_fof ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));;}
    break;

  case 11:

/* Line 1455 of yacc.c  */
#line 167 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("cnf_annotated", P_TOKEN("_LIT_cnf ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));;}
    break;

  case 12:

/* Line 1455 of yacc.c  */
#line 170 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_annotated", P_TOKEN("_LIT_thf ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));;}
    break;

  case 13:

/* Line 1455 of yacc.c  */
#line 173 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_annotated", P_TOKEN("_LIT_tff ", (yyvsp[(1) - (10)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (10)].ival)), (yyvsp[(3) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(4) - (10)].ival)), (yyvsp[(5) - (10)].pval), P_TOKEN("COMMA ", (yyvsp[(6) - (10)].ival)), (yyvsp[(7) - (10)].pval), (yyvsp[(8) - (10)].pval), P_TOKEN("RPAREN ", (yyvsp[(9) - (10)].ival)), P_TOKEN("PERIOD ", (yyvsp[(10) - (10)].ival)));;}
    break;

  case 14:

/* Line 1455 of yacc.c  */
#line 176 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotations", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 177 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("annotations", P_TOKEN("COMMA ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 180 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("formula_role", P_TOKEN("lower_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 17:

/* Line 1455 of yacc.c  */
#line 183 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("fof_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 184 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("fof_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 187 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 188 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 191 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("nonassoc_binary", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 194 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 195 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("EQUALS_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 196 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_EQUALS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 197 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("LESS_TILDE_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 198 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("TILDE_VLINE ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 199 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("binary_connective", P_TOKEN("TILDE_AMPERSAND ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 202 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 203 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 206 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 207 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 210 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 211 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 34:

/* Line 1455 of yacc.c  */
#line 214 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("assoc_connective", P_TOKEN("VLINE ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 215 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("assoc_connective", P_TOKEN("AMPERSAND ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 36:

/* Line 1455 of yacc.c  */
#line 218 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 219 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 38:

/* Line 1455 of yacc.c  */
#line 220 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 221 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 224 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("quantified_formula", (yyvsp[(1) - (6)].pval), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);;}
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 227 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("quantifier", P_TOKEN("EXCLAMATION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 228 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("quantifier", P_TOKEN("QUESTION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 43:

/* Line 1455 of yacc.c  */
#line 231 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("variable_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 232 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("variable_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 45:

/* Line 1455 of yacc.c  */
#line 235 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unary_formula", (yyvsp[(1) - (2)].pval), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 238 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("unary_connective", P_TOKEN("TILDE ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 241 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("cnf_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 242 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("cnf_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 49:

/* Line 1455 of yacc.c  */
#line 245 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("disjunction", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 50:

/* Line 1455 of yacc.c  */
#line 246 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("disjunction", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 51:

/* Line 1455 of yacc.c  */
#line 249 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("literal", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 52:

/* Line 1455 of yacc.c  */
#line 250 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("literal", P_TOKEN("TILDE ", (yyvsp[(1) - (2)].ival)), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 53:

/* Line 1455 of yacc.c  */
#line 253 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 54:

/* Line 1455 of yacc.c  */
#line 254 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 55:

/* Line 1455 of yacc.c  */
#line 255 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 56:

/* Line 1455 of yacc.c  */
#line 258 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 57:

/* Line 1455 of yacc.c  */
#line 259 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 58:

/* Line 1455 of yacc.c  */
#line 260 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 59:

/* Line 1455 of yacc.c  */
#line 261 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 60:

/* Line 1455 of yacc.c  */
#line 262 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 61:

/* Line 1455 of yacc.c  */
#line 265 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_nonassoc_formula", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 62:

/* Line 1455 of yacc.c  */
#line 268 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_equality", (yyvsp[(1) - (3)].pval), P_TOKEN("EQUALS ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 63:

/* Line 1455 of yacc.c  */
#line 271 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_assoc_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 64:

/* Line 1455 of yacc.c  */
#line 272 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_assoc_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 65:

/* Line 1455 of yacc.c  */
#line 275 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 66:

/* Line 1455 of yacc.c  */
#line 276 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 67:

/* Line 1455 of yacc.c  */
#line 279 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 68:

/* Line 1455 of yacc.c  */
#line 280 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 69:

/* Line 1455 of yacc.c  */
#line 283 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 70:

/* Line 1455 of yacc.c  */
#line 284 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 71:

/* Line 1455 of yacc.c  */
#line 285 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 72:

/* Line 1455 of yacc.c  */
#line 286 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 73:

/* Line 1455 of yacc.c  */
#line 287 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 74:

/* Line 1455 of yacc.c  */
#line 288 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 75:

/* Line 1455 of yacc.c  */
#line 289 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 76:

/* Line 1455 of yacc.c  */
#line 290 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 77:

/* Line 1455 of yacc.c  */
#line 293 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_quantified_formula", (yyvsp[(1) - (6)].pval), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);;}
    break;

  case 78:

/* Line 1455 of yacc.c  */
#line 296 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_quantifier", P_TOKEN("EXCLAMATION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 79:

/* Line 1455 of yacc.c  */
#line 297 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_quantifier", P_TOKEN("QUESTION ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 80:

/* Line 1455 of yacc.c  */
#line 300 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_variable_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 81:

/* Line 1455 of yacc.c  */
#line 301 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_variable_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 82:

/* Line 1455 of yacc.c  */
#line 304 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unary_formula", (yyvsp[(1) - (2)].pval), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 83:

/* Line 1455 of yacc.c  */
#line 307 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_abstraction", (yyvsp[(1) - (6)].pval), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);;}
    break;

  case 84:

/* Line 1455 of yacc.c  */
#line 310 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_lambda", P_TOKEN("_LIT_lambda ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 85:

/* Line 1455 of yacc.c  */
#line 311 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_lambda", P_TOKEN("CARET ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 86:

/* Line 1455 of yacc.c  */
#line 314 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_apply_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AT_SIGN ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 87:

/* Line 1455 of yacc.c  */
#line 315 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_apply_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AT_SIGN ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 88:

/* Line 1455 of yacc.c  */
#line 318 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_tuple", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 89:

/* Line 1455 of yacc.c  */
#line 319 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_tuple", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 90:

/* Line 1455 of yacc.c  */
#line 322 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 91:

/* Line 1455 of yacc.c  */
#line 323 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 92:

/* Line 1455 of yacc.c  */
#line 326 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_typed_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 93:

/* Line 1455 of yacc.c  */
#line 327 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_typed_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 94:

/* Line 1455 of yacc.c  */
#line 330 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 95:

/* Line 1455 of yacc.c  */
#line 331 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 96:

/* Line 1455 of yacc.c  */
#line 334 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 97:

/* Line 1455 of yacc.c  */
#line 335 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 98:

/* Line 1455 of yacc.c  */
#line 338 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_typed_variable", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 99:

/* Line 1455 of yacc.c  */
#line 341 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 100:

/* Line 1455 of yacc.c  */
#line 344 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_typed_constant", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 101:

/* Line 1455 of yacc.c  */
#line 347 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 102:

/* Line 1455 of yacc.c  */
#line 348 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 103:

/* Line 1455 of yacc.c  */
#line 349 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", P_TOKEN("distinct_object ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 104:

/* Line 1455 of yacc.c  */
#line 350 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 105:

/* Line 1455 of yacc.c  */
#line 351 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 106:

/* Line 1455 of yacc.c  */
#line 352 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_untyped_constant", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 107:

/* Line 1455 of yacc.c  */
#line 355 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_defined_word", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 108:

/* Line 1455 of yacc.c  */
#line 356 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_defined_word", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 109:

/* Line 1455 of yacc.c  */
#line 359 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tptp_operator", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 110:

/* Line 1455 of yacc.c  */
#line 360 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tptp_operator", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 111:

/* Line 1455 of yacc.c  */
#line 361 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tptp_operator", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 112:

/* Line 1455 of yacc.c  */
#line 362 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tptp_operator", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 113:

/* Line 1455 of yacc.c  */
#line 363 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tptp_operator", P_TOKEN("EQUALS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 114:

/* Line 1455 of yacc.c  */
#line 366 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 115:

/* Line 1455 of yacc.c  */
#line 367 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 116:

/* Line 1455 of yacc.c  */
#line 368 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 117:

/* Line 1455 of yacc.c  */
#line 371 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_mapping_type", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 118:

/* Line 1455 of yacc.c  */
#line 372 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_mapping_type", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 119:

/* Line 1455 of yacc.c  */
#line 375 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_xprod_type", (yyvsp[(1) - (3)].pval), P_TOKEN("STAR ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 120:

/* Line 1455 of yacc.c  */
#line 376 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_xprod_type", (yyvsp[(1) - (3)].pval), P_TOKEN("STAR ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 121:

/* Line 1455 of yacc.c  */
#line 379 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_union_type", (yyvsp[(1) - (3)].pval), P_TOKEN("plus ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 122:

/* Line 1455 of yacc.c  */
#line 380 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_union_type", (yyvsp[(1) - (3)].pval), P_TOKEN("plus ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 123:

/* Line 1455 of yacc.c  */
#line 383 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_unitary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 124:

/* Line 1455 of yacc.c  */
#line 386 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("map_arrow", P_TOKEN("MINUS_GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 125:

/* Line 1455 of yacc.c  */
#line 387 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("map_arrow", P_TOKEN("GREATER ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 126:

/* Line 1455 of yacc.c  */
#line 390 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_let_rec", P_TOKEN("_LIT_letrec ", (yyvsp[(1) - (6)].ival)), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);;}
    break;

  case 127:

/* Line 1455 of yacc.c  */
#line 393 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_definition_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 128:

/* Line 1455 of yacc.c  */
#line 394 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_definition_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 129:

/* Line 1455 of yacc.c  */
#line 397 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_definition", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON_EQUALS ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 130:

/* Line 1455 of yacc.c  */
#line 398 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("thf_definition", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 131:

/* Line 1455 of yacc.c  */
#line 401 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 132:

/* Line 1455 of yacc.c  */
#line 402 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 133:

/* Line 1455 of yacc.c  */
#line 403 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 134:

/* Line 1455 of yacc.c  */
#line 406 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 135:

/* Line 1455 of yacc.c  */
#line 407 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_binary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 136:

/* Line 1455 of yacc.c  */
#line 410 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_nonassoc_binary", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 137:

/* Line 1455 of yacc.c  */
#line 413 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 138:

/* Line 1455 of yacc.c  */
#line 414 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_assoc_binary", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 139:

/* Line 1455 of yacc.c  */
#line 417 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 140:

/* Line 1455 of yacc.c  */
#line 418 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_or_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("VLINE ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 141:

/* Line 1455 of yacc.c  */
#line 421 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 142:

/* Line 1455 of yacc.c  */
#line 422 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_and_formula", (yyvsp[(1) - (3)].pval), P_TOKEN("AMPERSAND ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 143:

/* Line 1455 of yacc.c  */
#line 425 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 144:

/* Line 1455 of yacc.c  */
#line 426 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 145:

/* Line 1455 of yacc.c  */
#line 427 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 146:

/* Line 1455 of yacc.c  */
#line 428 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 147:

/* Line 1455 of yacc.c  */
#line 429 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_formula", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 148:

/* Line 1455 of yacc.c  */
#line 432 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_quantified_formula", (yyvsp[(1) - (6)].pval), P_TOKEN("LBRKT ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (6)].ival)), P_TOKEN("COLON ", (yyvsp[(5) - (6)].ival)), (yyvsp[(6) - (6)].pval), 0, 0, 0, 0);;}
    break;

  case 149:

/* Line 1455 of yacc.c  */
#line 435 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_variable_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 150:

/* Line 1455 of yacc.c  */
#line 436 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_variable_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 151:

/* Line 1455 of yacc.c  */
#line 439 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unary_formula", (yyvsp[(1) - (2)].pval), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 152:

/* Line 1455 of yacc.c  */
#line 442 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_typed_atom", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 153:

/* Line 1455 of yacc.c  */
#line 443 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_typed_atom", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 154:

/* Line 1455 of yacc.c  */
#line 446 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_untyped_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 155:

/* Line 1455 of yacc.c  */
#line 447 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_untyped_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 156:

/* Line 1455 of yacc.c  */
#line 448 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_untyped_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 157:

/* Line 1455 of yacc.c  */
#line 451 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 158:

/* Line 1455 of yacc.c  */
#line 452 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 159:

/* Line 1455 of yacc.c  */
#line 455 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_typed_variable", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 160:

/* Line 1455 of yacc.c  */
#line 458 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_untyped_variable", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 161:

/* Line 1455 of yacc.c  */
#line 461 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_type_spec", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 162:

/* Line 1455 of yacc.c  */
#line 462 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_type_spec", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 163:

/* Line 1455 of yacc.c  */
#line 463 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_type_spec", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 164:

/* Line 1455 of yacc.c  */
#line 464 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_type_spec", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 165:

/* Line 1455 of yacc.c  */
#line 467 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_type_expr", P_TOKEN("LPAREN ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RPAREN ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 166:

/* Line 1455 of yacc.c  */
#line 470 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 167:

/* Line 1455 of yacc.c  */
#line 471 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 168:

/* Line 1455 of yacc.c  */
#line 472 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_binary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 169:

/* Line 1455 of yacc.c  */
#line 475 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_mapping_type", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 170:

/* Line 1455 of yacc.c  */
#line 476 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_mapping_type", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 171:

/* Line 1455 of yacc.c  */
#line 479 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_xprod_type", (yyvsp[(1) - (3)].pval), P_TOKEN("STAR ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 172:

/* Line 1455 of yacc.c  */
#line 480 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_xprod_type", (yyvsp[(1) - (3)].pval), P_TOKEN("STAR ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 173:

/* Line 1455 of yacc.c  */
#line 483 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_union_type", (yyvsp[(1) - (3)].pval), P_TOKEN("plus ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 174:

/* Line 1455 of yacc.c  */
#line 484 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_union_type", (yyvsp[(1) - (3)].pval), P_TOKEN("plus ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 175:

/* Line 1455 of yacc.c  */
#line 487 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 176:

/* Line 1455 of yacc.c  */
#line 488 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 177:

/* Line 1455 of yacc.c  */
#line 489 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("tff_unitary_type", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 178:

/* Line 1455 of yacc.c  */
#line 492 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 179:

/* Line 1455 of yacc.c  */
#line 493 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 180:

/* Line 1455 of yacc.c  */
#line 494 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_formula", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 181:

/* Line 1455 of yacc.c  */
#line 497 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("plain_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 182:

/* Line 1455 of yacc.c  */
#line 500 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("arguments", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 183:

/* Line 1455 of yacc.c  */
#line 501 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("arguments", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 184:

/* Line 1455 of yacc.c  */
#line 504 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 185:

/* Line 1455 of yacc.c  */
#line 505 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);;}
    break;

  case 186:

/* Line 1455 of yacc.c  */
#line 506 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_atom", (yyvsp[(1) - (3)].pval), (yyvsp[(2) - (3)].pval), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 187:

/* Line 1455 of yacc.c  */
#line 509 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_infix_pred", P_TOKEN("EQUALS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 188:

/* Line 1455 of yacc.c  */
#line 510 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_infix_pred", P_TOKEN("EXCLAMATION_EQUALS ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 189:

/* Line 1455 of yacc.c  */
#line 513 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_prop", P_TOKEN("trueProp ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 190:

/* Line 1455 of yacc.c  */
#line 514 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_prop", P_TOKEN("falseProp ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 191:

/* Line 1455 of yacc.c  */
#line 517 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_pred", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 192:

/* Line 1455 of yacc.c  */
#line 520 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_type", P_TOKEN("oType ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 193:

/* Line 1455 of yacc.c  */
#line 521 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_type", P_TOKEN("iType ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 194:

/* Line 1455 of yacc.c  */
#line 522 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_type", P_TOKEN("tType ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 195:

/* Line 1455 of yacc.c  */
#line 525 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("system_atom", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 196:

/* Line 1455 of yacc.c  */
#line 528 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 197:

/* Line 1455 of yacc.c  */
#line 529 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 198:

/* Line 1455 of yacc.c  */
#line 532 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 199:

/* Line 1455 of yacc.c  */
#line 533 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 200:

/* Line 1455 of yacc.c  */
#line 534 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("function_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 201:

/* Line 1455 of yacc.c  */
#line 537 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("plain_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 202:

/* Line 1455 of yacc.c  */
#line 538 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("plain_term", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);;}
    break;

  case 203:

/* Line 1455 of yacc.c  */
#line 541 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 204:

/* Line 1455 of yacc.c  */
#line 544 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("functor", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 205:

/* Line 1455 of yacc.c  */
#line 547 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 206:

/* Line 1455 of yacc.c  */
#line 548 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("defined_term", P_TOKEN("distinct_object ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 207:

/* Line 1455 of yacc.c  */
#line 551 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("system_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 208:

/* Line 1455 of yacc.c  */
#line 552 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("system_term", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);;}
    break;

  case 209:

/* Line 1455 of yacc.c  */
#line 555 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("system_functor", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 210:

/* Line 1455 of yacc.c  */
#line 558 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("system_constant", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 211:

/* Line 1455 of yacc.c  */
#line 561 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("variable", P_TOKEN("upper_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 212:

/* Line 1455 of yacc.c  */
#line 564 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("source", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 213:

/* Line 1455 of yacc.c  */
#line 567 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("optional_info", P_TOKEN("COMMA ", (yyvsp[(1) - (2)].ival)), (yyvsp[(2) - (2)].pval), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 214:

/* Line 1455 of yacc.c  */
#line 568 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("optional_info", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 215:

/* Line 1455 of yacc.c  */
#line 571 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("useful_info", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 216:

/* Line 1455 of yacc.c  */
#line 574 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("include", P_TOKEN("_LIT_include ", (yyvsp[(1) - (6)].ival)), P_TOKEN("LPAREN ", (yyvsp[(2) - (6)].ival)), (yyvsp[(3) - (6)].pval), (yyvsp[(4) - (6)].pval), P_TOKEN("RPAREN ", (yyvsp[(5) - (6)].ival)), P_TOKEN("PERIOD ", (yyvsp[(6) - (6)].ival)), 0, 0, 0, 0);;}
    break;

  case 217:

/* Line 1455 of yacc.c  */
#line 577 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("formula_selection", P_TOKEN("COMMA ", (yyvsp[(1) - (4)].ival)), P_TOKEN("LBRKT ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RBRKT ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);;}
    break;

  case 218:

/* Line 1455 of yacc.c  */
#line 578 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("formula_selection", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 219:

/* Line 1455 of yacc.c  */
#line 581 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("name_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 220:

/* Line 1455 of yacc.c  */
#line 582 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("name_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 221:

/* Line 1455 of yacc.c  */
#line 585 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 222:

/* Line 1455 of yacc.c  */
#line 586 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_term", (yyvsp[(1) - (3)].pval), P_TOKEN("COLON ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 223:

/* Line 1455 of yacc.c  */
#line 587 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_term", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 224:

/* Line 1455 of yacc.c  */
#line 590 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_data", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 225:

/* Line 1455 of yacc.c  */
#line 591 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_data", (yyvsp[(1) - (4)].pval), P_TOKEN("LPAREN ", (yyvsp[(2) - (4)].ival)), (yyvsp[(3) - (4)].pval), P_TOKEN("RPAREN ", (yyvsp[(4) - (4)].ival)), 0, 0, 0, 0, 0, 0);;}
    break;

  case 226:

/* Line 1455 of yacc.c  */
#line 592 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_data", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 227:

/* Line 1455 of yacc.c  */
#line 593 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_data", P_TOKEN("distinct_object ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 228:

/* Line 1455 of yacc.c  */
#line 596 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_arguments", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 229:

/* Line 1455 of yacc.c  */
#line 597 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_arguments", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 230:

/* Line 1455 of yacc.c  */
#line 600 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_list", P_TOKEN("LBRKT ", (yyvsp[(1) - (2)].ival)), P_TOKEN("RBRKT ", (yyvsp[(2) - (2)].ival)), 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 231:

/* Line 1455 of yacc.c  */
#line 601 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_list", P_TOKEN("LBRKT ", (yyvsp[(1) - (3)].ival)), (yyvsp[(2) - (3)].pval), P_TOKEN("RBRKT ", (yyvsp[(3) - (3)].ival)), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 232:

/* Line 1455 of yacc.c  */
#line 604 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_term_list", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 233:

/* Line 1455 of yacc.c  */
#line 605 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("general_term_list", (yyvsp[(1) - (3)].pval), P_TOKEN("COMMA ", (yyvsp[(2) - (3)].ival)), (yyvsp[(3) - (3)].pval), 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 234:

/* Line 1455 of yacc.c  */
#line 608 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("name", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 235:

/* Line 1455 of yacc.c  */
#line 609 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("name", P_TOKEN("unsigned_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 236:

/* Line 1455 of yacc.c  */
#line 612 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_word", P_TOKEN("lower_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 237:

/* Line 1455 of yacc.c  */
#line 613 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_word", P_TOKEN("single_quoted ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 238:

/* Line 1455 of yacc.c  */
#line 616 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_defined_word", P_TOKEN("dollar_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 239:

/* Line 1455 of yacc.c  */
#line 619 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("atomic_system_word", P_TOKEN("dollar_dollar_word ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 240:

/* Line 1455 of yacc.c  */
#line 622 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("number", P_TOKEN("real ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 241:

/* Line 1455 of yacc.c  */
#line 623 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("number", P_TOKEN("signed_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 242:

/* Line 1455 of yacc.c  */
#line 624 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("number", P_TOKEN("unsigned_integer ", (yyvsp[(1) - (1)].ival)), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 243:

/* Line 1455 of yacc.c  */
#line 627 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("file_name", (yyvsp[(1) - (1)].pval), 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;

  case 244:

/* Line 1455 of yacc.c  */
#line 630 "hotptp-1.y"
    {(yyval.pval) = P_BUILD("null", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);;}
    break;



/* Line 1455 of yacc.c  */
#line 3714 "hotptp-1.tab.c"
      default: break;
    }
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
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
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
      if (yyn != YYPACT_NINF)
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
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
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



