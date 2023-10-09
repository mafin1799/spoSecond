%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
0[xX][0-9A-Fa-f]+ {
    printf("%d", (int)strtol(yytext, NULL, 16));
}

0[0-7]+ {
    printf("%d", (int)strtol(yytext, NULL, 8));
}

"0b"[01]+ {
    char* binaryValue = yytext + 2;  // Пропускаем "0b" или "0B"
    int decimal = 0;
    int base = 1;
    for (int i = strlen(binaryValue) - 1; i >= 0; i--) {
        if (binaryValue[i] == '1') {
            decimal += base;
        }
        base *= 2;
    }
    printf("%d", decimal);
}

[1-9][0-9]* {
    printf("%d", atoi(yytext));
}

.|\n {
    printf("%s", yytext);
}
%%

int yywrap() {
    return 1;  // Возвращаем 1, чтобы сообщить, что анализ завершен
}

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
