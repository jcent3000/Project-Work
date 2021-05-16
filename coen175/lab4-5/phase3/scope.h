/*
 * File:	scope.h
 *
 * Description:	This file contains the public function and variable
 *		declarations for the scope class for Simple C.
 */

# ifndef SCOPE_H
# define SCOPE_H

# include <vector>
# include "symbol.h"

typedef std::vector<Symbol*> Symbols;

class Scope {
	typedef std::string string;

	Scope* _parent;
	Symbols _symbols;

public:
	Scope (Scope *parent = nullptr);
	void insert(Symbol* s);
	Symbol* find(string name);
	Symbol* lookup(string name);
	void remove(string name);

	// accessor functions
	Scope* parent() const { return _parent; }
	Symbols symbols() const { return _symbols; }
};

# endif /* SCOPE_H */
