# Файлы
YACC_FILE = yacc.y
LEX_FILE = lex.l
YACC_OUT = yacc.tab.c yacc.tab.h
LEX_OUT = lex.yy.c
EXE = calc

# Компилятор и инструменты
CC = gcc
YACC = bison
LEX = flex

# Флаги
YFLAGS = -d

# Цель по умолчанию
all: $(EXE)

$(EXE): $(YACC_OUT) $(LEX_OUT)
	$(CC) $(YACC_OUT) $(LEX_OUT) -o $(EXE)

$(YACC_OUT): $(YACC_FILE)
	$(YACC) $(YFLAGS) $(YACC_FILE)

$(LEX_OUT): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

.PHONY: clean
clean:
	rm -f $(LEX_OUT) $(YACC_OUT)