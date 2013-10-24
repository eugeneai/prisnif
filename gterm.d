module gterm;

import std.stdio;
import std.conv;
import std.random;

import symbol;
import misc;
import answer;

/*------------------------------------------*/
class GTerm{
	Symbol symbol;
	GTerm[] args;

	GTerm[] concretized;
	ulong[] conccount;

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
		//conccount = new int[0];

	}

	void add_conc(GTerm t){
		/*foreach(i,tl;concretized){
			if(t.is_twin(tl)) {
				conccount[i]++;
				return;
			}
		}*/
		concretized~=[t];
		//conccount~=[1];
	}

	void rem_conc(GTerm t){
		foreach(i,c;concretized){
			if(t.is_twin(c)){
				if(false /*conccount[i]>0*/){
					conccount[i]--;
					return;
				}else{
					concretized = concretized[0..i]~concretized[i+1..$];
					//conccount = conccount[0..i]~conccount[i+1..$];
				}
			}
		}
	}

	bool cont_term(GTerm t){
		//writeln("cont term");
		//print();
		//t.print();
		foreach(i,tl;concretized){
			if(t.is_twin(tl)) {
				return true;
				//if(conccount[i]>4)return true;
			}
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
		return this;
	}

	static GTerm tfalse = null;
	static GTerm cr_false(){
		if(tfalse is null){
			tfalse = new GTerm(new Symbol(SymbolType.ATOM,"False",0));
		}
		return tfalse;
	}


	ulong weight(){
		GTerm t = get_value();
		if(t.symbol.arity==0){
			return 1;
		}else{
			ulong res=0;
			foreach(a;args){
				res+=a.weight();
			}
			return res;
		}

	}

	void set_arg(GTerm t, ulong n){
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
			//writeln(symbol.name, " is mutable");
			//if not substituted
			if( args[0] is null){
				//writeln("args[0] is null");
				return symbol.name;
			}else{
				//writeln("args[0] not null");
				return args[0].to_string();
			}
		}else{
			res~= symbol.name;
			if(symbol.arity>0) res ~= "(";
			for(ulong i=0;i<args.length;i++){
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
		for(ulong i=0;i<tthis.symbol.arity;i++){
			if(!tthis.args[i].is_twin(t2.args[i]))return false;
		}
		return true;
	}

	bool twinh(GTerm t){
		GTerm tthis = get_value();
		GTerm t2 = t.get_value();
		if(tthis.is_uhe() && t2.is_uhe()) return true;
		if(tthis.symbol!=t2.symbol)return false;
		//writeln("43");
		for(ulong i=0;i<tthis.symbol.arity;i++){
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
		//НЭЭ копируется как есть
		if(is_uhe()){
			return this;
		}
		//Если это а-переменная
		//Если она конкретизирована, то копируем конкретизацию
		//Если она свободна, то разыменовываем.
		if(is_avar()){
                  if(is_substed()){
				return args[0].get_hard_copy(vm);
			}else{
				return vm.get(this);
			}
		}else if(is_evar()){
			return vm.get(this);
			/*if(vm.is_contains(symbol)){
				GTerm t = new GTerm(new Symbol(symbol));
				return t;
			}else{
				return this;
			}*/
		}else{
			GTerm t = new GTerm(symbol);
			for(ulong i=0;i<symbol.arity;i++){
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
          if(is_top_avar())writeln("AVARIABLE");
          if(is_top_constant())writeln("CONSTANT");
          if(is_top_evar())writeln("EVARIABLE");
          if(is_top_uhe())writeln("UHE");
          if(is_top_atom())writeln("ATOM");
          if(is_top_function())writeln("FUNCTION");

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


	static long matchingsize = 0;

	/*ordinary matching*/
	Answer matching(GTerm t){
		//writeln("GTerm.matching [start]");
		Answer answer = new Answer();
		GTerm tq = get_value();// из вопроса (правый)
		GTerm tb = t.get_value();// из базы (левый)
		matchingsize++;
		//writeln("GTerm.matching [start]");
		//writeln("----------");
		//tq.print();
		//writeln("x");
		//tq.print_type();
		//tb.print();
		//tb.print_type();
		//t.print();
		//if(t.args is null)writeln("null."); else writeln(t.args.length);
		//if(tb.args is null)writeln("null."); else writeln(tb.args.length);
		//если справа константа
		if(tq.is_top_constant()){
			//writeln("tq top constant");
			//writeln("point: GTerm: matching: tq is constant.");
			//if(tb.args is null)writeln("null."); else writeln(tb.args.length);
			//если слева константа
			if(tb.is_top_constant()){
				//writeln("tb top constant");
				//writeln("top constant");
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
				//writeln("tb top uhe");
				//writeln("left uhe");
				//if(tb.args is null)writeln("args is null");else writeln(tb.args.length);

				if(tb.args[1] is null){
					//writeln("args[1] is null");
					Binding b = new Binding(tb,tq);
					b.apply();
					answer.add_binding(b);
					//tb.args[1].add_conc(tq);
				}else if(tb.args[1].cont_term(tq)){
					//writeln("x");
					return null;
				}else{
					//writeln("y");
					Binding b = new Binding(tb,tq);
					b.apply();
					answer.add_binding(b);
					tb.args[1].add_conc(tq);//

				}
				//answer.print();
				return answer;
			}
			//если слева что-то другое, то fail
			else return null;
		}
		//если справа е-переменная
		else if(tq.is_top_evar()){
			//writeln("tq top evar");
			//если слева evar
			if(tb.is_top_evar()){
				//writeln("tb top evar");
				if(!tq.is_twin_names(tb))
					return null;
				else{
					return answer;
				}
			}
			//если слева НЭЭ
			else if(tb.is_top_uhe()){
				//writeln("tb top uhe");
				if(tb.args[1] is null){
					//writeln("args[1] is null");
					Binding b = new Binding(tb,tq);
					b.apply();
					answer.add_binding(b);
					//tb.args[1].add_conc(tq);
				}else
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
			//writeln("tq top avar");
			//writeln("point: matching; tq is avar." );
			Binding b = new Binding(tq,tb);
			b.apply();
			//b.print();
			answer.add_binding(b);
			return answer;
		}
		//если справа uhe
		else if(tq.is_top_uhe()){
			//writeln("tq top uhe");
			if(tb.is_top_uhe()){
				//writeln("tb top uhe");
				//Если это два одинаковых НЭЭ
				if(tq.is_twin_names(tb)){
					return answer;
				}else{
					//Если это разные НЭЭ. То есть два варианта. Или они унифицируются или нет. !!!

					if(tq.args[1] is null){

						if(Oracle.iffff()){
							Binding b = new Binding(tq,tb);
							b.apply();
							answer.add_binding(b);
							return answer;
						}else {
							//writeln("_");
							return null;
						}

						/*Binding b = new Binding(tq,tb);
						b.apply();
						answer.add_binding(b);*/
					}else if(tq.args[1].cont_term(tb))
						//writeln("");
						return null;
					else{
						Binding b = new Binding(tq,tb);
						b.apply();
						answer.add_binding(b);

						tq.args[1].add_conc(tb);//
					}
					return answer;
					/*
					if(Oracle.iffff()){
						//writeln(".");
						Binding b = new Binding(tq,tb);
						b.apply();
						//writeln("----------");
						//tq.print();
						//tb.print();
						//writeln("----------+");
						answer.add_binding(b);
						return answer;
					}else {
						//writeln("_");
						return null;
					}*/

				}
			}else{
				//writeln("tb top not uhe");
				//tq.print();
				//tb.print();
				if(tb.is_contains(tq)){
					//writeln("match contains null");
					return null;
				}
				if(tq.args[1] is null){
					//writeln("args[1] is null");
					Binding b = new Binding(tq,tb);
					b.apply();
					answer.add_binding(b);
					//tb.args[1].add_conc(tq);
				}else
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
			//writeln("tq top function");
			if(tb.is_top_function()){
				//writeln("tb top function");
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
				//writeln("tb top uhe");
				//writeln("matching left h:");
				//tq.print();
				//tb.print();
				//чтоб не зациклилось
				//writeln("tt");
				//writeln(tq.args[0].symbol.name);
				//writeln(tq.args[0].args[0].symbol.name);
				//tq.args[]
				//if(tq.args is null)writeln("args is null");else writeln(args.length);
				//tq.print();
				//tb.print();
				//if(tq is null) writeln("tq null");
				if(tq.is_contains(tb)){
					//writeln("match contains null");
					return null;
				}
				//writeln("ok containts");
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
			//writeln("tq top atom");
			//writeln(tb.args.length);
			if(tb.is_top_atom()){
				//writeln("tb top atom");
				//writeln(tb.args.length);
				if(!tq.is_twin_names(tb)){
					//writeln("atom null");
					return null;
				}else{
					//tq.print();
					//tb.print();
					foreach(i,subt;tq.args){
						//writeln("1");
						Answer subanswer = subt.matching(tb.args[i]);
						//writeln("2");
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
