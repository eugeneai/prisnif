module symbol;

import std.stdio;
import std.conv;

enum SymbolType {CONSTANT, EVARIABLE, AVARIABLE, FUNCTION, ATOM, INTEGER, FLOAT, STRING, UHE};

/*------------------------------------------------------------*/
/*Symbol description*/
class Symbol{
	/*string representation*/
	string name;
	SymbolType type;
	int arity;
	//semantic... reducibility
	
	static int uhecount=1;
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
	
	this(SymbolType _type, string _name, int _arity){
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
	
}

/*--------------------------------------------------*/
/*Symbol table*/
class SymbolTable{
	Symbol[string] table;
	static int i=0;
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
	
	void add_symbol(Symbol s){
		if(is_contains(s)){
			table[s.name] = s;
			i++;
		}
	}
}; 