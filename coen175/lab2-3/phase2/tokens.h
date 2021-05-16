/*
 * File:    tokens.h
 *
 * Description: This file contains the token definitions for use by the
 *      lexical analyzer and parser for Simple C.  Single character
 *      tokens use their ASCII values, so we can refer to them
 *      either as character literals or as symbolic names.
 */

# ifndef TOKENS_H
# define TOKENS_H

enum {
    // single character operators
    ASSIGN = '=', BRACKET1 = '[', BRACKET2 = ']', AMPERSAND = '&', 
    MULT = '*', MINUS = '-', GREATER = '>', LESS = '<', ADD = '+', 
    DIV = '/', EXCLAMATION = '!', PARENTHESES1 = '(', PARENTHESES2 = ')', 
    ABS = '|', CURLY1 = '{', CURLY2 = '}', SEMICOLON = ';', COLON = ':', 
    PERIOD = '.', COMMA = ',',


    // keywords
    AUTO = 256, BREAK, CASE, CHAR, CONST, CONTINUE, DEFAULT, DO, DOUBLE,
    ELSE, ENUM, EXTERN, FLOAT, FOR, GOTO, IF, INT, LONG, REGISTER,
    RETURN, SHORT, SIGNED, SIZEOF, STATIC, STRUCT, SWITCH, TYPEDEF,
    UNION, UNSIGNED, VOID, VOLATILE, WHILE,

    // two character operators, ID, num, string, done
    EQL, ID, NUM, STRING, ERROR, LOR, LAND, EQUALS, NOTEQUALS, LESSEQUAL, 
    GREATEQUAL, INCREMENT, DECREMENT, POINTS, DONE = 0
};

# endif /* TOKENS_H */
