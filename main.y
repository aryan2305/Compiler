%{
    #include<bits/stdc++.h>
    #include "ast.h"

    using namespace std;

    extern int yyparse();
    extern int yylex();
    void yyerror(char* s);
    extern int yylineno;

    AstNode* AstRoot;
    
%}

%union
{
	AstNode *node;
    Variable *varnode;
    Function* funcnode;
    Arglist* arglist;
    Type tp;
}

%token<node> LT GT LTEQ GTEQ EQ NEQ AND OR NOT ASSIGN PLUS MINUS DIVIDE MULT MOD SEMI COLON COMMA LB RB LCB RCB

%type<node> variable name 

%type<node> func_declaration main_function function_calls

%type<node> arguments_list fc_argument_list argument

%type<node> data_type_var data_type_func

%token<node> INT FLOAT VOID 

%token<node> HEADER NUM_INT NUM_FP ID MAIN FOR WHILE IF ELSE SWITCH CASE RETURN GET PUT BREAK CONTINUE DEFAULT ID_NOT_MAIN

%type<node> program header_files global_declaration_list global_declaration variable_declaration variable_list  value statements  
%type<node> expression read_input print_output conditional_expr if_expr switch_expr looping_expr for_expr while_expr conditions logical_expr return_expr switch_cases
%type<node> and_expr relation_expr arithmetic_expr div_mul_expr unary_expr term op1 op2 op3

%start program

%%



program : header_files global_declaration_list main_function
          {$$ = new AstNode("program", "");$$->addChild($2); $$->addChild($3); AstRoot = $$;}
        ;


header_files : HEADER header_files
               {$$ =  new AstNode("header_files", "");$$->addChild($2);}
             | 
               {$$ = new AstNode("header_files", "");}

             ;

global_declaration_list : global_declaration_list global_declaration   
                          {$$ = new AstNode("global_declaration_list", ""); $$->addChild($1);$$->addChild($2);}
                        |
                          {$$ = new AstNode("global_declaration",  "");}
                        ;

global_declaration : variable_declaration       
                     {$$ = new AstNode("global_declaration", ""); $$->addChild($1);}
                   | func_declaration           
                     {$$ = new AstNode("global_declaration", ""); $$->addChild($1);}
                   ;

variable_declaration : data_type_var variable_list SEMI
                       {$$ = new AstNode("variable_declaration", ""); $$->addChild($1); $$->addChild($2); $$->setType($1->getType());}
                     ;
variable_list : variable_list COMMA variable 
                {$$ = new AstNode("variable_list", ""); $$->addChild($1); $$->addChild($3);}
              | variable
                {$$ = new AstNode("variable_list", ""); $$->addChild($1);}
              ;

variable : name
           {$$ = new AstNode("variable", ""); $$->addChild($1);}
         | name ASSIGN arithmetic_expr
           {$$ = new AstNode("variable", ""); $$->addChild($1); $$->addChild($3);}
         ;

func_declaration : data_type_func ID_NOT_MAIN LB arguments_list RB LCB statements RCB  
                   {$$ = new AstNode("func_declaration", $2->getValue()); $$->addChild($1); $$->addChild($4); $$->addChild($7); $$->setType($1->getType());}

arguments_list : argument
                 {$$ = new AstNode("arguments_list", ""); $$->addChild($1);}
               | argument COMMA arguments_list
                 {$$ = new AstNode("arguments_list", ""); $$->addChild($1); $$->addChild($3);}
               ;

argument : data_type_var name
           {$$ = new AstNode("argument", ""); $$->addChild($1); $$->addChild($2); $$->setType($1->getType());}
         |
           {$$ = new AstNode("argument", "");}
         ;

data_type_var : INT
                {$$ = new AstNode("data_type_var", $1->getValue()); $$->addChild($1);}
              | FLOAT 
                {$$ = new AstNode("data_type_var", $1->getValue()); $$->addChild($1);}
              ;

data_type_func : INT
                 {$$ = new AstNode("data_type_func", $1->getValue()); $$->addChild($1);}
               | FLOAT
                 {$$ = new AstNode("data_type_func", $1->getValue()); $$->addChild($1);}
               | VOID 
                 {$$ = new AstNode("data_type_func", $1->getValue()); $$->addChild($1);}
               ;

name : ID {$$ = new AstNode("name", $1->getValue()); $$->addChild($1);}
     ;

