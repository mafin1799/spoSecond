# Файлы и директории
YACC_FILE = yacc.y
LEX_FILE = lex.l
YACC_OUT = y.tab.c y.tab.h
LEX_OUT = lex.yy.c
EXE = calc

# Компилятор и инструменты
CC = gcc
YACC = bison
LEX = flex

# Компилятор и флаги
CFLAGS = -Wall -g
YFLAGS = -dy

# Цель по умолчанию
all: $(EXE)

$(EXE): $(YACC_OUT) $(LEX_OUT)
	$(CC) $(YACC_OUT) $(LEX_OUT) $(CFLAGS) -o $(EXE)

$(YACC_OUT): $(YACC_FILE)
	$(YACC) $(YFLAGS) $(YACC_FILE)

$(LEX_OUT): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

.PHONY: clean
clean:
	rm -f $(EXE) $(LEX_OUT) $(YACC_OUT)