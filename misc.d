module misc;
import std.stdio;
import gterm;
import symbol;
import qformulas;
import std.random;

/*===============================================================================================*/
class VarMap{
	GTerm[Symbol] vm;
	
	bool is_contains(Symbol s){
		if(s in vm) return true; else return false;
	}
	
	void add(GTerm t, Symbol s){
		vm[s] =t;
	}	
	
	/*создает новый список переменных, и одновременно засовывает их в мэп*/
	QVars add_qvars(QVars qvs){
		QVars new_qvs = new QVars();
		foreach(i,e; qvs.vars){
			GTerm t = new GTerm(new Symbol(e.symbol));
			new_qvs.add_var(t);
			add(t,e.symbol);
		}
		foreach(i,e; qvs.unconfined_vars){
			GTerm t = new GTerm(new Symbol(e.symbol));
			new_qvs.add_unconfined_var(t);
			add(t,e.symbol);
		}

		return new_qvs;
	}
	
	GTerm get(GTerm t){
		if(t.symbol in vm){
			return vm[t.symbol];
		}else{
			return t;
		}
	}
}



/*===============================================================================================*/
class VarList{
	GTerm[string] vars;

	
	void addStrVar(string str,SymbolType _type){
		vars[str] = new GTerm(new Symbol(_type,str,0));
	}
	
	GTerm getVar(string str){
		if(str in vars){
			return vars[str];
		}else return null;
	}
	
	void print(){
		foreach(s,t;vars){
			writeln(s,":",t.to_string());
		}
	}
	
	VarList get_fuzzy_copy(){
		VarList cvl = new VarList();
		
		cvl.vars = vars;
			
		return cvl;
	}	
	
}


/*======================================*/
class Oracle{

	static bool arrrr(){
		return true;
	}
	
	static void pause(){
		for(int i=0;i<1000000000;i++){
			
		}
	}	

	static bool iffff(){
		auto x = uniform(0,10);
		if(x>5)return true; else return false;
	}
}

GTerm xsum(GTerm t1, GTerm t2){
	return null;
}


/*=============================================*/

//void next(int[] _a_index){
//	int k = 0;
//	if(_a_index.length==0){
//		overflow = true;
//		return;
//	}
//	while(true){
//		if(_a_index[k] > 1 ){
//			_a_index[k]--;
//			break;
//		}else{
//			int ind2=k;
//			bool fl = false;
//			while(_a_index[ind2] < 2){
//				ind2++;		
//				if(ind2==_a_index.length){
//					fl=true;
//					break;
//				}			
//			}
//			if(fl){
//				overflow = true;
//				break;
//			}
//			_a_index[ind2]--;
//			for(int jj=0;jj<ind2;jj++){
//				_a_index[jj] = a_index_orig[jj];
//			}
//			break;
//		}
//	}
//}