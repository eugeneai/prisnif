module question;
import std.stdio;
import qformulas;
import answer;
import gterm;
import symbol;
import pchunk;
import misc;

/*----------------------------------------------------*/
/*question subformula*/
class Question{
	AFormula af;
	QData qd;
	
	//Если создается новый вопрос, у него ещё нет предыстории ответов.
	this(AFormula _af){
		af = _af;
		//writeln("point: new Quesntion: new Qdata: [start]");
		qd = new QData(af.conjunct.get_size());
	}
	
	//если просто ссылка перекидывается
	this(){
		//af = lq.af;
	}
	
	void link(Question lq){
		af = lq.af;
		qd = new QData(af.conjunct.get_size());
		qd.link(lq.qd);
	}
	
	GTerm[] get_conjunct(){
		//writeln("get_conjunct: [start]");
		return af.conjunct.conjunct;
	}
	
	int get_conjunct_size(){
		return af.conjunct.conjunct.length;
	}

	Answer retrieve_answer(){
		startr:
		Answer ans = qd.retrieve_next_answer();
		if(ans is null) {
			return null;
		}
		ans.add_answer(af.vars.get_unconfined_answers());
		//ans.print();
		//if (false){
		if(is_contains_answer(ans)){
			if(ans.is_empty()) return null;
			writeln("contains");
			//print();
			//ans.print();
			//Oracle.pause();
			goto startr; 	
		} else{
			qd.add_answer(ans);
			return ans;	
		}	
		return ans;
	}
	
	string to_string(string tab){
		return af.to_string(tab);
	}
	
	void print(){
		writeln(to_string(""));
	}
	
	bool is_goal(){
		return af.is_goal();
	}
	
	void numerize_subanswers(){
		foreach(sa;qd.subanswers){
			sa.numerize();
		}
	}
	void numerize_answers(){
		qd.answers.numerize();
	}
	
	bool is_contains_answer(Answer a){
		if(qd.is_contains_answer(a))return true; else return false;
	}
}

/*----------------------------------------------------*/
/*questions data: base of answers*/
class QData{
	PChunk!(Answer)[] subanswers;//чанк ответов для каждого атома
	PChunk!(Answer) answers;//чанк полных ответов
	//aindex это текущая выборка возможных подответов.
	//то что записано в aindex УЖЕ проверено
	//старт с 0 0 0 0...; стартовая комбинация находится ближе к корню ДСВ.
	int[] aindex;
	bool overflow;

	//n = количество атомов в конъюнкте вопроса
	this(int n){
		subanswers = new PChunk!(Answer)[n];
		//creating of dummy chunks
		for(int i=0; i<subanswers.length;i++){
			subanswers[i] = new PChunk!(Answer)();
		}
		answers = new PChunk!(Answer);
		overflow = false;
		aindex = new int[subanswers.length];
		if(subanswers.length>0)aindex[0] = -1;

	}
	
	void link_i(int i, PChunk!(Answer) l){
		//writeln("QData: link_i: [strart]");
		subanswers[i].link(l);
	}
	void link(QData lqd){
		//линкуем ответы для каждого атома
		foreach(i,l;lqd.subanswers){
			link_i(i,l);
		}
		//линкуем полные ответы
		answers.link(lqd.answers);
		aindex = lqd.aindex.dup;
		overflow = lqd.overflow;
	}
	
	//добавить полный ответ
	void add_answer(Answer a){
		answers.add(a);
	}
	
	bool is_contains_answer(Answer a){
		if(answers.is_contains(a)){
			return true;
		}else {
			return false;
		}
	}
	
	//найденный ответ на один атом добавляется
	void add(Answer a, int i){
		if(subanswers[i].add(a)){
			overflow = false;
		}
	}

	int[] get_aindex_bound(){
		int[] aindex_bound = new int[aindex.length];
		foreach(i,pch;subanswers){
			aindex_bound[i] = pch.first.number;
		}
		return aindex_bound;		
	}

	/*==========*/
	bool next_aindex(){
		auto bound = get_aindex_bound();

		int k = 0;
		bool fl = false;
		while(aindex[k] == bound[k]){
			k++;		
			if(k == aindex.length){
				overflow = true;
				return false;
			}			
		}
		aindex[k]++;
		for(int i=0;i<k;i++){
			aindex[i] = 0;
		}
		return true;
	}

	/*Является ли aindex годным с точки зрения НЭЭ*/
	private bool is_hvalid(){
		foreach(i,s;subanswers){
			if(!s.get_by_number(aindex[i]).is_hvalid()){
				return false;
			}
		}
		return true;
	}

	bool next_hvalid(){
		auto bound = get_aindex_bound();

		int z = 100000;
		while(z > 0){
			int i = subanswers.length-1;
			while(subanswers[i].get_by_number(aindex[i]).is_hvalid() && i>=0){
				i--;
				if(i<0)break;
			}
			//Если все subanswers h-валидны, то всё ок.
			if(i<0) return true;

			int k = i;
			while(aindex[k] == bound[k]){
				k++;
				if(k == aindex.length){
					overflow = true;
					return false;
				}
			}

			aindex[k]++;
			for(int j=0;j<k;j++){
				aindex[j] = 0;
			}
			z--;
		}
		return false;
	}

	bool is_ready(){
		foreach(i,pch; subanswers){
			if(pch is null) return false;
			if(pch.first is null) return false; 
		}
		return true;
	}

	Answer retrieve_next_answer(){
		//writeln("QData: retrieve_next_answer: [start]");
		if(aindex.length>0){
			if(!is_ready()) return null;
			start:
			next_aindex();
			next_hvalid();
			if(overflow) return null;
			Answer ans = new Answer();
			foreach(i,ind;aindex){
				Answer ans2 = subanswers[i].get_by_number(ind);
				ans = Answer.combine(ans,ans2);
				if(ans is null){
					//writeln("ans is null");
					goto start;	
				} 
			}
			//if(is_contains_answer(ans)) goto start; 
			//else{
				//add_answer(ans);
				return ans;	
			//} 
		}else{
			//writeln("catch");
			return new Answer();
		}
	}	
}
