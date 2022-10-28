%union {
    float real;
    int   integer;
    char  str[50];
}

%token <real> FLOAT
%token <integer> INT
%token <str> STRING


%token TIMER_FUNC LOGICAL_AND LOGICAL_OR COMMA COLUMN ASSIGNMENT ADD_OP SUB_OP EXP_OP MOD_OP MULT_OP DIV_OP LESS_THAN LESS_OR_EQ GREATER_THAN GREATER_OR_EQ EQUAL LP RP LEFT_BRACES RIGHT_BRACES IF ELSE WHILE FOR CONNECT SEND RECEIVE SENSOR_CALL SWITCH ON OFF VOID_FUNC_CALL RETURN_FUNC_CALL RETURN_TYPE RETURN IF_END TEMPERATURE_VAL HUMIDITY_VAL PRESSURE_VAL QUALITY_VAL LIGHT_VAL SOUNDLEVEL_VAL IDENT COMMENT NEWLINE

%%

program: statements
statements: /* empty */
	  | statements NEWLINE
	  | statements statement NEWLINE
          | error NEWLINE { printf(" in line %d!\n", lineno);
                           yyerrok; 
                          }
statement: assign | logic_expr | expr
	 assign: IDENT ASSIGNMENT expr | IDENT ASSIGNMENT STRING
factor: LP expr RP | IDENT | INT
      term: factor | term MULT_OP factor | term DIV_OP factor
expr: term | expr ADD_OP term | expr SUB_OP term
    logic_expr: expr EQUAL expr | expr GREATER_OR_EQ expr | expr GREATER_THAN expr | expr LESS_OR_EQ expr | expr LESS_THAN expr

%%

#include "lex.yy.c"
int lineno = 0;
void yyerror(char *s) { printf("%s", s); }
int main() {
   return yyparse();
}
