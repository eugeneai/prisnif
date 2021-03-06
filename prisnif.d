module prisnif;

import std.stdio;
import std.variant;
import std.conv;
import std.bitmanip;
import std.file;
import std.string;
import std.datetime;
import std.random;

import parserhu;
import supervisor;
import qformulas;
import symbol;

class Prover{
	this(){

	}

  int start(string pathfile, ulong n, string flag, SymbolTable st = null){
		ParserHu ph = new ParserHu(st);

		Supervisor sv = new Supervisor(ph.parseFromFile(pathfile),n);
		writeln(ph.baseconj);
		auto t1 = Clock.currStdTime();

		int res = 0;
		if(flag=="q") res = sv.start();
		if(flag=="w") res = sv.start2();

		auto t2 = Clock.currStdTime();;
		auto dt = (t2-t1);
		writeln(".........................");
		//writeln(t1);
		//writeln(Clock.currTime.stdTime());
		writeln("Time: ",dt/10000000.0,"s.");
		writeln("================================");

		return res;
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
		///home/ale/bench/prover/tasks.out/BIG
		foreach (string name; dirEntries("/home/ale/bench/prover/tasks.out/all/", SpanMode.breadth)) {
			auto size = getSize(name);
			//Размер от 20 байт до
			if((size>20 && size<500000) && indexOf(name,'-')>0){
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




	void parseappendix(string pathfile){
		string s = readText(pathfile);
		string[] slist = splitLines(s);
		foreach(s1;slist){
			if(indexOf(s1,';')>0 && indexOf(s1,'~')<0){
				string name="";
				string step="";
				string time="";
				string rating="";

				name = s1[0..indexOf(s1,';')];
				string res1 = s1[indexOf(s1,';')+1..$];

				step = res1[0..indexOf(res1,',')];
				res1 = res1[indexOf(res1,',')+1..$];

				time = res1[0..indexOf(res1,';')];
				res1 = res1[indexOf(res1,';')+1..$];

				rating = res1;

				writeln(name, " & ",rating, " & ", time, " & ", step," \\\\\n\\hline");
			}
		}
	}

	void statvar(){


		foreach (string name; dirEntries("../fof/", SpanMode.breadth)) {
			//if(name[0]=='.')continue;
			//writeln("start statvar");
			auto size = getSize(name);
			//Размер от 20 байт до 1000 000 байт
			if((size>20) && size<100000000 && name!="../fof/.DS_Store" ){
				//writeln(name);
				string s = readText(name);
				if(indexOf(s,'=')>=0){
					continue;
				}

				//if(indexOf(s,'=')<0){
					//writeln(name);
					ParserHu ph = new ParserHu();
					ph.parseFromFile(name);
					if(ph.getGt10()){
						writeln(name);
						writeln(ph.gt10);
					}

					//if(!ph.unco()) writeln(name);
					//writeln(name, ": Ok.");
				//}
			}
		}
	}


	void statvar2(){
		foreach (string name; dirEntries("../fof/", SpanMode.breadth)) {
			auto size = getSize(name);
			//Размер от 20 байт до 1000 000 байт
			if((size>10000) && size<100000000 && name!="../fof/.DS_Store" ){
				//writeln(name);


				string s = readText(name);
				if(indexOf(s,'=')>=0){
					continue;
				}
					ParserHu ph = new ParserHu();
					ph.parseFromFile(name);
					writeln(name);
					writeln(Conjunct.asize);
					writeln(Conjunct.esize);
					Conjunct.asize = 0;
					Conjunct.esize = 0;
					//if(ph.getGt10()){
					//	writeln(name);
					//	writeln(ph.gt10);
					//}
			}
		}
	}

	void statSize(){
		long avgsize;
		int k;
		int gt100k = 0;
		foreach (string name; dirEntries("../fof/", SpanMode.breadth)) {

			if(name=="../fof/.DS_Store"){
				continue;
			}
			//writeln(name);
			string s = readText(name);

			if(indexOf(s,'=')>=0){
				continue;
			}
			auto size = getSize(name);
			if(size>20 && size<100000){
				avgsize+=size;
				k++;
				if(size > 100000){
					gt100k++;
					writeln(name);
				}
				if(size > 10000){
					writeln(name);
				}
			}
		}
		avgsize/=k;
		writeln("Stat: ",avgsize,"; ",k,"; ",gt100k);
	}

}
