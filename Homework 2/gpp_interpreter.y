%{
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	void yyerror (char *array);
	int yylex(void);
	void printResult(int num);
	void print_list();
	void add_to_list(int num);
	void if_condition(int value);
	void if_condition2(int value,int array1[],int array2[]);
	void for_loop(int initial,int final);
%}

%union{
	int num;
	char *string;
}

%token KW_AND KW_OR KW_NOT KW_EQUAL KW_LESS KW_NIL KW_LIST KW_APPEND KW_CONCAT KW_SET KW_DEFFUN KW_FOR KW_IF KW_EXIT KW_LOAD KW_DISP KW_TRUE KW_FALSE
%token OP_PLUS OP_MINUS OP_DIV OP_MULT OP_OP OP_CP OP_DBLMULT OP_OC OP_CC OP_COMMA COMMENT 
%type<num> EXPB
%type<num> EXPI
%type<num> BinaryValue
%token <symbol> IDENTIFIER
%token <num> VALUE

%%
START :| INPUT START
	
;

INPUT : EXPI
	| EXPB {printResult($1); }
	| EXPLISTI {printf("Syntax OK.\n");print_list(); }

;
EXPB : OP_OP KW_AND EXPB EXPB OP_CP { $$ = $3 && $4;}
	| OP_OP KW_OR EXPB EXPB OP_CP { $$ = $3 || $4;}
	| OP_OP KW_NOT EXPB OP_CP { $$ = !$3;}
	| OP_OP KW_LESS EXPB EXPB OP_CP { $$ = $3 < $4;}
	| OP_OP KW_EQUAL EXPB EXPB OP_CP { $$ = $3 == $4;}
	| OP_OP KW_EQUAL EXPI EXPI OP_CP { $$ = $3 == $4;}
	| EXPI // I^ve try to get rid of the shift reduce conflict but i couldn't find a proper solution to solve it.
	| BinaryValue {$$ = $1;}
;

EXPI : OP_OP OP_PLUS EXPI EXPI OP_CP { $$ = $3 + $4; printResult($$);}
	| OP_OP OP_MINUS EXPI EXPI OP_CP { $$ = $3 - $4; printResult($$);}
	| OP_OP OP_DIV EXPI EXPI OP_CP { $$ = $3 / $4; if($4 == 0) {printf("Zero Division Error!");} else  printResult($$);}
    | OP_OP OP_MULT EXPI EXPI OP_CP { $$ = $3 * $4; printResult($$);}
	| OP_OP OP_DBLMULT EXPI EXPI OP_CP { $$ = $3 * $4;printResult($$);}
	| OP_OP KW_IF EXPB EXPLISTI EXPLISTI OP_CP {printf("Syntax OK.\n");}
	| OP_OP KW_IF EXPB EXPLISTI OP_CP {if_condition($3);print_list();}
	| OP_OP KW_FOR OP_OP IDENTIFIER EXPI EXPI OP_CP EXPLISTI OP_CP {for_loop($5,$6);}
	| OP_OP KW_DEFFUN IDENTIFIER EXPI OP_CP{printf("Syntax OK.\n");}
	| OP_OP KW_SET IDENTIFIER EXPI OP_CP {printf("Syntax OK.\n");}
	| OP_OP IDENTIFIER EXPLISTI OP_CP {printf("Syntax OK.\n");}
	| IDENTIFIER
	| VALUE
;

EXPLISTI : OP_OP KW_LIST  VALUES  OP_CP 
	| OP_OP KW_CONCAT EXPLISTI EXPLISTI OP_CP 
	| OP_OP KW_APPEND EXPI EXPLISTI OP_CP {add_to_list($3);}
	| LISTVALUE 
;

LISTVALUE : OP_OC  OP_OP VALUES OP_CP
	| OP_OC OP_OP OP_CP
	| KW_NIL
;
BinaryValue: KW_TRUE {$$ = 1;}
	| KW_FALSE {$$ = 0;}
;
VALUES : VALUES VALUE {add_to_list($2);}
    | VALUE {add_to_list($1);}
;

%%

int array[1000];
int counter = 0;

void printResult(int value){
	printf("Syntax OK.\n");
	printf("Result: %d\n",value);
}
void yyerror (char *array) {
	printf("SYNTAX_ERROR Expression not recognized\n");
} 
void add_to_list(int num){
	array[counter] = num;
	counter++;
}
void if_condition(int value){
	if(value){
		print_list();
	}
}

void if_condition2(int value,int array1[],int array2[]){
	printf("valueee");
	if(value){
		printf("Result: (");
		for(int i=0;i<counter;i++){
			printf("%d ",array1[i]);
		}
		printf(")\n");
	}
	else
		printf("Result: (");
		for(int i=0;i<counter;i++){
			printf("%d ",array2[i]);
		}
		printf(")\n");
}
void for_loop(int initial, int final){
	for(int i= initial; i<final;i++)
		print_list();
}
void print_list(){
	if(counter != 0){
		printf("Result: (");
		for(int i=0;i<counter;i++){
			printf("%d ",array[i]);
		}
		printf(")\n");
		counter = 0;
	}

}
int main(){
	return yyparse();
}