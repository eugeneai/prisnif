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
	
	GTerm[] concretized;

	this(Symbol _symbol){
		symbol = _symbol;
		SymbolType type = symbol.type;
		//writeln(symbol.name, " ",symbol.arity);
		if(type==SymbolType.EVARIABLE || type==SymbolType.INTEGER || type==SymbolType.FLOAT || type==SymbolType.CONSTANT){
			args = new GTerm[0];
		}else if(type==SymbolType.AVARIABLE){
			args = new GTerm[1];
		}else if(type==SymbolType.UHE){
			//writeln("uhe created");
			//первый аргумент это то до чего доопределяется НЭЭ
			//второй аргумент это родитель НЭЭ, т.е. та переменная, которая его создала.
			args = new GTerm[2];
			//print();
			//writeln(args.length);
		}else{
			args = new GTerm[symbol.arity];
		}		
		concretized = new GTerm[0];
		
	}

	void add_conc(GTerm t){
		concretized~=[t];
	}
	bool cont_term(GTerm t){
		//writeln("cont term");
		//print();
		//t.print();
		foreach(tl;concretized){
			if(t.is_twin(tl)) return true;
		}
		return false;
	}

	
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
		//if(get_value().symbol!=t.get_value().symbol)return false; else return true;
	}	
	
	/*is this contains t*/
	bool is_contains(GTerm t){
		GTerm tthis = get_value();
		GTerm t2 = t.get_value();
		//writeln("55");
		//tthis.print();
		//t2.print();
		if(tthis.is_twin(t2))return true;
		//writeln(5555);
		if(!tthis.symbol.is_mutable()){
			foreach(a;tthis.args){
				if(a.is_contains(t2))return true;
			}
			//writeln("234");
		}		
		return false;	
	}
	
	bool is_substed(){
		if (symbol.type== SymbolType.AVARIABLE || symbol.type == SymbolType.UHE){
			if(args[0] is null) return false; else return true;
		}else return false;
	}
	
	bool is_var(){
		if(symbol.type == SymbolType.EVARIABLE || symbol.type == SymbolType.AVARIABLE) return true; else return false;
	}
	
	bool is_uhe(){
		if(symbol.type == SymbolType.UHE) return true; else return false;
	}
	
	/*hard copy of term*/
	GTerm get_hard_copy(VarMap vm){
		GTerm cvt;
		//Если это НЭЭ, то он не разыменовывается и копия делается мягкая
		//т.е. с сохранением информации что вместо данного НЭЭ
		//что-то подставлено (если подставлено)
		//print();
		if(is_uhe()){
			//print();
			//writeln(args.length);
			/*if(is_substed()){
				GTerm t = new GTerm(symbol);
				//writeln("w");
				t.set_arg(args[0].get_hard_copy(vm),0);
				return t;		
			}else*/ 
			return this;
		}
		//writeln("++++++++++++++++++++++++++++++++++++");
		//print();
			//cvt = get_value();
		//cvt.print(); 
		if(is_var()){
			if(is_substed){
				return args[0].get_hard_copy(vm);
			}else{
				return vm.get(this);
			}
		}else{
			GTerm t = new GTerm(symbol);
			for(int i=0;i<symbol.arity;i++){
				t.set_arg(args[i].get_hard_copy(vm),i);
			}
			return t;
		}

		/*if(cvt.is_var()){
			//тут происходит разыменование переменных
			//vm
			//Symbol varsimbol = new Symbol(cvt.symbol.type);
			return vm.get(cvt);//new GTerm(varsimbol);
		}else{
			//Symbol s = new Symbol();
			//writeln("yy");
			GTerm t = new GTerm(cvt.symbol);
			//writeln("ww");
			//writeln(t.args.length);
			for(int i=0;i<cvt.symbol.arity;i++){
				t.set_arg(cvt.args[i].get_hard_copy(vm),i);
			}
			//writeln(t.args.length,".");
			//t.print();
			return t;			
		}*/
	
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
		//writeln("----------");
		//tq.print();
		//tq.print_type();
		//tb.print();
		//tb.print_type();
		//если справа константа
		if(tq.is_top_constant()){
			//writeln("point: GTerm: matching: tq is constant.");
			//если слева константа
			if(tb.is_top_constant()){
				if(!tq.is_twin_names(tb)){ 
					//writeln("return null");
					return null;
				}
				else{
					return answer;
				}	
			}
			//если слева НЭЭ
			else if(tb.is_top_uhe()){
				//writeln("left uhe");
				//if(args is null)writeln("args is null");
				//доопределить НЭЭ до константы
				if(tb.args[1].cont_term(tq)){ 
					//writeln("x");
					return null;
				}else{			
					//writeln("y");	
					Binding b = new Binding(tb,tq);
					b.apply();
					answer.add_binding(b);
					tb.args[1].add_conc(tq);//
					
				}
				answer.print();
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
			//если слева НЭЭ
			else if(tb.is_top_uhe()){
				if(tb.args[1].cont_term(tq)) 
					return null;
				else{	
				//доопределить НЭЭ до константы
					Binding b = new Binding(tb,tq);
					b.apply();
					answer.add_binding(b);

					tb.args[1].add_conc(tq);//
				}
				return answer;
			}
			//если слева что-то другое, то fail
			else return null;		
		}
		//если справа avar
		else if(tq.is_top_avar()){
			//writeln("point: matching; tq is avar." );
			Binding b = new Binding(tq,tb);
			b.apply();
			//b.print();
			answer.add_binding(b);
			return answer;
		}
		//если справа uhe
		else if(tq.is_top_uhe()){
			if(tb.is_top_uhe()){
				//Если это два одинаковых НЭЭ
				if(tq.is_twin_names(tb)){
					return answer;
				}else{
					//Если это разные НЭЭ. То есть два варианта. Или они унифицируются или нет. !!!
					if(Oracle.iffff()){
						Binding b = new Binding(tq,tb);
						b.apply();
						answer.add_binding(b);
						return answer;
					}else return null;
					
				}
			}else{
				if(tq.args[1].cont_term(tb)) 
					return null;
				else{
					Binding b = new Binding(tq,tb);
					b.apply();
					answer.add_binding(b);

					tq.args[1].add_conc(tb);//
				}
				return answer;
			}
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
							answer.reset_full(); 
							return null;
						}
						else{
							answer.add_answer(subanswer);
						}	
					}
					return answer;
				}
			}
			//а если слева НЭЭ
			else if(tb.is_top_uhe()){
				//writeln("matching left h:");
				//tq.print();
				//tb.print();
				//чтоб не зациклилось
				if(tq.is_contains(tb))return null;
				GTerm newt = new GTerm(tq.symbol);
				foreach(i,subt;tq.args){
					//Symbol newuhe = new Symbol(SymbolType.UHE,"h",0);
					newt.set_arg(new GTerm(Symbol.cr_uhe()),i);
				}
				Binding b = new Binding(tb,newt);
				b.apply();
				answer.add_binding(b);
				//writeln("newt:");
				//newt.print();
				foreach(i,subt;tq.args){
					Answer subanswer = subt.matching(newt.args[i]);
					if(subanswer is null){
						answer.reset_full(); 
						return null;
					}
					else{
						//writeln("subanswer:");
						//subanswer.print();
						answer.add_answer(subanswer);
					}					
				}
				return answer;
			}else{
				return null;
			} 
		}
		//если справа атом
		else if(tq.is_top_atom()){
			if(tb.is_top_atom()){
				if(!tq.is_twin_names(tb)){
					return null;
				}else{
					//tq.print();
					//tb.print();
					foreach(i,subt;tq.args){
						Answer subanswer = subt.matching(tb.args[i]);
						if(subanswer is null){ 
							//writeln("atom null");
							answer.reset_full();
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