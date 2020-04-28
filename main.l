%{
    #include "main.tab.h"
%}

NUM_INT 		([-]*[0-9]+)
NUM_FP			([-]*[0-9]+\.[0-9]+)
ID		        ([A-Za-z_]([A-Za-z0-9_])*)
nl 			    [\n]
sp              [ \t]*

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

HEADER          (\#[ \t]*include[ \n\t]*\<.+\>)|((\#[ \t]*include[ \t\n]*\".+\"))
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

%%

{sp}INT{sp}				        {return INT;}
{sp}FLOAT{sp}				    {return FLOAT;}		 	
{sp}VOID{sp}		            {return VOID;}
{sp}LT{sp}			            {return LT;}
{sp}GT{sp}			            {return GT;}
{sp}LTEQ{sp}			        {return LTEQ;}
{sp}GTEQ{sp}			        {return GTEQ;}
{sp}EQ{sp}			            {return EQ;}
{sp}NEQ{sp}			            {return NEQ;}
{sp}LB{sp}				        {return LB;}
{sp}RB{sp}				        {return RB;}
{sp}LCB{sp}				        {return LCB;}
{sp}RCB{sp}				        {return RCB;}
{sp}AND{sp}				        {return AND;}
{sp}OR{sp}				        {return OR;}
{sp}NOT{sp}				        {return NOT;}
{sp}ASSIGN{sp}				    {return ASSIGN;}
{sp}PLUS{sp}				    {return PLUS;}
{sp}MINUS{sp}				    {return MINUS;}
{sp}DIVIDE{sp}				    {return DIVIDE;}
{sp}MULT{sp}				    {return MULT;}
{sp}MOD{sp}				        {return MOD;}
{sp}SEMI{sp}				    {return SEMI;}
{sp}COLON{sp}				    {return COLON;}
{sp}COMMA{sp}				    {return COMMA;}

{sp}HEADER{sp}				    {return HEADER;}
{sp}MAIN{sp}				    {return MAIN;}
{sp}FOR{sp}				        {return FOR;}
{sp}WHILE{sp}				    {return WHILE;}
{sp}IF{sp}				        {return IF;}
{sp}ELSE{sp}				    {return ELSE;}
{sp}SWITCH{sp}				    {return SWITCH;}
{sp}CASE{sp}				    {return CASE;}
{sp}RETURN{sp}				    {return RETURN;}
{sp}GET{sp}				        {return GET;}
{sp}PUT{sp}				        {return PUT;}
{sp}BREAK{sp}				    {return BREAK;}
{sp}CONTINUE{sp}				{return CONTINUE;}
{sp}NUM_INT{sp}				    {return NUM_INT;}
{sp}NUM_FP{sp}				    {return NUM_FP;}
{sp}ID{sp}				        {return ID;}
nl				                {yylineno++; return NEWLINE;}
.				                {return ER;}

%%