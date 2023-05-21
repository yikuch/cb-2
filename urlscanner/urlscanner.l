%option yylineno

%{

//definitions
#include <stdio.h>
#include <stdlib.h>
#include "urlscanner.h"
#include <string.h>

    
%}


%x URL PRE_LINKTEXT LINKTEXT


%%
<<EOF>> {
    return -1; 
}
<INITIAL>{<a.*?href=\" BEGIN(URL);
    [.\n] 
    }
<URL>[^\"]* {
    //printf("Assigne yylval in URL yylval= ");printf(yytext);printf("ENDE ASSIGN");
    yylval = yytext;
                BEGIN(PRE_LINKTEXT); 
              
               return TOKEN_URL;
            }
<PRE_LINKTEXT>[^>]*> { 
   BEGIN(LINKTEXT);
}
<LINKTEXT>[^<]*<\/a { 
    char* matched_str = yytext;  
                int length = strlen(matched_str);
                yylval = malloc(length);  // Allocate memory for yylval.str //remove last char from matched string e.g. "
                strncpy(yylval, matched_str, length - 3); // Copy string without the last 3 characters (</a)
                yylval[length - 3] = '\0'; // Null-terminate the copied string; 
        //printf("Assigne yylval in LINKTEXT yylval= ");printf(yytext);printf("ENDE ASSIGN");

                     BEGIN(INITIAL);
                  return TOKEN_TEXT;
                
            }

. 


%%




int yywrap() {
    return -1;
}


