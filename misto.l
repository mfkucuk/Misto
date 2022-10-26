digit [0-9]
sign [+-]
number {digit}+
int {sign}?{number}

%%
TIMER return TIMER_FUNC;

\&\& return LOGICAL_AND;

\|\| return LOGICAL_OR;

\, return COMMA;

: return COLUMN;

\= return ASSIGNMENT;

\+ return ADD_OP;

\- return SUB_OP;

\*\* return EXP_OP;

\% return MOD_OP;

\* return MULT_OP;

\/ return DIV_OP;

\< return LESS_THAN;

\<\= return LESS_OR_EQ;

\> return GREATER_THAN;

\>\= return GREATER_OR_EQ;

\=\= return EQUAL;

\( return LP;

\) return RP;

\{ return LEFT_BRACES;

\} return RIGHT_BRACES;

IF return IF;

ELSE return ELSE;

WHILE return WHILE;

FOR	return FOR;

CONNECT return CONNECT;

SEND return SEND;

RECEIVE return RECEIVE;

SENSOR return SENSOR_CALL;

SWITCH return SWITCH;

ON return ON;

OFF return OFF;

CALLV return VOID_FUNC_CALL;

CALLR return RETURN_FUNC_CALL;

VOID|INT|FLOAT|STRING return RETURN_TYPE;

RETURN return RETURN;

DONE return IF_END;

Temperature	return TEMPERATURE_VAL;  

Humidity return HUMIDITY_VAL; 

AirPressure return PRESSURE_VAL; 

AirQuality return QUALITY_VAL;		

Light return LIGHT_VAL;		

SoundLevel return SOUNDLEVEL_VAL;

[A-Za-z_][A-Za-z0-9_]* return IDENT;

{int} { sscanf(yytext, "%d", &yylval.integer); return INT; }

\".*\" {strcpy(yylval.str, yytext); return STRING;}

{int}F|{int}.[0-9]+F { sscanf(yytext, "%f", &yylval.real); return FLOAT;}

$.* return COMMENT;

.;

%%
int yywrap() { return 1; }
