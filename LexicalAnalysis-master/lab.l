%{ 
      #include <stdio.h>
      #include <string.h>
      #include <ctype.h>
      #include <stdlib.h>
      FILE* fp; 
      int count=0;
%} 
  
LETRA [a-zA-Z]
DIGITO [0-9]
VARIABLE {LETRA}({LETRA}|{DIGITO}|"-"|"_")*
FLOAT ("-")?({DIGITO}*\.{DIGITO}+)([eE][-+]?{DIGITO}+)?
INT ("-")?({DIGITO}+)([eE][-+]?{DIGITO}+)?
LONG {INT}(L|l)
IMAGINARY ({INT}|{FLOAT})(J|j)
KEYWORD   and|else|is|return|break|for|not|while|continue|if|or|def|import|pass|elif|in|print|True|False|range
OPERATOR "+"|"-"|"*"|"/"|"%"|"&"|"|"|"^"|"~"|"<"|">"
DELIMITADORESCHAR "("|")"|"["|"]"|"="|";"|","|":"|"."
CARACTER ([^\n\*]([.])*)
STRING (\"|\')({CARACTER}*)(\"|\')

COMENTARIO "#".*

ASIGNACION {VARIABLE} = .*

%%

"**" {fprintf(yyout,"Exponente=%s",yytext);}
"//" {fprintf(yyout,"Div_Piso=%s ",yytext);}
"<<" {fprintf(yyout,"Bitewise_ri=%s ",yytext);}
">>" {fprintf(yyout,"Bitewise_le=%s ",yytext);}
"<=" {fprintf(yyout,"Menor_igual=%s ",yytext);}
">=" {fprintf(yyout,"Mayor_igual=%s ",yytext);}
"==" {fprintf(yyout,"Igual=%s ",yytext);}
"!=" {fprintf(yyout,"Diferente=%s ",yytext);}
"<>" {fprintf(yyout,"Diferente=%s ",yytext);}

">>=" {fprintf(yyout,"mayor_ig=%s ",yytext);}
"<<=" {fprintf(yyout,"menor_ig=%s ",yytext);}
"+=" {fprintf(yyout,"suma_asig=%s ",yytext);}
"-=" {fprintf(yyout,"resta_asig=%s ",yytext);}
"*=" {fprintf(yyout,"mult_asig=%s ",yytext);}
"/=" {fprintf(yyout,"div_asig=%s ",yytext);}
"//=" {fprintf(yyout,"floordiv=%s ",yytext);}
"&=" {fprintf(yyout,"andigual=%s ",yytext);}
"|=" {fprintf(yyout,"origual=%s ",yytext);}
"^=" {fprintf(yyout,"expigual=%s ",yytext);}
"**=" {fprintf(yyout,"exponente=%s ",yytext);}
"%=" {fprintf(yyout,"modulo=%s ",yytext);}


{KEYWORD} {
      int i=0;
      while(yytext[i]) {
            fprintf(yyout,"%c",toupper(yytext[i]));
            i++;
      }
   
}

{OPERATOR} {
   switch ((char)*yytext)
   {
      case '+':
         fprintf(yyout,"Mas=%s ",yytext);
         break;
      case '-':
         fprintf(yyout,"Menos=%s ",yytext);
         break;
      case '*':
         fprintf(yyout,"Por=%s ",yytext);
         break;
      case '/':
         fprintf(yyout,"Div=%s ",yytext);
         break;
      case '%':
         fprintf(yyout,"Mod= %s ",yytext);
         break;
      case '&':
         fprintf(yyout,"And_b=%s ",yytext);
         break;
      case '|':
         fprintf(yyout,"Or=%s ",yytext);
         break;
      case '^':
         fprintf(yyout,"Xor=%s ",yytext);
         break;
      case '~':
         fprintf(yyout,"Not=%s ",yytext);
         break;
      case '<':
         fprintf(yyout,"Menorque=%s ",yytext);
         break;
      case '>':
         fprintf(yyout,"Mayorque=%s ",yytext);
         break;
   }
}

{COMENTARIO} {}

{IMAGINARY} {fprintf(yyout,"Imaginary=%s ",yytext);}
{INT} {fprintf(yyout,"Int=%s ",yytext);}
{FLOAT} {fprintf(yyout,"Float=%s ",yytext);}
{LONG} {fprintf(yyout,"Long=%s ",yytext);}

{VARIABLE} {
      int result = add_word(yytext,0);
      fprintf(yyout,"Id%d= %s ", result, yytext);
}

{STRING} {fprintf(yyout,"str=%s ",yytext);}
{DELIMITADORESCHAR} {
   switch ((char)*yytext)
   {
      case '(':
         fprintf(yyout,"Parabre=%s ",yytext);
         break;
      case ')':
         fprintf(yyout,"Parcierr=%s ",yytext);
         break;
      case '[':
         fprintf(yyout,"Corabre=%s ",yytext);
         break;
      case ']':
         fprintf(yyout,"Corcierr=%s ",yytext);
         break;
      case '=':
         fprintf(yyout,"Asiggn= %s ",yytext);
         break;
      case ';':
         fprintf(yyout,"Puntocoma=%s ",yytext);
         break;
      case ',':
         fprintf(yyout,"Coma=%s ",yytext);
         break;
      case ':':
         fprintf(yyout,"Dospunt=%s ",yytext);
         break;
   }
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

int lookup_word(char *word,int a){
   struct word *wp = word_list; 
   /* search down the list looking for the word */
   int t = 1;
   for(; wp; wp = wp->next) {
      int jj=0;
      if(a==1){
         int temp = count - t;
         fprintf(yyout,"Id%d= %s;\n",temp,wp->word_name);
         if(jj==5){
            fprintf(yyout,"\n");
            jj=0;
         }
         t++;
      }
      if(strcmp(wp->word_name, word) == 0) 
         return 1;
   }      
   return 0;      /* not found */
}

int return_position(char *word,int a){
   struct word *wp = word_list; 
   /* search down the list looking for the word */
   int cont=0;
   int posi=0;
   for(; wp; wp = wp->next) {
      if(strcmp(wp->word_name, word) == 0){
         posi= cont+1;
      }
      cont++;
   }      
   return cont-posi;      /* not found */
}

int add_word(char *word,int a)
{      
   struct word *wp;
   int position = return_position(word,a);  
   if(lookup_word(word,a) != 0) {
      return position;     
   }      
   /* word not there, allocate a new entry and link it on the list */      
   wp = (struct word *) malloc(sizeof(struct word)); 
   wp->next = word_list; 
   /* have to copy the word itself as well */
   wp->word_name = (char *) malloc(strlen(word)+1);
   strcpy(wp->word_name, word);
   word_list = wp;
   count++;
   return position;/* it worked */
}

   
int main(){ 
  
      extern FILE *yyin, *yyout;
      /*char filename[50]; 
      printf("Enter the filename: \n"); 
      scanf("%s",filename); 
      fp = fopen(filename,"r"); 
      yyin = fp;*/

      yyin = fopen("code.txt", "r");
      yyout = fopen("output.txt", "w");

      yylex(); 
      fprintf(yyout,"\nTabla de Identificadores \n");
      add_word("",1);
      printf("Acabo");
      return 0; 
} 