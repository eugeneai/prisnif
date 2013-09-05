module qformulas;

import std.stdio;
import gterm;
import pchunk;
import misc;
import answer;
import symbol;

/*=======================================================*/
/*ordinary conjunct (not base)*/
class Conjunct{
	GTerm[] conjunct;//Array of Atoms

	static asize = 0;
	static esize = 0;


	this(ulong len){
		conjunct = new GTerm[len];
	}

	this(GTerm[] gtseq){
		conjunct = gtseq;
	}

	void reduce(){
		foreach(i,c;conjunct){
			conjunct[i] = c.reduce();
		}
	}


	PChunk!(GTerm) to_pchunk(PChunk!(GTerm) lbase){
		PChunk!(GTerm) rpchunk = new PChunk!(GTerm)();
		foreach(ratom;conjunct){
			if(!lbase.is_contains(ratom)){
				rpchunk.add(ratom);
			}
		}
		return rpchunk;
	}

	PChunk!(GTerm) to_pchunk(){
		PChunk!(GTerm) rpchunk = new PChunk!(GTerm)();
		foreach(ratom;conjunct){
			rpchunk.add(ratom);
		}
		return rpchunk;
	}

	GTerm get(ulong i){
		return conjunct[i];
	}

	ulong get_size(){
		return conjunct.length;
	}

	bool is_empty(){
		if(conjunct.length==0)return true; else return false;
	}

	/*to_string*/
	string to_string(){
		string res="[";
		foreach(gt;conjunct){
			res~=gt.to_string()~",";
		}
		res~="]";
		return res;
	}

	/*print*/
	void print(){
		writeln(to_string());
	}

	/*---*/
	bool is_contains(GTerm t){
		foreach(gt;conjunct){
			if(gt.is_contains(t))return true;
		}
		return false;
	}

	/*hard copy*/
	Conjunct get_hard_copy(VarMap vm){
		Conjunct ncon = new Conjunct(conjunct.length);
		foreach(i,gt;conjunct){
			ncon.conjunct[i] = conjunct[i].get_hard_copy(vm);
		}
		return ncon;
	}
}


/*=========================================================*/
/*forall-formula*/
class AFormula{
	QVars vars;
	Conjunct conjunct;
	//subformulas: exists-formulas
	EFormula[] efs;

	bool isGoal=false;
	bool isDeep;
	bool cevars=false;//содердит ли консеквент е-переменные.

	this(){

	}


	bool empty(){
		if(conjunct.is_empty() && vars.empty()){
			return true;
		}
		return false;
	}

	bool evars(){
		foreach(e;efs){
			if(e.evars()){
				cevars=true;
				return true;
			}
		}
		return false;
	}

	//удаление фиктивных связок
	AFormula[] reductio(){
		if(empty()){
			if(efs.length==1){
					
			}
			foreach(e;efs){
				if(!e.empty()){
					AFormula[] res = new AFormula[1]; 
					res[0] = this;					
					return res;
				}
			}
			//writeln("Найдена фиктивная связка кванторов");
			AFormula[] res = new AFormula[0];			
			foreach(e;efs){
				res~=e.afs;
			}
			return res;
		}else{
			AFormula[] res = new AFormula[1]; 
			res[0] = this;
			return res;
		}
	}

	void reduce(){
		conjunct.reduce();
		foreach(e;efs){
			e.reduce();
		}
	}

	bool is_goal(){
		return isGoal;
	}

	bool disjunctive(){
		if (efs !is null){
			if(efs.length>1)return true;
		}
		return false;
	}

	string to_string(string tab){
		string estr = ""; if(cevars) estr = "?";
		string res = tab~"a"~vars.to_string()~estr~"\n";
		res~=tab~"a"~conjunct.to_string()~"\n";
		foreach(e;efs){
			res~=e.to_string(tab~"    ")~"\n";
		}
		return res;
	}

	/*-----*/
	AFormula get_hard_copy(VarMap vm){
		AFormula naf = new AFormula();
		naf.vars = vm.add_qvars(vars);
		naf.conjunct = conjunct.get_hard_copy(vm);
		naf.efs.length = efs.length;
		foreach(i,e;efs){
			naf.efs[i] = e.get_hard_copy(vm);
		}
		naf.isGoal = isGoal;
		naf.isDeep = isDeep;
		return naf;
	}

