#include "stdio.h"
#include <stdarg.h>

void yyerror(char *s, ...)
{
    va_list ap;
    va_start(ap, s);

    fprintf(stderr, "error: ");
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
}

//int yywrap() {
//    return 0;
//}


main( int argc, char *argv[] )
{
    int rc=0;
    /*
    extern FILE *yyin;
    ++argv;--argc;
    yyin = fopen( argv[0], "r");
    //yydebug = 1;
    //errors = 0;
    */
    rc=yyparse ();
    //fclose(yyin);
    return rc;
}
