%option noyywrap
%{
	#include "gpp_interpreter.tab.h"
	int count =0;
%}

%%
;;.* {return COMMENT;}
or {return KW_OR;}
and {return KW_AND;}
not {return KW_NOT;}
equal {return KW_EQUAL;}
less {return KW_LESS;}
nil {return KW_NIL;}
list {return KW_LIST;}
append {return KW_APPEND;}
concat {return KW_CONCAT;}
set {return KW_SET;}
deffun {return KW_DEFFUN;}
for {return KW_FOR;}
if {return KW_IF;}
exit {return KW_EXIT;}
load {return KW_LOAD;}
disp {return KW_DISP;}
true {yylval.num = 1;return KW_TRUE;}
false {yylval.num = 0;return KW_FALSE;}
[*][*] {return OP_DBLMULT;}
[+] {return OP_PLUS;}
[-] {return OP_MINUS;}
[/] {return OP_DIV;}
[*] {return OP_MULT;}
[(] {return OP_OP;}
[)] {return OP_CP;}
["] {
		if(count%2== 0)
			return OP_OC; 
		else
			return OP_OC;
			count++;
	}
[,] {return OP_COMMA;}
[0-9]+ {yylval.num = atoi(yytext); return VALUE;}
[a-zA-Z][a-zA-Z0-9]* {yylval.string = (char *) malloc(strlen(yytext)*sizeof(char)); return IDENTIFIER;}
[ ] {}
[0-9][0-9a-zA-Z]+ {printf("SYNTAX ERROR");}
[\n][\n] {return 0;}
. {printf("Unrecognized character"); }


%%
