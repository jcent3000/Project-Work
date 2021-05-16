/*
 * File:	symbol.h
 *
 * Description:	This file contains the public function and variable
 *		declarations for the symbol class for Simple C.
 */

# ifndef SYMBOL_H
# define SYMBOL_H

# include <string>
# include "type.h"

class Symbol {
	typedef std:: string string;
	string _name;
	Type _type;

public:
	Symbol(const string &name, const Type &type);
	const string &name() const { return _name; }
	const Type &type() const { return _type; }
};

# endif /* SYMBOL_H */
