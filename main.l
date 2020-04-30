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

{sp}{INT}{sp}				        {return INT;}
{sp}{FLOAT}{sp}				        {return FLOAT;}		 	
{sp}{VOID}{sp}		                {return VOID;}
{sp}{LT}{sp}			            {(yylval.node) = new AstNode("LT", yytext);return LT;}
{sp}{GT}{sp}			            {(yylval.node) = new AstNode("GT", yytext);return GT;}
{sp}{LTEQ}{sp}			            {(yylval.node) = new AstNode("LTEQ", yytext);return LTEQ;}
{sp}{GTEQ}{sp}			            {(yylval.node) = new AstNode("GTEQ", yytext);return GTEQ;}
{sp}{EQ}{sp}			            {(yylval.node) = new AstNode("EQ", yytext);return EQ;}
{sp}{NEQ}{sp}			            {(yylval.node) = new AstNode("NEQ", yytext);return NEQ;}
{sp}{LB}{sp}				        {(yylval.node) = new AstNode("LB", yytext);return LB;}
{sp}{RB}{sp}				        {(yylval.node) = new AstNode("RB", yytext);return RB;}
{sp}{LCB}{sp}				        {(yylval.node) = new AstNode("LCB", yytext);return LCB;}
{sp}{RCB}{sp}				        {(yylval.node) = new AstNode("RCB", yytext);return RCB;}
{sp}{AND}{sp}				        {(yylval.node) = new AstNode("AND", yytext);return AND;}
{sp}{OR}{sp}				        {(yylval.node) = new AstNode("OR", yytext);return OR;}
{sp}{NOT}{sp}				        {(yylval.node) = new AstNode("NOT", yytext);return NOT;}
{sp}{ASSIGN}{sp}				    {(yylval.node) = new AstNode("ASSIGN", yytext);return ASSIGN;}
{sp}{PLUS}{sp}				        {(yylval.node) = new AstNode("PLUS", yytext);return PLUS;}
{sp}{MINUS}{sp}				        {(yylval.node) = new AstNode("MINUS", yytext);return MINUS;}
{sp}{DIVIDE}{sp}				    {(yylval.node) = new AstNode("DIVIDE", yytext);return DIVIDE;}
{sp}{MULT}{sp}				        {(yylval.node) = new AstNode("MULT", yytext);return MULT;}
{sp}{MOD}{sp}				        {(yylval.node) = new AstNode("MOD", yytext);return MOD;}
{sp}{SEMI}{sp}				        {(yylval.node) = new AstNode("SEMI", yytext);return SEMI;}
{sp}{COLON}{sp}				        {(yylval.node) = new AstNode("COLON", yytext);return COLON;}
{sp}{COMMA}{sp}				        {(yylval.node) = new AstNode("COMMA", yytext);return COMMA;}

{sp}{HEADER}{sp}				    {return HEADER;}
{sp}{MAIN}{sp}				        {(yylval.node) = new AstNode("MAIN", yytext);return MAIN;}
{sp}{FOR}{sp}				        {(yylval.node) = new AstNode("FOR", yytext);return FOR;}
{sp}{WHILE}{sp}				        {(yylval.node) = new AstNode("WHILE", yytext);return WHILE;}
{sp}{IF}{sp}				        {(yylval.node) = new AstNode("IF", yytext);return IF;}
{sp}{ELSE}{sp}				        {(yylval.node) = new AstNode("ELSE", yytext);return ELSE;}
{sp}{SWITCH}{sp}				    {(yylval.node) = new AstNode("SWITCH", yytext);return SWITCH;}
{sp}{CASE}{sp}				        {(yylval.node) = new AstNode("CASE", yytext);return CASE;}
{sp}{DEFAULT}{sp}                   {(yylval.node) = new AstNode("DEFAULT", yytext);return DEFAULT;}
{sp}{RETURN}{sp}				    {(yylval.node) = new AstNode("RETURN", yytext);return RETURN;}
{sp}{GET}{sp}				        {(yylval.node) = new AstNode("GET", yytext);return GET;}
{sp}{PUT}{sp}				        {(yylval.node) = new AstNode("PUT", yytext);return PUT;}
{sp}{BREAK}{sp}				        {(yylval.node) = new AstNode("BREAK", yytext);return BREAK;}
{sp}{CONTINUE}{sp}				    {(yylval.node) = new AstNode("CONTINUE", yytext);return CONTINUE;}
{sp}{NUM_INT}{sp}				    {(yylval.node) = new AstNode("NUM_INT", yytext);return NUM_INT;}
{sp}{NUM_FP}{sp}				    {(yylval.node) = new AstNode("NUM_FP", yytext);return NUM_FP;}
{sp}{ID}{sp}				        {(yylval.node) = new AstNode("ID", yytext);return ID;}
{sp}{ID_NOT_MAIN}{sp}               {(yylval.node) = new AstNode("ID_NOT_MAIN", yytext);return ID_NOT_MAIN;}
{nl}				                {yylineno++;}
.				                    {lexical_analysis = false; cerr<<"Lexical Error: Token unrecognised at Line No. "<<yylineno<<" "<<yytext<<endl;}

%%