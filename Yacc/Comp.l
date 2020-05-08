  
Variable ([_]|[a-z])([_]|[a-z0-9])*
varint 146513541
OperaAlg   "+"|"-"|"*"|"**"|"/"|"//"|"%"|"<<"|">>"|" & "|"|"|"^"|"~"    
Operaassing ">>="|"<<="|"+="|"-="|"*="|"/="|"//="|"&="|"|="|"^="|"**="|"%="|"="
Comparator   "<"|">"|"<="|">="|"=="|"!="|"<>"  
Clave   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|False|range
Simbolos   "("|")"|","|";"|"["|"]"|":"|"."

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
FILE* fp; 
int count=0;
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
[\n] {fprintf(yyout,"\n");}
%%
  
int yywrap(){} 

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