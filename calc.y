%{
#define	YYSTYPE	double

double getFractionalPart(double num) {
    double integralPart;
    modf(num, &integralPart);
    return num - integralPart;
}
%}

%token DATA
%left '+' '-'
%left '*' '/'
%%



spisok :	/* ¯ãáâ® */
  | spisok '\n'
  | spisok wyrag '\n' {printf("\t%g\n",$2);}
  ;
wyrag : DATA 		{ $$=$1; }
  | wyrag '+' wyrag	{ $$=$1+$3; }
  | wyrag '-' wyrag	{ $$=$1-$3; }
  | wyrag '*' wyrag	{ $$=$1*$3; }
  | wyrag '/' wyrag	{ $$=$1/$3; }
  | '{' wyrag '}'   { $$ = getFractionalPart($2); }
  | '(' wyrag ')'	{ $$ = $2; }
  ;
%%

#include <stdio.h>
#include <ctype.h>
#include <math.h>

main()
{
	yyparse();
}

yyerror(s)
char *s;
{
	fprintf(stderr,"%s\n",s);
}

yylex()
{
	int c;
	
	do{
		c=getchar();
	}while(c==' ' || c=='\t');
	
	if(c==EOF)
		return 0;
	if(c=='.' || isdigit(c)){
		ungetc(c,stdin);
		scanf("%lf",&yylval);
		return DATA;
	}
	
	return c;
}

