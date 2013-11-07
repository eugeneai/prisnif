module symbol;

import std.stdio;
import std.conv;
import gterm;

enum SymbolType {CONSTANT, EVARIABLE, AVARIABLE, FUNCTION, ATOM, INTEGER, FLOAT, STRING, UHE};
/*
UHE = "unconfined herbrand element".
*/

/*------------------------------------------------------------*/
/*Symbol description*/
class Symbol{
	/*string representation*/
	string name;
	SymbolType type;
	ulong arity;

	static ulong uhecount=1;
	static Symbol cr_uhe(){
		Symbol s = new Symbol(SymbolType.UHE,"h"~to!string(uhecount),0);
		uhecount++;
		return s;
	}
	this(){

	}

	this(Symbol s){
		type = s.type;
		name = s.name;
		arity = s.arity;
	}

	this(SymbolType _type){
		type = _type;
	}

	this(SymbolType _type, string _name, ulong _arity){
		type=_type;
		name = _name;
		if(type==SymbolType.EVARIABLE || type==SymbolType.INTEGER || type==SymbolType.FLOAT || type==SymbolType.CONSTANT){
			arity = 0;
		}else if(type==SymbolType.AVARIABLE || type==SymbolType.UHE){
			arity = 0;
		}else{
			arity=_arity;
		}
	}

	bool is_mutable(){
		if (type==SymbolType.AVARIABLE || type==SymbolType.UHE) return true; else return false;
	}

	void get_sema(){

	}

	bool compare(Symbol _s){
		if(_s==this) return true;
		if(_s.type==SymbolType.EVARIABLE) return false;
		if(_s.name == name)return true; else return false;
		//}
		return false;
	}
  GTerm reduce(GTerm ot){ // I.e. original t[erm]
		//writeln("reduce: [start]");
		GTerm t = ot.get_value();
		if(t.is_top_constant()) return ot;
		if(t.is_top_atom()){
			foreach(i,a;t.args){
				t.args[i] = reduce(a);
			}
			return t;
		}
		/* FIXME: This stuff must not exists at all
                        if(t.is_top_function()) {
			//writeln("reduce: function");

			if(t.symbol.name=="+"){
				ulong r = to!int(t.args[0].reduce().symbol.name) + to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}
			if(t.symbol.name=="-"){
				ulong r = to!int(t.args[0].reduce().symbol.name) - to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}
			if(t.symbol.name=="*"){
				ulong r = to!int(t.args[0].reduce().symbol.name) * to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}
			foreach(i,a;t.args){
				t.args[i] = a.reduce();
			}
			return t;
                        }
                */
                return ot;
	}
}

/*--------------------------------------------------*/
/*Symbol table*/
class SymbolTable{
	Symbol[string] table;
	static ulong i=0;
	//static Symbol[10000] table;
	this(){
		//table = new Symbol[1000];
	}

	Symbol get_symbol(string str){
		if(str in table) return table[str]; else return null;
	}

	Symbol addget_symbol(Symbol s){
		if(s.name in table)
			return table[s.name];
		else{
			table[s.name] = s;
			return table[s.name];
		}
	}

	bool is_contains(Symbol s){
		if(s.name in table){
			if(table[s.name]==s)return true;else return false;
		}else return false;
	}

	bool is_contains_string(string s){
		if(s in table)return true; else return false;
	}

	bool add_symbol(Symbol s){
		if(! is_contains(s)){
			table[s.name] = s;
			i++;
                        return true;
		} else {
                  return false;
                }
	}
};
