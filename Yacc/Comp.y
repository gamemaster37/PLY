%token OPESTA OPAL OPASS COMP STR INT DEC LONG IMG VAR SALTO
%token AND ELSE IS RETURN BREAK FOR NOT WHILE CONTINUE IF OR DEF IMPORT PASS ELIF IN PRINT TRUE FALSE RANGE
%start START

%{
extern int column;
%}

%%
START: MULTISTART | START MULTISTART |START error|;

MULTISTART: DECLARACION SALTO {column++;};

DECLARACION: VAR OPASS VAR;



%%
#include <stdio.h>

extern char yytext[];

int main( int argc, char *argv[] )
{
   extern FILE *yyin, *yyout; 
   if( argc == 2 ) {
	yyin = fopen(argv[1], "r"); 
    if(yyin == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yyout = fopen("salida.txt", "w");
     if(yyout == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yyparse(); 
    fprintf(yyout,"\nTabla de Identificadores \n");
    printf("Exitoooooooo..... PARA SERVIRTE \n");
   }
   else if( argc > 2 ) {
      printf("Too many arguments supplied.\n");
   }
   else {
      printf("One argument expected.\n");
   }

    return 0;
}

yyerror(char *s)
{
    fprintf(stderr, " line %d: %s\n", column, s);
}