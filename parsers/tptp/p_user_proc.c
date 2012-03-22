#  define P_ACT(ss) if(verbose)printf("%7d %s\n",yylineno,ss);
#  define P_BUILD(sym,A,B,C,D,E,F,G,H,I,J) pBuildTree(sym,A,B,C,D,E,F,G,H,I,J)
#  define P_TOKEN(tok,symIdx) pToken(tok,symIdx)
#  define P_PRINT(ss) if(verbose){printf("ast(");pPrintTree(ss,0);printf(").\n");}

#define MAX_CH 12
extern int yylineno;
extern int tptp_store_size;
extern char* tptp_lval[];
int verbose = P_VERBOSE;
char pTokenBuf[8247];
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
  strncpy(pTokenBuf, "'", 2);
  strncat(pTokenBuf, tok, 39);
  pTokenBuf[strlen(pTokenBuf)-1]='\0';
  strncat(pTokenBuf, "', '", 4);
  strncat(pTokenBuf, sym, 8193);
  strncat(pTokenBuf, "'", 2);
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
    { //for (d=0; d<depth; d++) printf("  ");
      // printf("%s\n",tptp_lval[j]);
      j = (j+1)%tptp_store_size; }
  return; }

void pPrintTree(pTree ss, int depth);
void pPrintTree(pTree ss, int depth)
{ int i, d;
  if (pPrintIdx >= 0)
    { pPrintComments(pPrintIdx, 0); pPrintIdx = -1;}
  if (ss == NULL) return;
  // for (d = 0; d < depth; d++) printf("  ");
  if (ss->ch[0] == 0) printf("l(%s", ss->sym);
  else printf("s(%s", ss->sym);
  if (strcmp(ss->sym, "'PERIOD', '.'") == 0)
    pPrintIdx = (ss->symIdx+1)%tptp_store_size;
  if (ss->symIdx >= 0)
    pPrintComments((ss->symIdx+1)%tptp_store_size, depth);
  i = 0;
  while(ss->ch[i] != 0) {
    printf(", "); 
    pPrintTree(ss->ch[i], depth+1); 
    i++;}
  printf(")");
  return; }
