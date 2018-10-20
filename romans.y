%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void yyerror(const char *);

/* Flex implements these. */
extern int yylex();
extern FILE *yyin;
%}

%%

input
    : %empty
    | input line
    ;

line
    : '\n'
    | number '\n'
    ;

number
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    | c_rule
    | cd_rule
    | d_rule
    | cm_rule
    | m_rule
    ;

m_rule
    : 'M'
    | 'M' m_rule
    | 'M' post_m
    ;

post_m
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    | c_rule
    | cd_rule
    | d_rule
    | cm_rule
    ;

cm_rule
    : 'C' 'M'
    | 'C' 'M' post_cm
    ;

post_cm
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    ;

d_rule
    : 'D'
    | 'D' post_d
    ;

post_d
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    | c_rule
    ;

cd_rule
    : 'C' 'D'
    | 'C' 'D' post_cd
    ;

post_cd
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    ;

c_rule
    : 'C'
    | 'C' post_c
    | 'C' 'C'
    | 'C' 'C' post_c
    | 'C' 'C' 'C'
    | 'C' 'C' 'C' post_c
    ;

post_c
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    | xl_rule
    | l_rule
    | xc_rule
    ;

xc_rule
    : 'X' 'C'
    | 'X' 'C' post_xc
    ;

post_xc
    : i_rule
    | v_rule
    | ix_rule
    ;

l_rule
    : 'L'
    | 'L' post_l
    ;

post_l
    : i_rule
    | v_rule
    | ix_rule
    | x_rule
    ;

xl_rule
    : 'X' 'L'
    | 'X' 'L' post_xl
    ;

post_xl
    : i_rule
    | v_rule
    | ix_rule
    ;

x_rule
    : 'X'
    | 'X' post_x
    | 'X' 'X'
    | 'X' 'X' post_x
    | 'X' 'X' 'X'
    | 'X' 'X' 'X' post_x
    ;

post_x
    : i_rule
    | v_rule
    | ix_rule
    ;

ix_rule
    : 'I' 'X'
    ;

v_rule
    : 'I' 'V'
    | 'V'
    | 'V' i_rule
    ;

i_rule
    : 'I'
    | 'I' 'I'
    | 'I' 'I' 'I'
    ;

%%

int main(int argc, char *argv[]) {
    FILE *file;
    char *line;
    size_t line_size;

    if (argc != 2) {
        exit(-1);
    }

    file = fopen(argv[1], "r");

    line = NULL;
    line_size = 0;
    while (getline(&line, &line_size, file) != -1) {
        yyin = fmemopen(line, strlen(line), "r");
        yyparse();

        free(line);
        line = NULL;
        line_size = 0;
    }

    return 0;
}

void yyerror(const char *s) {
    printf("Reeeee!\n");
    exit(-1);
}
