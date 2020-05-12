Variable ([a-zA-Z_])([0-9]|[a-zA-Z_])*
OperaAlg   "**"|"/"|"//"|"%"|"<<"|">>"|"&"|"|"|"^"|"~"  
Operaassing ">>="|"<<="|"+="|"-="|"*="|"/="|"//="|"&="|"|="|"^="|"**="|"%="|"="
Comparator   "<"|">"|"<="|">="|"=="|"!="|"<>"  
Clave   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|False|range
Simbolos   "("|")"|","|";"|"["|"]"|":"|"."
cc   "\""
vv   "\'"
String   ({cc}([^\"])*{cc}|{vv}([^\'])*{vv})
Integer [0-9]+([Ee][+-]?[0-9]+)?	
Decimal [0-9]*"."[0-9]+([Ee][+-]?[0-9]+)?
Long {Integer}(l|L)  
Imaginario ({Integer}|{Decimal})(j|J) 
Coment "#".*

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "y.tab.h"
int column = 1;
void count(void);
FILE* fp;
%}

%%
"*" {return(MULT);}
"+" {return(MAS);}
"-" {return(MENOS);}
{OperaAlg} {return(OPAL);}
{Operaassing} {return(OPASS);}
{Comparator} {return(COMP);}
{Simbolos} {return(*yytext);}
{Clave} {
    int i=0;
      while(yytext[i]) {
			yytext[i]=toupper(yytext[i]);
            i++;
      }
   return(*yytext);
}
{String} {return(STR);}
{Integer} {return(INT);}
{Decimal} {return(DEC);}
{Long} {return(LONG);}  
{Imaginario} {return(IMG);}
{Variable} {return(VAR);}
{Coment} {}
[\n] {return(SALTO);}
[^ ] {return(*yytext);}
%%

int yywrap(){} 
void count(void)
{
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column++;

	ECHO;
}

/* define a linked list of words and types */
struct word {
      char *word_name;
      struct word *next;
};
struct word *word_list; /* first element in word list */
extern void *malloc() ;

