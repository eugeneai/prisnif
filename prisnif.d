module prisnif;

import std.stdio;
import std.variant;
import std.conv;
import std.bitmanip;
import std.file;
import std.string;
import std.datetime;

import parserhu;
import supervisor;

class Prover{
	this(){
	
	}
	
	void start(string pathfile, int n){
		ParserHu ph = new ParserHu();
		Supervisor sv = new Supervisor(ph.parseFromFile(pathfile),n);

		auto t1 = Clock.currStdTime();;
		
		sv.start();
		
		auto t2 = Clock.currStdTime();;
		auto dt = (t2-t1);
		writeln(".........................");
		//writeln(t1);
		//writeln(Clock.currTime.stdTime());
		writeln("Time: ",dt/10000000.0,"s.");		
		writeln("================================");
	}

	//Адекватный размер формулы, без равенств, без неограниченных переменных
	void uncoTest(){
		foreach (string name; dirEntries("/home/ale/Dropbox/TPTP/", SpanMode.breadth)) { 
			auto size = getSize(name);
			//Размер от 20 байт до 1000 000 байт
			if((size>20) && size<1000000){			
				string s = readText(name);
				if(indexOf(s,'=')<0){
					//writeln(name);
					ParserHu ph = new ParserHu();
					ph.parseFromFile(name);
					if(!ph.unco()) writeln(name);
					//writeln(name, ": Ok.");
				}
			}
		}
	}

	void copyx(){
		foreach (string name; dirEntries("/home/ale/Dropbox/TPTP/", SpanMode.breadth)) { 
			//string s = readText(name);
			auto size = getSize(name);
			if((size>20) && size<100000){
				writeln(name,": ",size);
				//copy(name,"../tasks.out/BIG/"~name);
			} 
		}
	}

	//адекватный размер, без равенств. Возможны неограниченные перменные
	void select(){
		foreach (string name; dirEntries("/home/ale/Dropbox/TPTP/", SpanMode.breadth)) { 
			auto size = getSize(name);
			//Размер от 20 байт до 
			if((size>20) && size<1000000){
				string s = readText(name);
				//без равенства
				if(indexOf(s,'=')<0){
					//ParserHu ph = new ParserHu();
					//ph.parseFromFile(name);
					//if(!ph.unco()) writeln(name, ": Ok.");
					writeln(name);
				}
			} 			
		}
	}
	
}


/*================ MAIN ================*/
void main(string args[]){
	Prover p = new Prover();
	if (args[1]=="u"){
		p.uncoTest();
	}else if(args[1]=="c"){
		p.copyx();
	} else if(args[1]=="s"){
		p.select();
	}else{
		p.start(args[1],to!int(args[2]));
	}

}