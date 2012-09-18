module gterm;

import std.stdio;
import std.conv;

import symbol;
import misc;
import answer;

/*------------------------------------------*/
class GTerm{
	Symbol symbol;
	GTerm[] args;
	
	//GTerm[] concretized;

	this(Symbol _symbol){
		symbol = _symbol;
		SymbolType type = symbol.type;
		//writeln(symbol.name, " ",symbol.arity);
		if(type==SymbolType.EVARIABLE || type==SymbolType.INTEGER || type==SymbolType.FLOAT || type==SymbolType.CONSTANT){
			args = new GTerm[0];
		}else if(type==SymbolType.AVARIABLE){
			args = new GTerm[1];
		}else{
			args = new GTerm[symbol.arity];
		}		
		//concretized = new GTerm[0];
		
	}

	/*void add_conc(GTerm t){
		//writeln("add conc");
		concretized~=[t];
	}

	void rem_conc(GTerm t){
		foreach(i,c;concretized){
			if(t.is_twin(c))concretized = concretized[0..i]~concretized[i+1..$];
		}
	}

	bool cont_term(GTerm t){
		//writeln("cont term");
		//print();
		//t.print();
		foreach(tl;concretized){
			if(t.is_twin(tl)) return true;
		}
		return false;
	}*/

	
	GTerm reduce(){
		//writeln("reduce: [start]");
		GTerm t = get_value();
		if(t.is_top_constant())return this;
		if(t.is_top_atom()){
			foreach(i,a;t.args){
				t.args[i] = a.reduce();
			}
			return t;			
		}
		if(t.is_top_function()){
			//writeln("reduce: function");
			if(t.symbol.name=="+"){
				int r = to!int(t.args[0].reduce().symbol.name) + to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}
			if(t.symbol.name=="-"){
				int r = to!int(t.args[0].reduce().symbol.name) - to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}			
			if(t.symbol.name=="*"){
				int r = to!int(t.args[0].reduce().symbol.name) * to!int(t.args[1].reduce().symbol.name);
				return new GTerm(new Symbol(SymbolType.CONSTANT,to!string(r),0));
			}			
			foreach(i,a;t.args){
				t.args[i] = a.reduce();
			}
			return t;
		}
		return this;
	}

	static GTerm tfalse = null;
	static GTerm cr_false(){
		if(tfalse is null){
			tfalse = new GTerm(new Symbol(SymbolType.ATOM,"False",0));
		}
		return tfalse;
	}
	
	
	void set_arg(GTerm t, int n){
		args[n] = t;
	}
	
	string name_to_string(){
		return symbol.name;
	}
	
	/*transforming string to term*/
	string to_string(){
		string res="";
		//If symbol is AVARIABLE or UHE
		if(symbol.is_mutable()){
			//if not substituted
			if( args[0] is null){
				return symbol.name;
			}else{
				return args[0].to_string();
			}
		}else{
			res~= symbol.name;
			if(symbol.arity>0) res ~= "(";
			for(int i=0;i<args.length;i++){
				res ~= args[i].to_string();
				if(i<args.length-1) res ~= ",";
			}
			if(symbol.arity>0) res ~= ")";
			if(symbol.type==SymbolType.EVARIABLE) res~=":e";
		}
		return res;	
	}
	 
	void print(){
		writeln(to_string());
	}
	
	/*если не подставляем то ниче не меняется, иначе если что-то*/
	/*подставлено, то возвращаем это*/
	GTerm get_value(){
		if(!symbol.is_mutable())return this;
		else if(args[0] is null){
			return this;
		}else {
			return args[0].get_value();
		}
		
	}
	
	/*hard comparizion*/
	bool is_twin(GTerm t){
		GTerm tthis = get_value();
		GTerm t2 = t.get_value();
		if(tthis.symbol!=t2.symbol)return false;
		//writeln("43");
		for(int i=0;i<tthis.symbol.arity;i++){
			if(!tthis.args[i].is_twin(t2.args[i]))return false;
		}
		return true;		
	}
	
	bool is_twin_h(GTerm t){
		GTerm tthis = get_value();
		GTerm t2 = t.get_value();
		if(tthis.is_uhe() && t2.is_uhe()) return false;
		return tthis.is_twin(t2);		
	}
	
	/*hard*/
	bool is_twin_names(GTerm t){
		if(!get_value().symbol.compare(t.get_value().symbol))return false; else return true;
	}	
	
	/*is this contains t*/
	bool is_contains(GTerm t){
		GTerm tthis = get_value();
		GTerm t2 = t.get_value();
		if(tthis.is_twin(t2))return true;
		if(!tthis.symbol.is_mutable()){
			foreach(a;tthis.args){
				if(a.is_contains(t2))return true;
			}
		}		
		return false;	
	}
	
	bool is_substed(){
		if (symbol.type== SymbolType.AVARIABLE){
			if(args[0] is null) return false; else return true;
		}else return false;
	}
	
