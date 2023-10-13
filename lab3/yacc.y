%{
#include <stdio.h>
#include <ctype.h>
#include <math.h>

int yylex();

double getFractionalPart(double num) {
    double integralPart;
    modf(num, &integralPart);
    return num - integralPart;
}
%}



%union {
    double num;
}

%token <num> NUMBER
%left '+' '-'
%left '*' '/'
%type <num> expr

%%
res: expr '\n' { printf("\t %lf\n", $1); }
expr : NUMBER 		{ $$=$1; }
  | expr '+' expr	{ $$=$1+$3; }
  | expr '-' expr	{ $$=$1-$3; }
  | expr '*' expr	{ $$=$1*$3; }
  | expr '/' expr	{ $$=$1/$3; }
  | '{' expr '}'   { $$ = getFractionalPart($2); }
  | '(' expr ')'	{ $$ = $2; }
  ;
%%

int main(){
	yyparse();
    return 0;
}

int yyerror(const char* msg){
	fprintf(stderr,"%s\n",msg);
    return 0;
}

