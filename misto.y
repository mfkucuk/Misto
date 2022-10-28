%union {
    float real;
    int   integer;
    char  str[50];
}

%token <real> FLOAT
%token <integer> INT
%token <str> STRING


%token TIMER_FUNC LOGICAL_AND LOGICAL_OR COMMA COLUMN ASSIGNMENT ADD_OP SUB_OP EXP_OP MOD_OP MULT_OP DIV_OP LESS_THAN LESS_OR_EQ GREATER_THAN GREATER_OR_EQ EQUAL LP RP LEFT_BRACES RIGHT_BRACES IF ELSE WHILE FOR CONNECT SEND RECEIVE SENSOR_CALL SWITCH ON OFF VOID_FUNC_CALL RETURN_FUNC_CALL RETURN_TYPE RETURN IF_END TEMPERATURE_VAL HUMIDITY_VAL PRESSURE_VAL QUALITY_VAL LIGHT_VAL SOUNDLEVEL_VAL IDENT COMMENT NEWLINE

%start program

%%

program: statements
statements: /* empty */
	  | statements NEWLINE
          | statements statement NEWLINE
          | error NEWLINE { printf(" in line %d!\n", lineno);
                            yyerrok; 
                          }
statement: assign | logic_expr | comment | for_stmt | connect | send_value | switches |

assign: IDENT ASSIGNMENT expr | IDENT ASSIGNMENT STRING
factor: LP expr RP | IDENT | INT | return_func_call | timer | receive_value | get_sensor | FLOAT | 
void_func_declr: RETURN_TYPE IDENT LP parameters RP LEFT_BRACES statements RIGHT_BRACES | RETURN_TYPE IDENT LP RP LEFT_BRACES statements RIGHT_BRACES
return_func_call: RETURN_TYPE IDENT LP parameters RP LEFT_BRACES statements RETURN expr RIGHT_BRACES | RETURN_TYPE IDENT LP RP LEFT_BRACES statements RETURN expr RIGHT_BRACES | RETURN_TYPE ident LP parameters RP LEFT_BRACES statements RETURN STRING RIGHT_BRACES | RETURN_TYPE ident LP RP LEFT_BRACES statements RETURN STRING RIGHT_BRACES
void_func_call: VOID_FUNC_CALL IDENT LP parameters RP | VOID_FUNC_CALL IDENT LP RP
return_func_call: RETURN_FUNC_CALL IDENT LP parameters RP | RETURN_FUNC_CALL IDENT LP RP
or_expr: and_expr | or_expr LOGICAL_OR and_expr
and_expr: logic_expr | and_expr LOGICAL_AND logic_expr
if_stmt: IF LP or_expr RP LEFT_BRACES statements RIGHT_BRACES IF_END | IF LP logic_expr RP LEFT_BRACES statements RIGHT_BRACES ELSE LEFT_BRACES statements RIGHT_BRACES
while_stmt: WHILE LP or_expr RP LEFT_BRACES statements RIGHT_BRACES
for_stmt: FOR LP assign COLUMN or_expr COLUMN assign RP LEFT_BRACES statements RIGHT_BRACES
term: factor | term MULT_OP factor | term DIV_OP factor
expr: term | expr ADD_OP term | expr SUB_OP term
logic_expr: expr EQUAL expr | expr GREATER_OR_EQ expr | expr GREATER_THAN expr | expr LESS_OR_EQ expr | expr LESS_THAN expr
get_sensor: SENSOR_CALL LP TEMPERATURE_VAL RP | SENSOR_CALL LP HUMIDITY_VAL RP | SENSOR_CALL LP PRESSURE_VAL RP | SENSOR_CALL LP QUALITY_VAL RP | SENSOR_CALL LP LIGHT_VAL RP | SENSOR_CALL LP SOUNDLEVEL_VAL COMMA expr RP
timer: TIMER_FUNC LP RP
switches: SWITCH expr ON | SWITCH expr OFF
connect: CONNECT STRING
send_value: SEND STRING expr
receive_value: RECEIVE LP STRING RP
parameters: expr | expr COMMA parameters
comment: COMMENT

%%

#include "lex.yy.c"
int lineno = 0;
void yyerror(char *s) { printf("%s", s); }
int main() {
   return yyparse();
}
