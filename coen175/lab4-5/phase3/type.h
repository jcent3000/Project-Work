/*
 * File:	type.h
 *
 * Description:	This file contains the public function and variable
 *		declarations for the type class for Simple C.
 */

# ifndef TYPE_H
# define TYPE_H

# include <iostream>
# include <vector>
# include "assert.h"


typedef std::vector<class Type> Parameters;

class Type {
	int _specifier;
	unsigned _indirection;
	unsigned long _length;
	Parameters *_parameters;
	enum { ARRAY, ERROR, FUNCTION, SCALAR } _declarator;

public:
	// Constructors
	Type();
	Type(int specifier, unsigned indirection = 0); 							// Scalar
	Type(int specifier, unsigned indirection, unsigned long length);		// Array
	Type(int specifier, unsigned indirection, Parameters *parameters);		// Function

	// overloaded operators
	bool operator ==(const Type &rhs) const;
	bool operator !=(const Type &rhs) const;

	// useful functions
	bool isArray() const { return _declarator == ARRAY; }
	bool isScalar() const { return _declarator == SCALAR; }
	bool isFunction() const { return _declarator == FUNCTION; }
	bool isError() const { return _declarator == ERROR; }

	// Accessors (note: no setters)
	int specifier() const { return _specifier; }
	unsigned indirection() const { return _indirection; }
	unsigned long length() const { assert(_declarator == ARRAY); return _length; }
	Parameters *parameters() const { return _parameters; }

	// ostream overload
	friend std::ostream& operator<<(std::ostream& os, const Type& tp);



};

# endif /* TYPE_H */
