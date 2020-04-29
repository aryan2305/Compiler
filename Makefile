all : main

main : lex.yy.c main.tab.c main.tab.h
	g++ -g -std=c++11 lex.yy.c main.tab.c -o main

lex.yy.c : main.l main.tab.h 
	flex main.l

main.tab.c main.tab.h :	main.y 
	bison -d -v main.y

clean:
	rm lex.yy.c main.tab.c main.tab.h main.output main 
