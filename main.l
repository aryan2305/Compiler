%{
    #include<bits/stdc++.h>
    #include "ast.h"
    #include "main.tab.h"
    

    using namespace std;
    extern bool lexical_analysis;
%}

%option yylineno
%option noyywrap

NUM_INT 		([-]*[0-9]+)
NUM_FP			([-]*[0-9]+\.[0-9]+)
ID		        ([A-Za-z_]([A-Za-z0-9_])*)
ID_NOT_MAIN     (^[main])
nl 			    [\n]
sp              [ \n\t]*

INT             "int"
FLOAT           "float"
VOID            "void"
LT              "<"
GT              ">"
LTEQ            "<="
GTEQ            ">="
EQ              "=="
NEQ             ("!="|"<>")
AND             "&&"
OR              "||"
NOT             "!"
ASSIGN          "="
PLUS            "+"
MINUS           "-"
DIVIDE          "/"
MULT            "*"
MOD             "%"
SEMI            ";"
COLON           ":"
COMMA           ","
LB              "("
RB              ")"
LCB             "{"
RCB             "}"

HEADER          (\#include[ \n\t]*\<.+\>)|((\#include[ \t\n]*\".+\"))
MAIN            "main"

FOR             "for"
WHILE           "while"
IF              "if"
ELSE            "else"
SWITCH          "switch"
CASE            "case"
RETURN          "return"
GET             "get"
PUT             "put"
BREAK           "break"
CONTINUE        "continue"
DEFAULT         "default"

%%

{sp}{INT}{sp}				        {(yylval.node) = new AstNode("INT", yytext,_astnode);(yylval.node)->setDataType(_integer);return INT;}
{sp}{FLOAT}{sp}				        {(yylval.node) = new AstNode("FLOAT", yytext,_astnode);(yylval.node)->setDataType(_float);return FLOAT;}		 	
{sp}{VOID}{sp}		                {(yylval.node) = new AstNode("VOID", yytext,_astnode);(yylval.node)->setDataType(_void);return VOID;}
{sp}{LT}{sp}			            {(yylval.node) = new AstNode("LT", yytext,_astnode);return LT;}
{sp}{GT}{sp}			            {(yylval.node) = new AstNode("GT", yytext,_astnode);return GT;}
{sp}{LTEQ}{sp}			            {(yylval.node) = new AstNode("LTEQ", yytext,_astnode);return LTEQ;}
{sp}{GTEQ}{sp}			            {(yylval.node) = new AstNode("GTEQ", yytext,_astnode);return GTEQ;}
{sp}{EQ}{sp}			            {(yylval.node) = new AstNode("EQ", yytext,_astnode);return EQ;}
{sp}{NEQ}{sp}			            {(yylval.node) = new AstNode("NEQ", yytext,_astnode);return NEQ;}
{sp}{LB}{sp}				        {(yylval.node) = new AstNode("LB", yytext,_astnode);return LB;}
{sp}{RB}{sp}				        {(yylval.node) = new AstNode("RB", yytext,_astnode);return RB;}
{sp}{LCB}{sp}				        {(yylval.node) = new AstNode("LCB", yytext,_astnode);return LCB;}
{sp}{RCB}{sp}				        {(yylval.node) = new AstNode("RCB", yytext,_astnode);return RCB;}
{sp}{AND}{sp}				        {(yylval.node) = new AstNode("AND", yytext,_astnode);return AND;}
{sp}{OR}{sp}				        {(yylval.node) = new AstNode("OR", yytext,_astnode);return OR;}
{sp}{NOT}{sp}				        {(yylval.node) = new AstNode("NOT", yytext,_astnode);return NOT;}
{sp}{ASSIGN}{sp}				    {(yylval.node) = new AstNode("ASSIGN", yytext,_astnode);return ASSIGN;}
{sp}{PLUS}{sp}				        {(yylval.node) = new AstNode("PLUS", yytext,_astnode);return PLUS;}
{sp}{MINUS}{sp}				        {(yylval.node) = new AstNode("MINUS", yytext,_astnode);return MINUS;}
{sp}{DIVIDE}{sp}				    {(yylval.node) = new AstNode("DIVIDE", yytext,_astnode);return DIVIDE;}
{sp}{MULT}{sp}				        {(yylval.node) = new AstNode("MULT", yytext,_astnode);return MULT;}
{sp}{MOD}{sp}				        {(yylval.node) = new AstNode("MOD", yytext,_astnode);return MOD;}
{sp}{SEMI}{sp}				        {(yylval.node) = new AstNode("SEMI", yytext,_astnode);return SEMI;}
{sp}{COLON}{sp}				        {(yylval.node) = new AstNode("COLON", yytext,_astnode);return COLON;}
{sp}{COMMA}{sp}				        {(yylval.node) = new AstNode("COMMA", yytext,_astnode);return COMMA;}

{sp}{HEADER}{sp}				    {return HEADER;}
{sp}{MAIN}{sp}				        {(yylval.node) = new AstNode("MAIN", yytext,_astnode);return MAIN;}
{sp}{FOR}{sp}				        {(yylval.node) = new AstNode("FOR", yytext,_astnode);return FOR;}
{sp}{WHILE}{sp}				        {(yylval.node) = new AstNode("WHILE", yytext,_astnode);return WHILE;}
{sp}{IF}{sp}				        {(yylval.node) = new AstNode("IF", yytext,_astnode);return IF;}
{sp}{ELSE}{sp}				        {(yylval.node) = new AstNode("ELSE", yytext,_astnode);return ELSE;}
{sp}{SWITCH}{sp}				    {(yylval.node) = new AstNode("SWITCH", yytext,_astnode);return SWITCH;}
{sp}{CASE}{sp}				        {(yylval.node) = new AstNode("CASE", yytext,_astnode);return CASE;}
{sp}{DEFAULT}{sp}                   {(yylval.node) = new AstNode("DEFAULT", yytext,_astnode);return DEFAULT;}
{sp}{RETURN}{sp}				    {(yylval.node) = new AstNode("RETURN", yytext,_astnode);return RETURN;}
{sp}{GET}{sp}				        {(yylval.node) = new AstNode("GET", yytext,_astnode);return GET;}
{sp}{PUT}{sp}				        {(yylval.node) = new AstNode("PUT", yytext,_astnode);return PUT;}
{sp}{BREAK}{sp}				        {(yylval.node) = new AstNode("BREAK", yytext,_astnode);return BREAK;}
{sp}{CONTINUE}{sp}				    {(yylval.node) = new AstNode("CONTINUE", yytext,_astnode);return CONTINUE;}
{sp}{NUM_INT}{sp}				    {(yylval.node) = new AstNode("NUM_INT", yytext,_astnode);return NUM_INT;}
{sp}{NUM_FP}{sp}				    {(yylval.node) = new AstNode("NUM_FP", yytext,_astnode);return NUM_FP;}
{sp}{ID}{sp}				        {(yylval.node) = new AstNode("ID", yytext,_astnode);return ID;}
{sp}{ID_NOT_MAIN}{sp}               {(yylval.node) = new AstNode("ID_NOT_MAIN", yytext,_astnode);return ID_NOT_MAIN;}
{nl}				                {yylineno++;}
.				                    {lexical_analysis = false; cerr<<"Lexical Error: Token unrecognised at Line No. "<<yylineno<<" "<<yytext<<endl;}

%%