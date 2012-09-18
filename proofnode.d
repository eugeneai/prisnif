module proofnode;

import std.stdio;
import gterm;
import question;
import qformulas;
import misc;
import answer;
import pchunk;

/*-----------------------------------------------------*/
/*Node of PST*/
class ProofNode{
	PChunk!(GTerm) base;
	Question[] questions;
	ProofNode left = null;
	int branch_count = 0;
	int oldquestions_size = 0;
	int curr_question=-1;
	bool is_refuted = false;

	static d8 = 0;

	this(){
	
	}
	
	//bool is_refuted(){
	//	if(base.is_contains(GTerm.cr_false())){
	//		return true;
	//	} 
	//	return false;
	//}
	//Добавляем (создаём) новую базу и новые Questions
	this(PChunk!(GTerm) _base, Question[] _qs){
		base = _base;
		questions = _qs;
	}
	
	void link(ProofNode lnode){
		base.link(lnode.base);
		Question[] reflquestions = new Question[lnode.questions.length];
		//writeln(reflquestions.length);
		for(int i=0;i<reflquestions.length;i++){
			reflquestions[i] = new Question();
			//writeln("25");
			reflquestions[i].link(lnode.questions[i]);
			//writeln("25+"); 
		}
		questions = reflquestions~questions;
		oldquestions_size = reflquestions.length;
		left = lnode;
		left.branch_count++;
		curr_question = lnode.curr_question;
		
	}
	
	//т.е. добавилось ли что-то новое
	bool is_valid(){
		return true;
	}
	
	string to_string(string tab){
		string res=tab~"e"~base.to_string()~"\n";
		foreach(q;questions){
			res~=q.to_string(tab~"    ")~"\n";
		}
		return res;	
	}
	
	void print(){
		writeln(to_string(""));
	}

	/*Search subanswers for all question from proof node*/
	void search_subanswers(){
		//writeln("search...");
		//поиска для старых вопросов только по текущей базе узла
		for(int i=0;i<oldquestions_size;i++){
			PNode!(GTerm) curr = base.first;
			if(base.first is null) break;
			while(curr !is base.last.next){
				GTerm[] tempconj = questions[i].get_conjunct();
				foreach(j,qatom;tempconj){
					//writeln("matching");
					//qatom.print();
					//curr.value.print();
					//writeln("end matching");
					Answer ans  = qatom.matching(curr.value);
					//if(ans is null)writeln("ans is null"); else ans.print;
					if(ans !is null){
						ans.reset();
						questions[i].qd.add(ans,j);
					}
				}
				curr = curr.next;
			}
		}
		//поиск для новых вопросов для всей базы
		for(int i = oldquestions_size; i<questions.length;i++){
			PNode!(GTerm) curr = base.first;
			while(curr !is null){
				//для каждого атома конъюнкта вопроса
				foreach(j,qatom;questions[i].get_conjunct()){
					Answer ans  = qatom.matching(curr.value);
					if(ans !is null){
						ans.reset();
						questions[i].qd.add(ans,j);
					}
				}
				curr = curr.next;
			}			
		}
		//writeln("..end");
	}

	//ВЫБОР ВОПРОСА
	Question select_question(){
		curr_question++;
		if(curr_question==questions.length) curr_question=0;
		return questions[curr_question];
	}

	bool goal(){
		foreach(q;questions){
			if(q.is_goal()){
				Answer a = q.retrieve_answer();
				if(a !is null){
					writeln("====goal answer====");
					base.print();
					writeln("----------");
					q.print();
					//a.apply();
					a.print();
					writeln("====end goal answer====\n");
					return true;					
				}
			}
		}
		return false;
	}

	ProofNode[] answer_the_question(){
		is_refuted = false;
		
		//сразу проверяем целевые вопросы.
		if(goal()){
			is_refuted = true;
			return new ProofNode[0];
		}

		int k = questions.length;
		Question q;
		Answer a;
		while(k>0){
			q = select_question();
			//writeln("question selected");
			if(q is null) return null;
			a = q.retrieve_answer();
			//writeln("answer retrieved");
			if(a is null){
				k--;
			}else break;
		}
		if(k == 0) return null;

		writeln("====answer====");
		//writeln(base.get_size());
		base.print();
		writeln("----------");
		q.print();
		a.apply();
		//d8++;
		//if(d8%1000==0)writeln(d8);
		a.print();
		writeln("====end answer====\n");
		//-----------
		ProofNode[] pnl = new ProofNode[q.af.efs.length];
		//для каждой е-консеквента
		VarMap vm = new VarMap();
		vm.add_qvars(q.af.vars);
		foreach(i,ef;q.af.efs){
			EFormula newef = ef.get_hard_copy(vm);
			newef.reduce();
			PChunk!(GTerm) newbase  = newef.conjunct.to_pchunk(base);
			Question[] newqs = new Question[newef.afs.length];
			foreach(j,raf;newef.afs){
				newqs[j] = new Question(raf);
			}
			pnl[i] = new ProofNode(newbase, newqs);
		}
		
		//-----------
		a.reset();
		foreach(p;pnl){
			p.link(this);
			p.search_subanswers();
			foreach(q2;p.questions){
				q2.numerize_subanswers();
			}
		}
		return pnl;
	}	

}