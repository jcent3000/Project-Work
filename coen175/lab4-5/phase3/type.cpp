/*
 * File:	type.cpp
 *
 * Description:	This file contains the public function for the type class for Simple C.
 */
#include "type.h"
#include "tokens.h"

using namespace std;

// Constructors

Type::Type()
: _declarator(ERROR)
{
}

Type::Type(int specifier, unsigned indirection)
 : _specifier(specifier), _indirection(indirection), _declarator(SCALAR) 
 {
}

Type::Type(int specifier, unsigned indirection, unsigned long length)
: _specifier(specifier), _indirection(indirection), _length(length), _declarator(ARRAY) 
{
}

Type::Type(int specifier, unsigned indirection, Parameters *parameters) 
: _specifier(specifier), _indirection(indirection), _parameters(parameters), _declarator(FUNCTION) 
{
}

// end constructors




// Overloaded Operators Functions

bool Type::operator==(const Type &rhs) const
{
	if (_declarator != rhs._declarator)
		return false;

	if (_declarator == ERROR)
		return true;

	if (_specifier != rhs._specifier)
		return false;

	if (_indirection != rhs._indirection)
		return false;

	if (_declarator == SCALAR)
		return true;

	if (_declarator == ARRAY)
		return _length == rhs._length;

	if (!_parameters || !rhs._parameters)
		return true;

	return *_parameters == *rhs._parameters;
}

bool Type::operator !=(const Type &rhs) const 
{
	return !operator ==(rhs);
}


ostream& operator<<(ostream& os, const Type& tp)
{
	if (tp.isError()) {
		os << "error";
	} else {
		// Print Specifier
		if (tp.specifier() == INT)
			os << "INT";
		else if (tp.specifier() == LONG)
			os << "LONG";
		else
			os << "UNKNOWN";
		// Print Indirection
		if (tp.indirection() > 0)
			os << " " << string(tp.indirection(), '*');
		// Print Type
		if (tp.isArray())
			os << "[" << tp.length() << "]";
		else if (tp.isFunction())
			os << "()";
		else
			os << "unkown _declarator";
	}
    return os;
}