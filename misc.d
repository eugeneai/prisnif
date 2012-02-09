module misc;
import std.stdio;
import gterm;
import symbol;
import qformulas;

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
			Symbol s = new Symbol(e.symbol);
			GTerm t = new GTerm(s);
			new_qvs.add_var(t);
			add(t,e.symbol);
		}
		foreach(i,e; qvs.unconfined_vars){
			Symbol s = new Symbol(e.symbol);
			GTerm t = new GTerm(s);
			new_qvs.add_unconfined_var(t);
			add(t,e.symbol);
		}	
		
		return new_qvs;
	}
	
	/*VarMap get_fuzzy_copy(){
		VarMap cvm = new VarMap();
		
		GTerm[Symbol] vm2 = vm;
		cvm.vm = vm;
			
		return cvm;
	}*/

	GTerm get(GTerm t){
		if(t.symbol in vm){
			return vm[t.symbol];
		}else{
			//writeln("VARMAPGET FAILURE");
			return t;
		}
		/*else{
			GTerm* tx =new GTerm(t.type, t.nature,0,0);
			vm[t.name] = tx;
			return tx;
		}*/
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