	bool is_var(){
		if(symbol.type == SymbolType.EVARIABLE || symbol.type == SymbolType.AVARIABLE) return true; else return false;
	}

	bool is_avar(){
		if(symbol.type == SymbolType.AVARIABLE) return true; else return false;
	}
	bool is_evar(){
		if(symbol.type == SymbolType.EVARIABLE) return true; else return false;
	}		
	
	bool is_uhe(){
		if(symbol.type == SymbolType.UHE) return true; else return false;
	}
	
	/*hard copy of term*/
	GTerm get_hard_copy(VarMap vm){
		//Если это а-переменная
		//Если она конкретизирована, то копируем конкретизацию
		//Если она свободна, то разыменовываем.
		if(is_avar()){
			if(is_substed){
				return args[0].get_hard_copy(vm);
			}else{
				/*if(vm.is_contains(this)){
					return new GTerm(Symbol.cr_avar());
				}else return this;*/
				//writeln("hard copy");
				//print();
				return vm.get(this);
			}
		}else if(is_evar()){
			return vm.get(this);
		}else{
			GTerm t = new GTerm(symbol);
			for(int i=0;i<symbol.arity;i++){
				t.set_arg(args[i].get_hard_copy(vm),i);
			}
			return t;
		}

		return null;
	}
	
	void sub_zero(GTerm t){
		args[0]=t;
	}
	
	void print_type(){
		if(is_top_avar)writeln("AVARIABLE");
		if(is_top_constant)writeln("CONSTANT");
		if(is_top_evar)writeln("EVARIABLE");
		
	}
	
	bool is_top_constant(){
		if(symbol.type == SymbolType.CONSTANT)return true; else return false;
	}
	bool is_top_uhe(){
		if(symbol.type == SymbolType.UHE)return true; else return false;
	}
	bool is_top_evar(){
		if(symbol.type == SymbolType.EVARIABLE)return true; else return false;
	}		
	bool is_top_avar(){
		if(symbol.type == SymbolType.AVARIABLE)return true; else return false;
	}	
	bool is_top_function(){
		if(symbol.type == SymbolType.FUNCTION)return true; else return false;
	}	
	bool is_top_atom(){
		if(symbol.type == SymbolType.ATOM)return true; else return false;
	}	
	
	
	/*ordinary matching*/
	Answer matching(GTerm t){
		Answer answer = new Answer();
		GTerm tq = get_value();// из вопроса (правый)
		GTerm tb = t.get_value();// из базы (левый)

		//если справа константа
		if(tq.is_top_constant()){
			//если слева константа
			if(tb.is_top_constant()){
				if(!tq.is_twin_names(tb)){ 
					return null;
				}
				else{
					return answer;
				}	
			}
			else if(tb.is_top_avar()){
				Binding b = new Binding(tb,tq);
				b.apply();
				answer.add_binding(b);
				return answer;
			}
			//если слева что-то другое, то fail
			else return null;
		}
		//если справа е-переменная
		else if(tq.is_top_evar()){
			//если слева evar
			if(tb.is_top_evar()){
				if(!tq.is_twin_names(tb)) 
					return null;
				else{
					return answer;
				}	
			}
			else if(tb.is_top_avar()){
				Binding b = new Binding(tb,tq);
				b.apply();
				answer.add_binding(b);
				return answer;
			}			
			else return null;		
		}
		//если справа avar
		else if(tq.is_top_avar()){
			if(tb.is_top_avar()){
				if(tq.is_twin(tb)) return answer;
			}else if(tb.is_top_function()){
				if(tb.is_contains(tq)){
					//writeln("loop unification");	
					return null;
				}
			}

			Binding b = new Binding(tq,tb);
			b.apply();
			//b.print();
			answer.add_binding(b);
			return answer;
		}
		//если справа функ.символ
		else if(tq.is_top_function()){
			if(tb.is_top_function()){
				if(!tq.is_twin_names(tb)){
					return null;
				}else{
					foreach(i,subt;tq.args){
						Answer subanswer = subt.matching(tb.args[i]);
						if(subanswer is null){
							answer.reset(); 
							return null;
						}
						else{
							answer.add_answer(subanswer);
						}	
					}
					return answer;
				}
			}
			else if(tb.is_top_avar){
				if(tq.is_contains(tb)) {
					//writeln("loop unification");
					return null;
				}
				Binding b = new Binding(tb,tq);
				b.apply();
				answer.add_binding(b);
				return answer;
			}
			else return null;
		}
		//если справа атом
		else if(tq.is_top_atom()){
			if(tb.is_top_atom()){
				if(!tq.is_twin_names(tb)){
					return null;
				}else{
					foreach(i,subt;tq.args){
						Answer subanswer = subt.matching(tb.args[i]);
						if(subanswer is null){ 
							answer.reset();
							return null;
						}
						else{
							answer.add_answer(subanswer);
						}	
					}
					return answer;
				}
			}else return null;		
		}
		
		return null;
	}
}