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
Aux1 "["|"("|"{"
Aux2 "]"|")"|"}"
clss .*|\n

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "y.tab.h"
int MAXSIZE = 50;       
int stack[50];     
int top = -1;            

int isempty() {

   if(top == -1)
      return 1;
   else
      return 0;
}
   
int isfull() {

   if(top == MAXSIZE)
      return 1;
   else
      return 0;
}

int peek() {
   return stack[top];
}

int pop() {
   int data;
	
   if(!isempty()) {
      data = stack[top];
      top = top - 1;   
      return data;
   } else {
      printf("Could not retrieve data, Stack is empty.\n");
   }
}

int push(int data) {

   if(!isfull()) {
      top = top + 1;   
      stack[top] = data;
   } else {
      printf("Could not insert data, Stack is full.\n");
   }
}
int column = 1;
int parens = 0;
static int indent_depth(const char *data){
    int i,j=0;
      for(i=0;i<strlen(data);i++){
			if(data[i]==' '){
        j++;
       }
     }    
    return j/2;
};

void count(void);
FILE* fp;
%}

 /* This is a sub-parser (state) for indentation-sensitive scoping */
%x indent
%x normal

 /* %option 8bit reentrant bison-bridge */

%option warn
%option nodefault
%option yylineno
%option noyywrap

%%
 int lineno = 0;
<initial>{clss}          { yyless(0); BEGIN(indent); push(0); }
<indent>[ \t]*           { int depth = indent_depth(yytext);
                          if (depth < peek()) {
                              pop();
                              yyless(0);
                              return(UNINDENT);}
                          BEGIN(normal);
                          if (depth > peek()) {
                              push(depth);
                              return INDENT; }}
<indent>.            { yyless(0);
                          if (peek() > 0) {
                              pop();
                              return(UNINDENT);}
                          BEGIN(normal); }
<indent><<EOF>>      { if (peek() > 0) {
                              pop();
                              return(UNINDENT);}
                          BEGIN(normal); }
<indent>[ \t]*\n     { lineno++; return(SALTO);}
<indent>[ \t]*#.*\n  { lineno++; return(SALTO);}
<normal>{Aux1}                 { parens++; return(*yytext); }
<normal>{Aux2}                   { if (--parens < 0){parens = 0;} 
                          return(*yytext); }
<normal>"*" {return(MULT);}
<normal>"+" {return(MAS);}
<normal>"-" {return(MENOS);}
<normal>{OperaAlg} {return(OPAL);}
<normal>{Operaassing} {return(OPASS);}
<normal>{Comparator} {return(COMP);}
<normal>{Simbolos} {return(*yytext);}
<normal>{Clave} {
    int i=0;
      while(yytext[i]) {
			yytext[i]=toupper(yytext[i]);
            i++;
      }
   return(*yytext);
}
<normal>{String} {return(STR);}
<normal>{Integer} {return(INT);}
<normal>{Decimal} {return(DEC);}
<normal>{Long} {return(LONG);}  
<normal>{Imaginario} {return(IMG);}
<normal>{Variable} {return(VAR);}
<normal>{Coment} {}
<normal>\n                      { lineno++;
                          if (parens == 0){BEGIN(indent);} return(SALTO); }
<normal>[ ] {}
<normal>[^ ] {return(*yytext);}

%%
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