value : NUM_FP 
        {$$ = new AstNode("value", $1->getValue()); $$->addChild($1);}
      | NUM_INT 
        {$$ = new AstNode("value", $1->getValue()); $$->addChild($1);}
      ; 

main_function : data_type_func MAIN LB RB LCB statements RCB
                {$$ = new AstNode("main_function", ""); $$->addChild($1); $$->addChild($6); $$->setType($1->getType());}

statements : expression statements      
             {$$ = new AstNode("statements", ""); $$->addChild($1); $$->addChild($2);}
            | 
              {$$ = new AstNode("statements", "");}
            ;

expression : variable_declaration
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | read_input
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | print_output
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | conditional_expr   
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
        //    | assignment_expr SEMI       
           | looping_expr
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | return_expr
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | conditions SEMI
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | BREAK SEMI
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | CONTINUE SEMI
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           | LCB expression RCB
             {$$ = new AstNode("expression", ""); $$->addChild($1);}
           ;

read_input : GET LB name RB SEMI 
             {$$ = new AstNode("read_input", $1->getValue()); $$->addChild($3);} 
           ;

print_output : PUT LB name RB SEMI 
               {$$ = new AstNode("print_output", $1->getValue()); $$->addChild($3);}
             | PUT LB value RB SEMI
               {$$ = new AstNode("print_output", $1->getValue()); $$->addChild($3);}
             ;    

conditional_expr : if_expr     
                   {$$ = new AstNode("conditional_expr", ""); $$->addChild($1);}
                 | switch_expr
                   {$$ = new AstNode("conditional_expr", ""); $$->addChild($1);}
                 ;

if_expr : IF LB conditions RB LCB statements RCB                        
          {$$ = new AstNode("if_expr", $1->getValue()); $$->addChild($3);$$->addChild($6);}
        | IF LB conditions RB LCB statements RCB ELSE LCB statements RCB
          {$$ = new AstNode("if_expr", "IF-ELSE"); $$->addChild($3);$$->addChild($6);$$->addChild($10);}
        ;

switch_expr : SWITCH LB name RB LCB switch_cases RCB   
              {$$ = new AstNode("switch_expr", $1->getValue());$$->addChild($3); $$->addChild($6);}
            ;

switch_cases : CASE value COLON statements switch_cases
               {$$ = new AstNode("switch_cases", $1->getValue()); $$->addChild($2); $$->addChild($4); $$->addChild($5);}
             | CASE value COLON statements
               {$$ = new AstNode("switch_cases", $1->getValue()); $$->addChild($2); $$->addChild($4);}
             | DEFAULT COLON statements 
               {$$ = new AstNode("switch_cases", $1->getValue()); $$->addChild($3);}
             ;



looping_expr : for_expr
               {$$ = new AstNode("looping_expr", ""); $$->addChild($1);}
             | while_expr
               {$$ = new AstNode("looping_expr", ""); $$->addChild($1);}
             ;

for_expr : FOR LB variable_list SEMI conditions SEMI variable_list RB LCB statements RCB   
           {$$ = new AstNode("for_expr", $1->getValue()); $$->addChild($3); $$->addChild($5); $$->addChild($7); $$->addChild($10); }
         ;

while_expr : WHILE LB conditions RB LCB statements RCB 
             {$$ = new AstNode("while_expr", $1->getValue()); $$->addChild($3); $$->addChild($6);}
           ;

// assignment_expr : name ASSIGN arithmetic_expr
//                 | data_type_var name ASSIGN arithmetic_expr
//                 |
//                 ;

conditions : variable EQ conditions
             {$$ = new AstNode("conditions",  $2->getValue()); $$->addChild($1); $$->addChild($3);}
           | logical_expr
             {$$ = new AstNode("conditions", ""); $$->addChild($1);}
           ;

logical_expr : logical_expr OR and_expr
               {$$ = new AstNode("logical_expr", $2->getValue()); $$->addChild($1); $$->addChild($3);}
             | and_expr
               {$$ - new AstNode("logical_expr", ""); $$->addChild($1);}
             ;

and_expr : relation_expr AND and_expr
           {$$ = new AstNode("and_expr", $2->getValue()); $$->addChild($1); $$->addChild($3);}
         | relation_expr
           {$$ = new AstNode("and_expr", ""); $$->addChild($1);}
         ;

