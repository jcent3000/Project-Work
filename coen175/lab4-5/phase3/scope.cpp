# include "scope.h"
using namespace std;

Scope::Scope(Scope* parent)
: _parent(parent)
{
}

void Scope::insert(Symbol* s) {
	_symbols.push_back(s);
}

Symbol* Scope::find(string name) {
	// Look in current scope
	for (unsigned it = 0; it < _symbols.size(); ++it) {
		if (name == _symbols[it]->name()) {
			return _symbols[it];
		}
	}
	// If not found -> return null
	return nullptr;
}

Symbol* Scope::lookup(string name) {
	// Look in current scope
	Symbol *s = find(name);
	if (s != nullptr)
		return s;

	// Look in parents' scopes
	Scope *p = _parent;
	while(p != nullptr) {
		s = p->find(name);
		if (s != nullptr)
			return s;
		p = p->parent();
	}
	return nullptr;
}

void Scope::remove(string name)
{
  for (unsigned it = 0; it < _symbols.size(); ++it)
  {
    if (name == _symbols[it]->name())
    {
      _symbols.erase(_symbols.begin() + it);
      break;
    }
  }
}