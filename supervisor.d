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


/*------------------------------------------------*/
class Supervisor{

	ProofNode[] leafs;
	int maxsteps = 100;
	
	int refuted_base_count=0;
		
	this(ProofNode[] _leafs, int n){
		leafs = _leafs;
		foreach(l;leafs){
			l.search_subanswers();
			foreach(q;l.questions){
				q.numerize_subanswers();
				//q.numerize_answers();
			}
		}
		maxsteps = n;
	}
	
	void print(){
		foreach(pn;leafs){
			pn.print();
		}
	}
	
	
	//-----------------------START------------------------
	void start(){
		print();
		int k = maxsteps;
		bool b = true;
		while(!is_all_refuted() && k>0){
			//writeln("========== Step ",maxsteps-k+1, " ==========");
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
	}

	//step of inference
	bool step(){
		ProofNode[] newleafs = leafs[0].answer_the_question(); 
		//if(newleafs is null && leafs[0].is_refuted==false) return false;
		if(leafs[0].is_refuted==true) refuted_base_count++;
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
}