/* A Bison parser, made by GNU Bison 3.4.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_MAIN_TAB_H_INCLUDED
# define YY_YY_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    LT = 258,
    GT = 259,
    LTEQ = 260,
    GTEQ = 261,
    EQ = 262,
    NEQ = 263,
    AND = 264,
    OR = 265,
    NOT = 266,
    ASSIGN = 267,
    PLUS = 268,
    MINUS = 269,
    DIVIDE = 270,
    MULT = 271,
    MOD = 272,
    SEMI = 273,
    COLON = 274,
    COMMA = 275,
    LB = 276,
    RB = 277,
    LCB = 278,
    RCB = 279,
    INT = 280,
    FLOAT = 281,
    VOID = 282,
    HEADER = 283,
    NUM_INT = 284,
    NUM_FP = 285,
    ID = 286,
    MAIN = 287,
    FOR = 288,
    WHILE = 289,
    IF = 290,
    ELSE = 291,
    SWITCH = 292,
    CASE = 293,
    RETURN = 294,
    GET = 295,
    PUT = 296,
    BREAK = 297,
    CONTINUE = 298,
    DEFAULT = 299,
    ID_NOT_MAIN = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 17 "main.y"

	AstNode *node;
    Variable *varnode;
    Function* funcnode;
    Arglist* arglist;
    Type tp;

#line 111 "main.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MAIN_TAB_H_INCLUDED  */
