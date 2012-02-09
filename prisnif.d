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
	
}


/*================ MAIN ================*/
void main(string args[]){
	Prover p = new Prover();				
	p.start(args[1],to!int(args[2]));

}