	/*set unconfined variables*/
	bool set_unconfined_vars(){
		bool flag8 = false;
		foreach(i,v;vars.vars){
			//writeln("0");
			if(!conjunct.is_contains(v)){
				//v.type=GTermType.ovar;
				//writeln("1");
				vars.unconfined_vars~=[v];
				//writeln("2");
				flag8 = true;
			}
		}
		return flag8;
	}

	void set_is_goal(){
		foreach(e;efs){
			if(e.is_contains_false()){
				isGoal=true;
				return;
			}
		}
	}
}


/*=========================================*/
/*exists-formula*/
class EFormula{
	QVars vars;
	Conjunct conjunct;
	//subformulas: forall-formulas
	AFormula[] afs;

	this(){

	}

	bool evars(){
		if(varsempty()){
			foreach(a;afs){
				if(a.cevars) return true;
				if(a.evars())return true;
			}
			return false;
		}
		return true;
	}

	bool varsempty(){
		if(vars.empty()) return true;
		return false;
	}

	bool empty(){
		if(conjunct.is_empty() && vars.empty()){
			return true;
		}
		return false;
	}

	//схлопывание (удаление фиктивных связок кванторов)
	void reductio(){
		//writeln("EFormula reductio");
		AFormula[] newafs = new AFormula[0];
		if(afs is null) return;
		foreach(a;afs){
			newafs~=a.reductio();
		}
		afs = newafs;
	}

	void reduce(){
		conjunct.reduce();
		foreach(a;afs){
			a.reduce();
		}
	}

	bool is_contains_false(){
		if(conjunct.is_contains(GTerm.cr_false())){
			return true;
		}else return false;
	}

	EFormula get_hard_copy(VarMap vm){
		EFormula nef = new EFormula();
		nef.vars = vm.add_qvars(vars);
		nef.conjunct = conjunct.get_hard_copy(vm);
		nef.afs.length = afs.length;
		if(afs.length==0)return nef;
		foreach(i,a;afs){
			nef.afs[i] = a.get_hard_copy(vm);
		}
		return nef;
	}

	string to_string(string tab){
		string res = tab~"e"~vars.to_string()~"\n";
		res~=tab~"e"~conjunct.to_string()~"\n";
		foreach(a;afs){
			res ~= a.to_string(tab~"    ")~"\n";
		}
		return res;
	}

	void print(){
		writeln(to_string("    "));
	}
}

/*===========================================*/
/*quantifiers variables*/
class QVars{
	GTerm[] vars;

	GTerm[] unconfined_vars;//неограниченные переменные


	bool empty(){
		if(vars.length==0 && unconfined_vars.length==0) return true; else return false;
	}

	bool unc(){
		if (unconfined_vars.length==0) return false; else return true; 
	}

	this(){
		vars = new GTerm[0];
		unconfined_vars = new GTerm[0];
	}

	Answer get_unconfined_answers(){
		//если открытых переменных нет, то и подстановки для них нет
		if(unconfined_vars.length==0)
			return null;
		else{
			Answer ans = new Answer();
			foreach(uv;unconfined_vars){
				GTerm hx = new GTerm(Symbol.cr_uhe());
				hx.args[1] = uv;
				//hx.print();
				//uv.print();
				Binding b = new Binding(uv,hx);
				ans.add_binding(b);
			}
			return ans;
		}
	}

	string to_string(){
		string res="[";
		foreach(v;vars){
			res~=v.to_string()~", ";
		}
		res~="]";
		return res;

	}

	void print(){
		writeln(to_string());
	}

	void add_var(GTerm v){
		vars~=[v];
	}

	void add_unconfined_var(GTerm v){
		unconfined_vars~=[v];
	}
	/*QVars get_hard_copy(){
		GTerm[] vars2;
		vars2.length = vars.length;

		foreach(i,v;vars){
			vars2[i] = vm.get(v);
		}

		QVars qv = new QVars();
		qv.vars = vars2;
		return qv;
	}*/
}
