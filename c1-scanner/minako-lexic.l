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
<<EOF>> {
  
    return -1; // Signalisiert das Ende der Eingabe
}

[ \t]* {}   /* Ignore whitespace */
\n {}


"/*"([^*]|(\*+[^*/]))*\*+\/ {} //kommentare
"//".* {} //einzeilige Kommentare
"&&"   {return AND;}
"||" {return OR;}              
"==" {return EQ;}             
"!=" {return NEQ;}
"<=" {return LEQ;}
">=" {return GEQ;}
"<" {return LSS;}            
">" {return GRT;}
"bool" {return KW_BOOLEAN;}
"do" {return KW_DO;}           
"else" {return KW_ELSE;}         
"float" {return KW_FLOAT;}
"for" {return KW_FOR;}          
"if" {return KW_IF;}           
"int" {return KW_INT;}
"printf" {return KW_PRINTF;}
"return" {return KW_RETURN;}
"void" {return KW_VOID;} 
"while" {return KW_WHILE;}
"(" {return 40;}
")" {return 41;}
"*" {return 42;}
"/" {return 47;}
"+" {return 43;}
"-" {return 45;}
"{" {return 123;}
"}" {return 125;}
";" {return 59;}
"," {return 44;}
"=" {return 61;}


{DIGIT}+ {return CONST_INT;}
{FLOAT}([eE]([-+])?{INTEGER})?|{INTEGER}([eE]([-+])?{INTEGER}) {return CONST_FLOAT;}
"true"|"false" {return CONST_BOOLEAN ;}
"\""[^\n\"]*"\"" {return CONST_STRING;}
({LETTER})+({DIGIT}|{LETTER})* {return  ID;}


. {fprintf(stderr, "Fehler: Line %d nicht erlaubtes Zeichen: %s in c1.\n",yylineno,yytext);exit(-1);} //default fuer alle anderen Zeichen

%%
int yywrap() {
    /* Aktionen für das Ende der Datei */
    return -1;  // Signalisiert das Ende der Analyse
}


