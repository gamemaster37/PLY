%token OP-ESTA OP-AL OP-ASS COMP STR INT DEC LONG IMG VAR
%token AND ELSE IS RETURN BREAK FOR NOT WHILE CONTINUE IF OR DEF IMPORT PASS ELIF IN PRINT TRUE FALSE RANGE

%start MONDA

%{
extern int column;
%}

%%
MONDA: MULTIMONDA | MONDA MULTIMONDA |MONDA error|;

MULTIMONDA: Declaracion | Condicionals | ESfline | Varuse | Shiwtchline | Declaracion SALTO {column++;};

Forline: FOR '(' AUXfor IDENTIFIER '=' HYDRA ';' IDENTIFIER Cond_type HYDRA ';' IDENTIFIER ForPACK ')' '{'MONDA'}';
HYDRA: IDENTIFIER | INTVALUE;
AUXfor: INT | ;
ForPACK: INC_OP | DEC_OP | '+' HYDRA | '-' HYDRA;


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