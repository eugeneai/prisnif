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
	
	//сколько раз на этот вопрос ответили
	ulong answercount=0;
	

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
	
	void incanswercount(){
		answercount++;
	}

	//содердит ли вопрос в консеквенте е-переменные
	bool evars(){
		return af.cevars;
	}

	bool emptyconj(){
		if(af.conjunct.is_empty()){
			return true;
		}
		return false;
	}

	void link(Question lq){
		af = lq.af;
		answercount = lq.answercount;
		qd = new QData(af.conjunct.get_size());
		qd.link(lq.qd);
	}
	
	GTerm[] get_conjunct(){
		//writeln("get_conjunct: [start]");
		return af.conjunct.conjunct;
	}
	
	ulong get_conjunct_size(){
		return af.conjunct.conjunct.length;
	}

	Answer retrieve_answer(){
		startr:
		//writeln("start retrieve");
		//print();
		//writeln("..........");
		//qd.answers.print();
		Answer ans = qd.retrieve_next_answer();
		//writeln("next retrieved");
		if(ans is null) {
			//writeln("ans is null");
			return null;
		}
		//ans.add_answer(af.vars.get_unconfined_answers());
		if(af.is_goal) return ans;
		//writeln("====cont====");
		//print();
		//ans.print();
		//qd.answers.print();
		//writeln("====end cont====");
		//if (false){
		bool fl = false;
		if(emptyconj()){
			//writeln("Пустой конъюнкт. ",answercount);
			//if(answercount>10) fl = true;
		}
		if(fl){
			//writeln("Исчерпан лимит ответов на вопрос.");
			return null;
		}
		if(is_contains_answer(ans)){
			if(evars()){
				if(answercount<25){
					goto metka;
				}	
				//writeln("Больше не отвечаем повторно нв вопрос с е-переменными.");
			}
			//writeln("contains");
			//print();
			//writeln("----------");
			if(ans.fict){
				if(answercount>25)return null; else goto metka;
			} 
			//writeln("nofict");
			//print();
			//ans.print();
			//Oracle.pause();
			goto startr; 	
		} else{
			metka:
			qd.add_answer(ans);
			Answer rans = new Answer();
			rans.add_answer(ans);
			rans.add_answer(af.vars.get_unconfined_answers());
			return rans;	
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
	
	bool disjunctive(){
		return af.disjunctive();
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

	//удаление фиктивных связок кванторов
	Question[] reductio(){
		AFormula[] newafs = af.reductio();
		Question[] newq = new Question[newafs.length];
		foreach(i,na; newafs){
			newq[i] = new Question(na);
		}
		return newq;
	}

}








/*----------------------------------------------------*/
/*questions data: base of answers*/
class QData{
	static ulong obr = 0;
	PChunk!(Answer)[] subanswers;//чанк ответов для каждого атома
	PChunk!(Answer) answers;//чанк полных ответов
	//aindex это текущая выборка возможных подответов.
	//то что записано в aindex УЖЕ проверено
	//старт с 0 0 0 0...; стартовая комбинация находится ближе к корню ДСВ.
	ulong[] aindex;
	bool overflow;

	//n = количество атомов в конъюнкте вопроса
	this(ulong n){
		subanswers = new PChunk!(Answer)[n];
		//creating of dummy chunks
		for(ulong i=0; i<subanswers.length;i++){
			subanswers[i] = new PChunk!(Answer)();
		}
		answers = new PChunk!(Answer);
		overflow = false;
		aindex = new ulong[subanswers.length];
		if(subanswers.length>0)aindex[0] = -1;

	}
	
	void link_i(ulong i, PChunk!(Answer) l){
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
	void add(Answer a, ulong i){
		if(subanswers[i].add(a)){
			overflow = false;
		}
		//a.print();
		//writeln("added");
	}

	ulong[] get_aindex_bound(){
		ulong[] aindex_bound = new ulong[aindex.length];
		foreach(i,pch;subanswers){
			aindex_bound[i] = pch.first.number;
		}
		return aindex_bound;		
	}

	/*==========*/
	bool next_aindex(){
		auto bound = get_aindex_bound();

		ulong k = 0;
		bool fl = false;
		while(aindex[k] == bound[k]){
			k++;		
			if(k == aindex.length){
				//writeln("overflow nextaindex");
				overflow = true;
				return false;
			}			
		}
		aindex[k]++;
		for(ulong i=0;i<k;i++){
			aindex[i] = 0;
		}
		return true;
	}

	/*Является ли aindex годным с точки зрения НЭЭ*/
	private bool is_hvalid(){
		//writeln("is hvalid");
		foreach(i,s;subanswers){
			if(!s.get_by_number(aindex[i]).is_hvalid()){
				return false;
			}
		}
		return true;
	}

	bool next_hvalid(){
		auto bound = get_aindex_bound();

		ulong z = 100000;
		while(z > 0){
			long i = subanswers.length-1;
			//writeln("i: ",i);
			//writeln(subanswers.length);
			//writeln(aindex.length);
			while(subanswers[i].get_by_number(aindex[i]).is_hvalid() && i>=0){
				i--;
				if(i<0)break;
				//writeln("i: ",i);
			}
			//Если все subanswers h-валидны, то всё ок.
			if(i<0) return true;

			ulong k = i;
			while(aindex[k] == bound[k]){
				k++;
				if(k == aindex.length){
					//writeln("overflow hvalid");
					overflow = true;
					return false;
				}
			}

			aindex[k]++;
			for(ulong j=0;j<k;j++){
				aindex[j] = 0;
			}
			z--;
		}
		return false;
	}

	bool is_ready(){
		foreach(i,pch; subanswers){
			if(pch is null) return false;
			//writeln("e",i);
			if(pch.first is null) return false; 
			//writeln("ee",i);
		}
		return true;
	}

	Answer retrieve_next_answer(){
		obr++;
		ulong obr2 = 0;
		//writeln("QData: retrieve_next_answer: [start]");
		if(aindex.length>0){
			//writeln("is ready ", aindex.length);
			if(!is_ready()){
				//writeln("not ready, return null");
				return null;
			}
			//writeln("ok");
			int zx = 0;
			start:
			zx++;
			// writeln(zx);
			obr2++;
			next_aindex();
			next_hvalid();
			//writeln("hvalid");
			if(overflow){
				//writeln("overflow");
				return null;
			}

			Answer ans = new Answer();
			//writeln("subanswers");
			/*foreach(ind,i;subanswers){
				writeln(ind," :");
				i.print();
			}*/
			//writeln("end print subanswers");
			//writeln("bound: ",get_aindex_bound());
			//if(obr2 % 500000 == 0)writeln("aindex: ",aindex);
			//writeln("aindex: ",aindex);
			//writeln(obr);
			foreach(i,ind;aindex){
				//writeln("start combine iteration");
				//writeln("size: ",subanswers[i].size);
				Answer ans2 = subanswers[i].get_by_number(ind);
				//writeln("get by number Ok");
				//ans.print();
				//if(ans2 is null) writeln("null"); else ans2.print();
				ans = Answer.combine(ans,ans2);
				//writeln("end combine iteration");
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
			return new Answer(true);
		}
	}	
}
