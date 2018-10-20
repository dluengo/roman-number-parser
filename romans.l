%{
#include <stdio.h>

#include "romans.tab.h"
%}

%option noyywrap

%%

[ \t]   ;
"I" return 'I';
"V" return 'V';
"X" return 'X';
"L" return 'L';
"C" return 'C';
"D" return 'D';
"M" return 'M';
\n  return '\n';

%%
