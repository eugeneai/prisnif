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
		//поиска для старых вопросов только по текущей базе узла
		for(int i=0;i<oldquestions_size;i++){
			PNode!(GTerm) curr = base.first;
			if(base.first is null) break;
			while(curr !is base.last.next){
				GTerm[] tempconj = questions[i].get_conjunct();
				foreach(j,qatom;tempconj){
					Answer ans  = qatom.matching(curr.value);
					if(ans !is null){
						ans.reset();
						questions[i].qd.add(ans,j);
						//questions[i].qd.overflow = false;
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
	}

	//ВЫБОР ВОПРОСА
	Question select_question(){
		curr_question++;
		if(curr_question==questions.length) curr_question=0;
		return questions[curr_question];
	}


	ProofNode[] answer_the_question(){
		is_refuted = false;
		
		int k = questions.length;
		Question q;
		Answer a;
		while(k>0){
			q = select_question();
			if(q is null) return null;
			a = q.retrieve_answer();
			if(a is null){
				k--;
			}else break;
		}
		if(k == 0) return null;

		if(q.is_goal()){
			is_refuted = true;
			return new ProofNode[0];
		}
	
		a.apply();
		//a.print();
		//-----------
		ProofNode[] pnl = new ProofNode[q.af.efs.length];
		//для каждой е-консеквента
		foreach(i,ef;q.af.efs){
			EFormula newef = ef.get_hard_copy(new VarMap());
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