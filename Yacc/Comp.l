Variable ([a-zA-Z_])([0-9]|[a-zA-Z_])*
OperaAlg   "+"|"-"|"*"|"**"|"/"|"//"|"%"|"<<"|">>"|" & "|"|"|"^"|"~"    
Operaassing ">>="|"<<="|"+="|"-="|"*="|"/="|"//="|"&="|"|="|"^="|"**="|"%="|"="
Comparator   "<"|">"|"<="|">="|"=="|"!="|"<>"  
Clave   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|False|range
Simbolos   "("|")"|","|";"|"["|"]"|":"|"."
cc   "\""
String   {cc}(.*){cc}
Integer [-+]?[0-9]+([Ee][+-]?[0-9]+)?	
Decimal [-+]?[0-9]*"."[0-9]+([Ee][+-]?[0-9]+)?
Long {Integer}(l|L)  
Imaginario ({Integer}|{Decimal})(j|J) 

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
int column = 1;
void count(void);
FILE* fp;
%}

%%

{Operaassing} {fprintf(yyout,"Op-Assing");}
{Comparator} {fprintf(yyout,"Comparator");}
{OperaAlg} {fprintf(yyout,"Op-Algebra");}
{Clave} {
    int i=0;
      while(yytext[i]) {
			yytext[i]=toupper(yytext[i]);
            i++;
      }
   fprintf(yyout,"%s",yytext);
}
{Simbolos} {fprintf(yyout,"%s",yytext);}
{String} {fprintf(yyout,"String");}
{Integer} {fprintf(yyout,"Integer");}
{Decimal} {fprintf(yyout,"Decimal");}
{Long} {fprintf(yyout,"Long");}  
{Imaginario} {fprintf(yyout,"Imaginario");}
{Variable} {fprintf(yyout,"Identificador");}
[0-9](.*)(" ")? {fprintf(yyout,"Unknown Word= -->%s<--",yytext);}
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

   
int main(){ 
  
      extern FILE *yyin, *yyout;
      /*char filename[50]; 
      printf("Enter the filename: \n"); 
      scanf("%s",filename); 
      fp = fopen(filename,"r"); 
      yyin = fp;*/

      yyin = fopen("prueba", "r");
      yyout = fopen("output.txt", "w");

      yylex(); 
      printf("Acabo \n");
      return 0; 
} 