relation_expr : arithmetic_expr op1 relation_expr // >, <, .......
                {$$ = new AstNode("relation_expr", $2->getValue()); $$->addChild($1); $$->addChild($2); $$->addChild($3);}
              | arithmetic_expr
                {$$ = new AstNode("relation_expr", ""); $$->addChild($1);}
              ;
           
arithmetic_expr: div_mul_expr op2 arithmetic_expr // +,-
                 {$$ = new AstNode("arithmetic_expr", $2->getValue()); $$->addChild($1); $$->addChild($2); $$->addChild($3);}
               | div_mul_expr
                 {$$ = new AstNode("arithmetic_expr", ""); $$->addChild($1);}
               ;

div_mul_expr : div_mul_expr op3 unary_expr //*,/,%
               {$$ = new AstNode("div_mul_expr", $2->getValue()); $$->addChild($1); $$->addChild($2); $$->addChild($3);}
             | unary_expr
               {$$ = new AstNode("div_mul_expr", ""); $$->addChild($1);}
             ;

unary_expr : op2 term
             {$$ = new AstNode("unary_expr", $1->getValue()); $$->addChild($1); $$->addChild($2);}
           | term
             {$$ = new AstNode("unary_expr", ""); $$->addChild($1);}
           ;

term : LB conditions RB
       {$$ = new AstNode("term", "{c}"); $$->addChild($2);}
     | NOT term
       {$$ = new AstNode("term", $1->getValue()); $$->addChild($1); $$->addChild($2);}
     | variable
       {$$ = new AstNode("term", "variable"); $$->addChild($1);}
     | value
       {$$ = new AstNode("term", "value"); $$->addChild($1);}
     | function_calls
       {$$ = new AstNode("term", "function_calls"); $$->addChild($1);}
     ;

function_calls : name LB fc_argument_list RB
                 {$$ = new AstNode("function_calls", ""); $$->addChild($1); $$->addChild($3);}
               ;

fc_argument_list : arithmetic_expr COMMA fc_argument_list
                   {$$ = new AstNode("fc_argument_list", $2->getValue()); $$->addChild($1);$$->addChild($3);}
                 | arithmetic_expr
                   {$$ = new AstNode("fc_argument_list", ""); $$->addChild($1);}
                 | 
                   {$$ = new AstNode("fc_argument_list", "");}
                 ;


op1 : LT
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    | GT
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    | LTEQ
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    | GTEQ
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    | EQ
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    | NEQ
      {$$ = new AstNode("op1", $1->getValue()); $$->addChild($1);}
    ;

op2 : PLUS
      {$$ = new AstNode("op2", $1->getValue()); $$->addChild($1);}
    | MINUS
      {$$ = new AstNode("op2", $1->getValue()); $$->addChild($1);}
    ;

op3 : MULT
      {$$ = new AstNode("op3", $1->getValue()); $$->addChild($1);}
    | DIVIDE
      {$$ = new AstNode("op3", $1->getValue()); $$->addChild($1);}
    | MOD
      {$$ = new AstNode("op3", $1->getValue()); $$->addChild($1);}
    ;


return_expr : RETURN SEMI
              {$$ = new AstNode("return_expr", "Return value");}
            | RETURN value SEMI
              {$$ = new AstNode("return_expr", ""); $$->addChild($2);}
            ;


%%

bool syntax_analysis = true;
bool semantic_analysis = true;
bool lexical_analysis = true;

void yyerror(char *s)
{      

    cerr<<"Syntax Error at Line Number " << yylineno <<" : "<<s<<endl;
	syntax_analysis = false;
    
}

int main(int argc, char **argv)
{
    cout<<"---------------- FIRST PASS -------------------"<<endl<<endl;
    cout<<"Step 1: Lexical Analysis and Syntax Analysis"<<endl<<endl;
    
    yyparse();
    
    if(lexical_analysis)
    {
        cout<<"Lexical Analysis Successful!!"<<endl<<endl;
    }
    else
    {
        cout<<"Lexical Analysis Failed.Remove unrecognised tokens."<<endl;
        exit(1);
    }

    if(syntax_analysis)
    {
        cout<<"Syntax Analysis Successful!!"<<endl<<endl;
    }
    else
    {
        cout<<"Syntax Analysis Failed. Remove the syntax error."<<endl;
        exit(1);
    }
    
}

