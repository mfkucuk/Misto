%union {
    float real;
    int   integer;
    char  str[50];
}

%token <real> FLOAT
%token <integer> INT
%token <str> STRING


%token TIMER_FUNC LOGICAL_AND LOGICAL_OR COMMA COLUMN ASSIGNMENT ADD_OP SUB_OP EXP_OP MOD_OP MULT_OP DIV_OP LESS_THAN LESS_OR_EQ GREATER_THAN GREATER_OR_EQ EQUAL LP RP LEFT_BRACES RIGHT_BRACES IF ELSE WHILE FOR CONNECT SEND RECEIVE SENSOR_CALL SWITCH ON OFF VOID_FUNC_CALL RETURN_FUNC_CALL RETURN_TYPE RETURN IF_END TEMPERATURE_VAL HUMIDITY_VAL PRESSURE_VAL QUALITY_VAL LIGHT_VAL SOUNDLEVEL_VAL IDENT COMMENT

%%

program: statements 
statements: statement | statement statements 
statement: ADD_OP

%%

#include "lex.yy.c"
void yyerror(char *s) { printf("%s", s); }
int main() {
   return yyparse();
}
