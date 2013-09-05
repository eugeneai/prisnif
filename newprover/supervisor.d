module supervisor;
import std.stdio;
import gterm;
import question;
import qformulas;
import misc;
import pchunk;
import proofnode;
import symbol;
import answer;
import std.array;


/*------------------------------------------------*/
class Supervisor{

	ProofNode[] leafs;
	ulong maxsteps = 100;
	
	ulong refuted_base_count=0;
	
	//Answer[] answersstack;

	this(ProofNode[] _leafs, ulong n){
		leafs = _leafs;
		foreach(l;leafs){
			l.glub = 0;
			l.search_subanswers();
			foreach(q;l.questions){
				q.numerize_subanswers();
				//q.numerize_answers();
			}
		}
		maxsteps = n;
	}

	this(ulong n){
		maxsteps = n;
	}
	
	void print(){
		foreach(pn;leafs){
			pn.print();
			pn.printstat();
		}
		writeln("AConjunct: ",Conjunct.asize);
		writeln("EConjunct: ",Conjunct.esize);
	}
	
	
	//-----------------------START------------------------
	void start(){
		//writeln("После экзистенциальной переменной ставится :e, например X:e. Все НЭЭ обозначаются как hN.");
		//writeln("На каждом шаге выводится: номер шага; база; вопрос; ответ. В самом начале выводится вся формула.\n");
		writeln("================FORMULA================\n");
		//print();
		ulong k = maxsteps;
		bool b = true;
		while(!is_all_refuted() && k>0){
			writeln("Количество баз: ",leafs.length);
			writeln("==================== Step ",maxsteps-k+1, " ====================");
			b = step();
			if(!b){
				writeln("The formula is satisfiable.");
				break;
			}
			if(!is_all_refuted){
				//print();
			}else{
				writeln("FORMULA IS REFUTED!");
				break;	
			}
			//writeln("==================================");
			k--;
		}
		writeln("================================");
		if(k>0 && b){
			writeln("FORMULA IS REFUTED: ",maxsteps-k+1," steps." );
			writeln(refuted_base_count," bases are refuted.");
		}else{
			writeln("FAIL! ",maxsteps-k+1," steps.");
			writeln("Bases: ",leafs.length);
		}
		writeln("AConjunct: ",Conjunct.asize);
		writeln("EConjunct: ",Conjunct.esize);
		writeln("Matching: ",GTerm.matchingsize);
		writeln("Matchingtime: ",ProofNode.matchingtime/10000000.0,"s.");
		writeln("Avgmatchigtime: ",ProofNode.matchingtime/(10000000.0*GTerm.matchingsize));		
		writeln("gt10: ",Answer.gt10);
	}

	//step of inference
	bool step(){
		ProofNode[] newleafs = leafs[0].answer_the_question(); 
		if(newleafs is null && leafs[0].is_refuted==false) return false;
		if(leafs[0].is_refuted==true) refuted_base_count++;
		//answersstack.put(leafs[0].answer);
		leafs = newleafs~leafs[1..$];
		return true;
	}
	
	//--------------------------------
	bool is_all_refuted(){
		if(leafs.length==0) return true; else return false;
	}

	//---------------------------------
	void analize(){


	}
	//==============================================================================================
	//==============================================================================================

	//удаление фиктивных связок кванторов
	/*void reductio(){
		foreach(l;leafs){
			l.reductio();
		}
	}*/


	static ulong sc = 0;

	enum Glubstate {Deadlock, Maxglub, Order, Ok};

	void start2(){
		//reductio();

		//print();

		ulong rc = 0;
		foreach(l;leafs){
			//writeln("aa");
			Glubstate b  = glub(maxsteps,l);
			//writeln("bb");
			if(b == Glubstate.Ok) rc++;
		}
		
		//writeln("rc: ", rc);
		if(rc == leafs.length){
			writeln("==========ok==========");
		}else{
			writeln("==========fail==========");
		}
		writeln("sc: ",sc);
		writeln("rc: ",rc);
		writeln("Опровергнуто баз: ", refuted_base_count);
		writeln("AConjunct: ",Conjunct.asize);
		writeln("EConjunct: ",Conjunct.esize);
		writeln("Matching: ",GTerm.matchingsize);
		writeln("Matchingtime: ",ProofNode.matchingtime/10000000.0, "s.");		
		writeln("gt10: ",Answer.gt10);
	}

	
	//k - Глубина вывода
	Glubstate glub(ulong k, ProofNode pn){
		//writeln("start glub");
		writeln(sc);
		sc++;
		//writeln("Глубина", maxsteps-k);
		//если достигнута предельная глубина то неудача
		if(k == 0){
			//writeln("Достигнута максимальная глубина");
			return Glubstate.Maxglub;
		}
		//пробуем ответить на узел
		ProofNode[] newleafs = pn.answer_the_question(); 
		//если тупик то неудача
		if(newleafs is null && !pn.is_refuted) return Glubstate.Deadlock;
		//если опровергнут то успех
		if(pn.is_refuted){
			//writeln("Опровергнута база. Глубина: ",maxsteps-k);
			refuted_base_count++;
			return Glubstate.Ok;
		}
		//print();
		//каждого узла запускаем снова глуб
		foreach(l;newleafs){
			Glubstate b = glub(k-1,l);
			if(b == Glubstate.Order) {
				l.apanswer.reset_full();
				return glub(k-1,l);
			}
			if(b == Glubstate.Maxglub){
				return Glubstate.Order;
			} 
			if(b == Glubstate.Deadlock) return Glubstate.Order;
			//if(b == Glubstate.Ok) retun Glubstate.Ok;
		}
		return Glubstate.Ok; 
	}
}