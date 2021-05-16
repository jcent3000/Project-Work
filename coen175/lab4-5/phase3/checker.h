/*
 * File:	checker.h
 *
 * Description:	This file contains the public function and variable
 *		declarations for the checker for Simple C.
 */

# ifndef CHECKER_H
# define CHECKER_H

# include <iostream>
# include <string>
# include "scope.h"
# include "lexer.h"



static Scope* currentScope = nullptr;
static std::string err_redefined = "redefinition of '%s'", err_conflicting = "conflicting types for '%s'",
	err_redeclaration = "redeclaration of '%s'", err_undeclared = "'%s' undeclared";

void openScope();
void closeScope();
void declareVariable(std::string name, Type tp);
void declareFunction(std::string name, Type tp);
void defineFunction(std::string name, Type tp);
void checkID(std::string name);

# endif /* CHECKER_H */
