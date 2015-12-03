grammar MiniJavasimple;

goal:	mainClass ( classDecl )* ;

mainClass:	'class' IDENTIFIER '{' 'public' 'static' 'void' 'main' '(' 'String' '[' ']' IDENTIFIER ')' '{' statement '}' '}' ;

classDecl:	'class' IDENTIFIER ( 'extends' IDENTIFIER )? '{' ( varDecl )* ( methodDecl )* '}' ;

varDecl:	type IDENTIFIER ';' ;

methodDecl:	'public' type IDENTIFIER '(' ( type IDENTIFIER ( ',' type IDENTIFIER )* )? ')' '{' ( varDecl )* ( statement )* 'return' expression ';' '}' ;

type:	'int' '[' ']'          # intArrType
		|	'boolean'          # boolType
		|	'int'              # intType
		|	IDENTIFIER         # objType
        ;

statement:	'{' ( statement )* '}'                                # scopedStat
		|	'if' '(' expression ')' statement 'else' statement    # ifStat
		|	'while' '(' expression ')' statement                  # whileStat
		|	'System.out.println' '(' expression ')' ';'           # printlnStat
		|	IDENTIFIER '=' expression ';'                         # assignStat
		|	IDENTIFIER '[' expression ']' '=' expression ';'      # arrAssignStat
		;

expression: expression '[' expression ']'                                           # arrAccessExpr
		| expression '.' 'length'                                                   # arrLengthExpr
		| expression '.' IDENTIFIER '(' ( expression ( ',' expression )* )? ')'     # methodCallExpr
        | '-' expression                                                            # negExpr
		| '!' expression                                                            # notExpr
		| 'new' 'int' '[' expression ']'                                            # newArrExpr
		| 'new' IDENTIFIER '(' ')'                                                  # newObjExpr
		| expression '+' expression                                                 # plusExpr
        | expression '-' expression                                                 # minusExpr
		| expression '*' expression                                                 # multExpr
		| expression '<' expression                                                 # lessThanExpr
        | expression '&&' expression                                                # andExpr
		| expression '?' expression ':' expression                                  # ternaryExpr
		| INT                                                                       # intLitExpr
		| 'true'                                                                    # trueLitExpr
		| 'false'                                                                   # falseLitExpr
		| 'this'                                                                    # thisExpr
		| IDENTIFIER                                                                # idExpr
		| '(' expression ')'                                                        # parenedExpr
		;

IDENTIFIER	: [a-zA-Z_][0-9a-zA-Z_]* ;
INT		: ('0' | [1-9][0-9]*) ;

WS
:  [ \t\r\n]+ -> skip
;

COMMENT
:   '/*' .*? '*/' -> skip
;

LINE_COMMENT
:   '//' ~[\r\n]* -> skip
;