%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%x HEX OCT BIN

%%
0[xX][0-9A-Fa-f]+ {
    int decimal = (int)strtol(yytext, NULL, 16);
    printf("%d", decimal);
}

0[0-7]+ {
    int decimal = (int)strtol(yytext, NULL, 8);
    printf("%d", decimal);
}

0b[01]+ {
    int decimal = 0;
    for (int i = 2; yytext[i] != '\0'; i++) {
        decimal = decimal * 2 + (yytext[i] - '0');
    }
    printf("%d", decimal);
}

[1-9][0-9]* {
    int decimal = atoi(yytext);
    printf("%d", decimal);
}

.|\n {
    printf("%s", yytext);
}

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* input = fopen(argv[1], "r");
    if (input == NULL) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input;

    yylex();

    fclose(input);

    return 0;
}
