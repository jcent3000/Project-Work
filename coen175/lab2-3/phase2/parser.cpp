/*
 * File:	parser.cpp
 *
 * Description:	This file is just a placeholder for the real parser.  It is
 *		here just so that the main function is separate from the
 *		lexer and can be built upon in a separate file.
 */

# include <iostream>
# include "lexer.h"
# include "tokens.h"

using namespace std;

static int lookahead, nexttoken;
static string lexbuf, nextbuf;

void match(int t);
void printOper(int op);
void print(string output);
void primaryExpr();
void postFixExpr();
void prefixExpr();
void multiplicativeExpr();
void additiveExpr();
void relationalExpr();
void equalityExpr();
void logicalAndExpr();
void Expr();
void argumentList();
int peek();
void error(int t);
void argument();
void argumentList();

void primaryExpr() {
	if (lookahead == '(') {
		match('(');
		Expr();
		match(')');
	} else if (lookahead == ID) {
		match(ID);

		if (lookahead == '(') {
			match('(');
			if (lookahead == ')') { 
				match(')');
			} else {
				argumentList();
				match(')');
			}
		}
	} else {
		match(NUM);
	}
	return;
}

void postFixExpr() {
	primaryExpr();

	while (lookahead == '[') {
		match('[');
		Expr();
		match(']');
		cout << "index" << endl;
	}
}

void specifier() {
	if (lookahead == LONG || lookahead == INT) {
		int op = lookahead;
		match(lookahead);
		printOper(op);
	}
	return;
}

void pointer() {
	while (lookahead == '*') {
		match('*');
	}
}

void prefixExpr() {
	int op = lookahead;

	if (lookahead == '&' || lookahead == '*' || lookahead == '!' || lookahead == '-') {
		match(lookahead);
		prefixExpr();

		// Report Op
		if (op == '-') cout << "neg" << endl;
		else if (lookahead == '*') cout << "deref" << endl;
		else printOper(op);


	} else if (lookahead == '(') {
		int j = peek();
		if (j == INT || j == LONG) {
			match('(');
			specifier();
			pointer();
			match(')');
			prefixExpr();

			// Report Op
			cout << "cast" << endl;
		} else {
			postFixExpr();
		}
	} else if (lookahead == SIZEOF){
		match(SIZEOF);
		int i = peek();
		if (lookahead == '(' && (i == INT || i == LONG) ) {
			match('(');
			specifier();
			pointer();
			match(')');
		} else {
			prefixExpr();
		}

		// Report Op
		printOper(SIZEOF);

	} else {
		postFixExpr();
	}
}

void multiplicativeExpr() {
	prefixExpr();

	while (lookahead == '*' || lookahead == '/' || lookahead == '%') {
		int op = lookahead;
		match(lookahead);
		multiplicativeExpr();

		// Report Op
		if (op == '*') cout << "mul" << endl;
		else printOper(op);
	}
}

void additiveExpr() {
	multiplicativeExpr();

	while (lookahead == '+' || lookahead == '-') {
		int op = lookahead;
		match(lookahead);
		additiveExpr();

		// Report Op
		if (op == '-') cout << "sub" << endl;
		else printOper('+');
	}
}

void relationalExpr() {
	additiveExpr();

	while (lookahead == '>' || lookahead == '<' || 
		lookahead == GREATEQUAL || lookahead == LESSEQUAL) {
		int op = lookahead;
		match(lookahead);
		relationalExpr();

		// Report Op
		printOper(op);
	}
}

void equalityExpr() {
	relationalExpr();

	while (lookahead == NOTEQUALS || lookahead == EQUALS) {
		int op = lookahead;
		match(lookahead);
		equalityExpr();

		// Report Op
		printOper(op);
	}
}

void logicalAndExpr() {
	equalityExpr();

	while (lookahead == LAND) {
		match(LAND);
		logicalAndExpr();

		// Report Op
		printOper(LAND);
	}
}

void Expr() {
	// Able to left factor this LAND
	logicalAndExpr();
	
	// Inlined tail-recursion
	while (lookahead == LOR) {
		match(LOR);
		Expr();

		// Report Op
		printOper(LOR);
	}
}




void match(int t) {
	if (lookahead != t) {
		error(t);
	}
	if (nexttoken) {
		lookahead = nexttoken;
		lexbuf = nextbuf;
		nexttoken = 0;
	} else {
		lookahead = yylex();
		lexbuf = yytext;
	}
}

void error(int t) {
	report("parse error");
	cout << "---------------" << endl;
	cout << "Expected: " << lookahead << ", with: " << lexbuf << endl;
	cout << "Was given: " << t << endl;
	cout << "---------------" << endl;

}

int peek() {
	if (!nexttoken) {
		nexttoken = yylex();
		nextbuf = yytext;
	}
	return nexttoken;
}

void argument() {
	if (lookahead == STRING) {
		match(STRING);
	} else {
		Expr();
	}
}

void argumentList() {
	argument();
	while (lookahead == ',') {
		match(',');
		argument();
	}

}

void printOper(int op) {
	if (op == '/') cout << "div" << endl;
	else if (op == '%') cout << "rem" << endl;
	else if (op == '+') cout << "add" << endl;
	else if (op == LOR) cout << "or" << endl;
	else if (op == LAND) cout << "and" << endl;
	else if (op == '<') cout << "ltn" << endl;
	else if (op == '>') cout << "gtn" << endl;
	else if (op == LESSEQUAL) cout << "leq" << endl;
	else if (op == GREATEQUAL) cout << "geq" << endl;
	else if (op == '&') cout << "addr" << endl;
	else if (op == '!') cout << "not" << endl;
	else if (op == EQUALS) cout << "eql";
	else if (op == NOTEQUALS) cout << "neq";
}

void print(string output) {
	cout << output << endl;
}

int main() {
    lookahead = yylex();

    while(lookahead != DONE) {
       	Expr();
    }
    return 0;
}
