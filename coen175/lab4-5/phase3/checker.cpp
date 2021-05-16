
#include "checker.h"
using namespace std;

void openScope() {
	cout << "opening scope" << endl;

	// Check if first opened scope. 
	if (currentScope == nullptr){
		currentScope = new Scope(nullptr);

	// Else add to scope linked list.
	} else {
		currentScope = new Scope(currentScope);
	}

	return;
}

void closeScope() {
	cout << "closing scope" << endl;
	// delete the symbols in scope
	Symbols symbs = currentScope->symbols();
	for (int i = 0; i < symbs.size(); i++) {
		/*
		// Delete parameter symbols if need be
		Symbols* params = symbs[i].type().parameters();
		if (symbs[i].type().isFunction() 
			&& params != nullptr) {
			// Psuedo: Delete parameter symbols
		}
		*/

		delete symbs[i];
	}


	// delete the old scope
	Scope* foo = currentScope;
	currentScope = currentScope->parent();
	delete foo;
}


// declareVariable - check for possible errors and add symbol to current scope
void declareVariable(string name, Type tp) {
	if (tp.isArray()) {
		cout << "declare " << name << " as (" << tp.specifier() << ", " << tp.indirection() << ", ARRAY)" << endl;
	} else if (tp.isScalar()) {
		cout << "declare " << name << " as (" << tp.specifier() << ", " << tp.indirection() << ", SCALAR)" << endl;
	}

	// Insert symbol if no other symbol with same name in same scope.
	Symbol entry = Symbol(name, tp);
	Symbol* prev_ptr = currentScope->find(name);
	if (prev_ptr == nullptr) {
		currentScope->insert(new Symbol(name, tp));
		return;
	}
	
	// Check for errors now, knowing 'prev' is symbol with same name...
	Symbol prev = *prev_ptr;

	// if entry is 'global var'...
	if (currentScope->parent() == nullptr) {
		if (prev.type() != entry.type()) 
			report(err_conflicting, name);
		else
			currentScope->insert(new Symbol(name, tp));
	// if entry is 'local var'...
	} else {
		report(err_redeclaration, name);
	}	
}


// declareFunction - add symbol to global scope and if previously declared, make sure type matches
void declareFunction(string name, Type tp) {
	cout << "declare " << name << " as (" << tp.specifier() << ", " << tp.indirection() << ", FUNCTION)" << endl;

	Symbol entry = Symbol(name, tp);
	Symbol* prev_ptr = currentScope->lookup(name);
	if (prev_ptr == nullptr) {
		currentScope->insert(new Symbol(name, tp));
		return;
	}
	
	// Check for errors...
	Symbol prev = *prev_ptr;

	// Check both declerations' match types
	if (entry.type() != prev.type())
		report(err_conflicting, name);
	else
		currentScope->insert(new Symbol(name, tp));
}

// defineFunction - ensure it hasn’t been defined before and matches previous declaration if any
void defineFunction(string name, Type tp) {
	cout << "define " << name << " as (" << tp.specifier() << ", " << tp.indirection() << ", FUNCTION)" << endl;

	Symbol entry = Symbol(name, tp);
	Symbol* prev_ptr = currentScope->lookup(name);
	if (prev_ptr == nullptr) {
		currentScope->insert(new Symbol(name, tp));
		return;
	}
	
	// Check for errors...
	Symbol prev = *prev_ptr;

	// Check for redfinitions error
	if (prev.type().parameters() == nullptr){
		// Check declerations' types match error
		if (entry.type() != prev.type())
			report(err_conflicting, name);
		else
			currentScope->insert(new Symbol(name, tp));
	} else {
		report(err_redefined, name);
	}
	
}

void checkID(string name) {
	cout << "check " << name << endl;

	Symbol* symbol = currentScope->lookup(name);

	if (symbol == nullptr) {
		report(err_undeclared, name);
		symbol = new Symbol(name, Type());	// gives type - ERROR
		currentScope->insert(symbol);
	}

}