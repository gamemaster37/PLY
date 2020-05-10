/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    OPESTA = 258,
    OPAL = 259,
    OPASS = 260,
    COMP = 261,
    STR = 262,
    INT = 263,
    DEC = 264,
    LONG = 265,
    IMG = 266,
    VAR = 267,
    SALTO = 268,
    AND = 269,
    ELSE = 270,
    IS = 271,
    RETURN = 272,
    BREAK = 273,
    FOR = 274,
    NOT = 275,
    WHILE = 276,
    CONTINUE = 277,
    IF = 278,
    OR = 279,
    DEF = 280,
    IMPORT = 281,
    PASS = 282,
    ELIF = 283,
    IN = 284,
    PRINT = 285,
    TRUE = 286,
    FALSE = 287,
    RANGE = 288
  };
#endif
/* Tokens.  */
#define OPESTA 258
#define OPAL 259
#define OPASS 260
#define COMP 261
#define STR 262
#define INT 263
#define DEC 264
#define LONG 265
#define IMG 266
#define VAR 267
#define SALTO 268
#define AND 269
#define ELSE 270
#define IS 271
#define RETURN 272
#define BREAK 273
#define FOR 274
#define NOT 275
#define WHILE 276
#define CONTINUE 277
#define IF 278
#define OR 279
#define DEF 280
#define IMPORT 281
#define PASS 282
#define ELIF 283
#define IN 284
#define PRINT 285
#define TRUE 286
#define FALSE 287
#define RANGE 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
