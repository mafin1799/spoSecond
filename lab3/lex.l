%{
#include "yacc.tab.h"
%}

%%

[ \t]; 
"-"?([0-9]+(\.[0-9]*)?|\.[0-9]+) { yylval.num = atof(yytext); return NUMBER; }

[-+=*/\n] { return *yytext; }
"(" { return '('; }
")" { return ')'; }
"{" { return '{'; }
"}" { return '}'; }

. { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}