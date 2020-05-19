%token OPAL OPASS COMP STR INT DEC LONG IMG VAR SALTO MULT MENOS MAS INDENT UNINDENT
%start START

%{
extern int column;
%}

%%
START: MULTISTART | START  MULTISTART | START error|;

MULTISTART:'PASS'| DECLARACION | IMPORT | DEFF | PRINT | WHILEE | FO | DERAGEX | IFF |SALTOTE| MULTISTART MULTISTART|'RETURN' EXPRESSION END ;

NEWNUMBER:OPESTA NUMBER | NUMBER;
OPESTA: MAS|MENOS;
NUMBER:INT|LONG|IMG|DEC;

DECLARACION: VAR DECLA DERANGE END;
DECLA:  ',' VAR  DECLA DERANGE ',' | OPASS ;

DERANGE: EXPRESSION|RANGE;
DERAGEX: EXPRESSION END|RANGE END;
EXPRESSION: STR | LIST | CALLSITO|MATRIX|MATRIXCALL|LONG; 

LISTCALL: VAR '[' CALLSITO ']';
CALLSITO:NUMBEROP|LISTCALL|FUNCTION;

MATRIXCALL: VAR '[' CALLSITO ']''[' CALLSITO ']';

LIST:'['DERANGE LI']';
LI: ',' DERANGE LI|;

MATRIX:LIST LIST;

NUMBEROP: NUMBEROP OPERATION NUMBEROP | 'NOT' NUMBEROP | NEWNUMBER | VAR | 'TRUE' | 'FALSE'|'('NUMBEROP')';
OPERATION: OPAL|OPESTA|MULT|COMP|OPBOL;
OPBOL: 'IS'| 'AND' | 'OR';

FUNCTION:VAR'('FIXDECLA')';
FU: ',' DERANGE FU|;
FIXDECLA:DERANGE FU|;

IMPORT: 'IMPORT' VAR END;

RANGE: 'RANGE''('RANG')';
RANG:EXPRESSION | EXPRESSION',' EXPRESSION;

IFF:'IF'  DERANGE  ':'SALTOTE INDENT MULTISTART UNINDENT ELIFF ELSEE  ;
ELIFF:'ELIF' DERANGE  ':'SALTOTE INDENT MULTISTART UNINDENT ELIFF | ; 
ELSEE:'ELSE'':'SALTOTE INDENT MULTISTART UNINDENT |;

FO: 'FOR' VAR 'IN' FORIMP ':'SALTOTE INDENT MULTISTART UNINDENT ;
FORIMP:VAR|RANGE|STR|LIST|LISTCALL;
SALTOTE:SALTO {column++;} SALTOTE|;

WHILEE:'WHILE' DERANGE ':'SALTOTE INDENT MULTISTART UNINDENT;
  

PRINT: 'PRINT' '('DERANGE CICLIKRANGE')' END;
CICLIKRANGE: ','DERANGE CICLIKRANGE|;

DEFF: 'DEF' FUNCTION ':' SALTOTE INDENT MULTISTART UNINDENT ;


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
   int yydebug = 5;
	yyparse(); 
    
    printf("Success \n");
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
    printf(" line %d: %s\n", column, s);
}