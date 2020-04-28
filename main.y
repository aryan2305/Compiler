%{
    #include<bits/stdc++.h>

    extern int yyparse();
    extern int yylex();
    void yyerror(char* s);
    extern int yylineno;
%}

%token INT FLOAT VOID LT GT LTEQ GTEQ EQ NEQ AND OR NOT ASSIGN PLUS MINUS DIVIDE MULT MOD SEMI COLON COMMA LB RB LCB RCB
%token NUM_INT NUM_FP ID HEADER MAIN FOR WHILE IF ELSE SWITCH CASE RETURN GET PUT BREAK CONTINUE 

%%

program : header_files global_declaration main_function
        | header_files main_function
        ;

header_files : HEADER header_files
             | 
             ;

global_declaration : variable_declaration global_declaration
                   | func_declaration global_declaration
                   | 
                   ;

variable_declaration : data_type_var variable SEMI
                     ;

variable : name
         | name COMMA variable
         | name ASSIGN value
         | name ASSIGN value COMMA variable
         ;

func_declaration : data_type_func name LB arguments_list RB LCB statements RCB

arguments_list : argument
               | argument COMMA arguments_list
               ;

argument : data_type_var name ;

data_type_var : INT | FLOAT ;

data_type_func : INT | FLOAT | VOID ;

name : ID;

value : NUM_FP | NUM_INT ; 

main_function : data_type_func MAIN LB RB LCB statements RCB

statements : expression statements
            | 
            ;

expression : variable_declaration
           | read_input
           | print_output
           | conditional_expr
           | looping_expr
           | return_expr
           | arithmetic_expr
           ;

read_input : GET LB name RB SEMI ;

print_output : PUT LB name RB SEMI ; 

conditional_expr : if_expr
                 | switch_expr
                 ;

if_expr : 
        ;

switch_expr :
            ;

looping_expr : for_expr
             | while_expr
             ;

for_expr :
         ;

while_expr :
           ;

arithmetic_expr:
               ;


return_expr : RETURN SEMI
            | RETURN value SEMI
            ;


%%

int main(int argc, char **argv)
{
  yyparse();
}

void yyerror(char *s)
{      


}