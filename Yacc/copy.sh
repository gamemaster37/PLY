#!/bin/bash
lex Comp.l
cc lex.yy.c -ll
./a.out