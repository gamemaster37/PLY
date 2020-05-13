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
static std::stack<int> indent;
static int indent_depth(const char *);
void count(void);
FILE* fp;
%}

 /* This is a sub-parser (state) for indentation-sensitive scoping */
%x initial
%x indent
%s normal

 /* %option 8bit reentrant bison-bridge */
%option warn
%option nodefault
%option yylineno
%option noyywrap
%%
 int lineno = 0;
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
<INITIAL>.*|\n          { yyless(0); BEGIN(LINESTART); indent.push(0); }
<LINESTART>[ \t]*       { int depth = indent_depth(yytext);
                          if (depth < indent.top()) {
                              indent.pop();
                              yyless(0);
                              return UNINDENT; }
                          BEGIN(NORMAL);
                          if (depth > indent.top()) {
                              indent.push(depth);
                              return INDENT; } }
<LINESTART>.            { yyless(0);
                          if (indent.top() > 0) {
                              indent.pop();
                              return UNINDENT; }
                          BEGIN(NORMAL); }
<LINESTART><<EOF>>      { if (indent.top() > 0) {
                              indent.pop();
                              return UNINDENT; }
                          BEGIN(NORMAL); }
<LINESTART>[ \t]*\n     { lineno++; }
<LINESTART>[ \t]*#.*\n  { lineno++; }
[[({]                   { parens++; return *yytext; }
[])}]                   { if (--parens < 0) parens = 0;
                          return *yytext; }
\n                      { lineno++;
                          if (parens == 0) BEGIN(LINESTART); }

(.|\n)  { std::cerr << g_current_filename << ":" << yylineno << ":" << yycolumn << ": Unexpected character: " << yytext << std::endl; exit(1); }
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

