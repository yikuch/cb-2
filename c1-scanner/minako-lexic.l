%option yylineno

%{

//definitions
#include <stdio.h>
#include <stdlib.h>
#include "minako.h"


    
%}

DIGIT	[0-9]
INTEGER	{DIGIT}+
FLOAT	{INTEGER}"."{INTEGER}|"."{INTEGER}
LETTER	[a-zA-Z]
BOOL "true"|"false"
STRING "\""[^\n\"]*"\""
ID ({LETTER})+({DIGIT}|{LETTER})*
WORD {LETTER}+
CONST_FLOAT {FLOAT}([eE]([-+])?{INTEGER})?|{INTEGER}([eE]([-+])?{INTEGER})

%%
"/*"([^*]|(\*+[^*/]))*\*+\/ {}
"//".* {}
"&&"   {printf("Line:   %d	Token: 257 \n",yylineno);}
"||" {printf("Line:   %d	Token: 258 \n",yylineno);}              
"==" {printf("Line:   %d	Token: 259 \n",yylineno);}             
"!=" {printf("Line:   %d	Token: 260 \n",yylineno);}
"<=" {printf("Line:   %d	Token: 261 \n",yylineno);}
">=" {printf("Line:   %d	Token: 262 \n",yylineno);}
"<" {printf("Line:   %d	Token: 263 \n",yylineno);}            
">" {printf("Line:   %d	Token: 264 \n",yylineno);}
"bool" {printf("Line:   %d	Token: 265 \n",yylineno);}
"do" {printf("Line:   %d	Token: 266 \n",yylineno);}           
"else" {printf("Line:   %d	Token: 267 \n",yylineno);}         
"float" {printf("Line:   %d	Token: 268 \n",yylineno);}
"for" {printf("Line:   %d	Token: 269 \n",yylineno);}          
"if" {printf("Line:   %d	Token: 270 \n",yylineno);}           
"int" {printf("Line:   %d	Token: 271 \n",yylineno);}
"printf" {printf("Line:   %d	Token: 272 \n",yylineno);}
"return" {printf("Line:   %d	Token: 273 \n",yylineno);}
"void" {printf("Line:   %d	Token: 274 \n",yylineno);} 
"while" {printf("Line:   %d	Token: 275 \n",yylineno);}
"(" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
")" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"*" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"/" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"+" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"-" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"{" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"}" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
";" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"," {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}
"=" {printf("Line:   %d	TOKEN: '%s' \n",yylineno,yytext);}


{DIGIT}+ {printf("Line:   %d	INT: %s \n",yylineno,yytext);}
{FLOAT}([eE]([-+])?{INTEGER})?|{INTEGER}([eE]([-+])?{INTEGER}) {printf("Line:   %d	FLOAT: %s \n",yylineno,yytext);}
"true"|"false" {printf("Line:   %d	BOOL: %s \n",yylineno,yytext);}
"\""[^\n\"]*"\"" {printf("Line:   %d	STRING: %s \n",yylineno,yytext);}
({LETTER})+({DIGIT}|{LETTER})* {printf("Line:   %d	ID: %s \n",yylineno,yytext);}

\n {}
" "* {}
\t {}
. {fprintf(stderr, "Fehler: Line %d nicht erlaubtes Zeichen: %s in c1.\n",yylineno,yytext);exit(-1);}


%%
yywrap() {}
int main(int argc,char** argv)
{
  //printf("%d",argc);
  //printf("%s",argv[2]);
  if (argc != 2) {
        yyin = stdin;
    } else {
        yyin = fopen(argv[1], "r");
        if (yyin == 0) {
            fprintf(
                    stderr,
                    "Fehler: Konnte Datei %s nicht zum lesen oeffnen.\n",
                    argv[1]
            );
            exit(-1);
        }
    }
  yylex();
  return 0;
    
    

}