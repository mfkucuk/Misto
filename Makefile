misto: y.tab.c lex.yy.c
	gcc -o misto y.tab.c
y.tab.c: misto.y lex.yy.c
	yacc misto.y
lex.yy.c: misto.l
	lex misto.l
clean:
	rm -f lex.yy.c y.tab.c misto