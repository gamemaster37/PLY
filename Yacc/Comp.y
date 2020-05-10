%token OPAL OPASS COMP STR INT DEC LONG IMG VAR SALTO MULT MENOS MAS
%start START

%{
extern int column;
%}

%%
START: MULTISTART | START MULTISTART |START error|;

MULTISTART:'PASS'| DECLARACION | IMPORT | DEF | PRINT | WHILE | FOR | DERAGEX | IF |SALTO {column++;};

NEWNUMBER:OPESTA NUMBER | NUMBER;
OPESTA: MAS|MENOS;
NUMBER:INT|LONG|IMG;

DECLARACION: VAR DECLA DERANGE END;
DECLA:  ',' VAR  DECLA DERANGE ',' | OPASS ;

DERANGE: EXPRESSION|RANGE;
DERAGEX: EXPRESSION END|RANGE END;
EXPRESSION: STR |  LIST | CALLSITO; 

LISTCALL: VAR '[' CALLSITO ']';
CALLSITO:NUMBEROP|LISTCALL|FUNCTION;

LIST:'['DERANGE LI']';
LI: ',' DERANGE LI|;

NUMBEROP: NUMBEROP OPERATION NUMBEROP | 'NOT' NUMBEROP | NEWNUMBER | VAR | 'TRUE' | 'FALSE';
OPERATION: OPAL|OPESTA|MULT|COMP|OPBOL;
OPBOL: 'IS'| 'AND' | 'OR';

FUNCTION:VAR'('DERANGE FU')';
FU: ',' DERANGE FU|;

IMPORT: 'import' VAR END;

RANGE: 'range''('RANG')';
RANG:EXPRESSION | EXPRESSION',' EXPRESSION;

IF:'IF'  DERANGE  ':' PLUSTART ELIF ELSE ;
ELIF:'ELIF' DERANGE  ':' PLUSTART ELIF | ; 
ELSE:'ELSE'':' PLUSTART |;

FOR:'FOR' VAR 'IN' FORIMP ':' PLUSTART ;
FORIMP:VAR|RANGE|STR|LIST|LISTCALL;

WHILE:'WHILE' DERANGE ':' PLUSTART;

PLUSTART: PLUSTART|MULTISTART | 'BREAK' | 'CONTINUE';     

PRINT: 'PRINT' '('DERANGE CICLIKRANGE')' END;
CICLIKRANGE: ','DERANGE CICLIKRANGE|;

DEF:'DEF' FUNCTION ':' MULTISTART RETU;
RETU:'RETURN' DERANGE END|;

END: ';'| ;

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