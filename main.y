%{
    #include<bits/stdc++.h>

    extern int yyparse();
    extern int yylex();
    void yyerror(char* s);
    extern int yylineno;
%}

%token INT FLOAT VOID LT GT LTEQ GTEQ EQ NEQ AND OR NOT ASSIGN PLUS MINUS DIVIDE MULT MOD SEMI COLON COMMA LB RB LCB RCB
%token NUM_INT NUM_FP ID HEADER MAIN FOR WHILE IF ELSE SWITCH CASE RETURN SCAN PRINT BREAK CONTINUE DEFAULT

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
         | name ASSIGN conditions
         | name ASSIGN conditions COMMA variable
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
           | conditions SEMI
           | BREAK SEMI
           | CONTINUE SEMI
           | LCB expression RCB
           ;

read_input : SCAN LB name RB SEMI ;

print_output : PRINT LB name RB SEMI ; 

conditional_expr : if_expr
                 | switch_expr
                 ;

if_expr : IF LB conditions RB LCB statements RCB
        | IF LB conditions RB LCB statements RCB ELSE LCB statements RCB
        ;

switch_expr : SWITCH LB name RB LCB switch_cases RCB
            ;

switch_cases : CASE value COLON statements switch_cases
             | CASE value COLON statements
             | DEFAULT COLON statements 
             ;



looping_expr : for_expr
             | while_expr
             ;

for_expr : FOR LB conditions SEMI conditions SEMI conditions RB LCB statements RCB
         ;

while_expr : WHILE LB conditions RB LCB statements RCB
           ;

conditions : variable EQ conditions
           | logical_expr
           ;

logical_expr : logical_expr OR and_expr
             | and_expr
             ;

and_expr : relation_expr AND and_expr
         | relation_expr
         ;

relation_expr : arithmetic_expr op1 relation_expr // >, <, .......
              | arithmetic_expr
              ;
           
arithmetic_expr: div_mul_expr op2 arithmetic_expr // +,-
               | div_mul_expr
               ;

div_mul_expr : div_mul_expr op3 unary_expr //*,/,%
             | unary_expr
             ;

unary_expr : op2 term
           | term
           ;

term : LB conditions RB
     | NOT term
     | variable
     | value
     | function_calls
     ;

function_calls : name LB fc_argument_list RB
               ;

fc_argument_list : logical_expr COMMA list
     | logical_expr
     | 
     ;


op1 : LT
    | GT
    | LTEQ
    | GTEQ
    | EQ
    | NEQ
    ;

op2 : PLUS
    | MINUS
    ;

op3 : MULT
    | DIVIDE
    | MOD
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