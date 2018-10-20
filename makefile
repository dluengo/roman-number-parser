all:
	bison -d romans.y
	flex romans.l
	gcc -ggdb romans.tab.c lex.yy.c -o romans

clean:
	rm -f romans.tab.c romans.tab.h lex.yy.c romans
