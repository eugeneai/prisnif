module parserhu;

import std.stdio;
import std.file;
import std.string;

import symbol;
import gterm;
import misc;
import qformulas;
import question;
import answer;
import proofnode;
import pchunk;

//распознавание чисел как чисел надо сделать

/*==========================================*/
class ParserHu{
	string orig;
	
	SymbolTable st;
	
	bool uncoflag = false;
	bool unco(){
		return uncoflag;
	}


	this(){
		st = new SymbolTable();
	}
	
	
	//последовательность термов без скобок
	GTerm[] parseGTermSeq(string tseqstr, VarList vl, int glub){
		GTerm[] gtseq;
		if(tseqstr=="")return gtseq;
		int x,y;
		
		int l=0;
		int r=0;
		for(int i=0;i<tseqstr.length;i++){
			if(l==r && tseqstr[i]==','){
				gtseq~=[parseGTerm(tseqstr[x..i],vl, glub)];
				i++;
				x=i;
				continue;
			}
			if(tseqstr[i]=='(')l++;			
			if(tseqstr[i]==')')r++;
		}
		gtseq~=[parseGTerm(tseqstr[x..$],vl, glub)];
		
		return gtseq;
	}
	
	GTerm parseGTerm(string tstr, VarList vl, int glub){
		int x = findSymbol(tstr, '(');
		//если скобок нет, значит это или переменная или константа
		if(x== -1){
			GTerm t = vl.getVar(tstr);
			//если это не переменная, то это константа
			if(t is null){
				
				//если False, то это атом
				if(tstr=="False"){
					//sn.add(0,"False");
					return GTerm.cr_false();//(new Symbol(SymbolType.ATOM,"False",0));
				}
				//sn.add(nt.getName(tstr),tstr);
				Symbol s8 = st.addget_symbol(new Symbol(SymbolType.CONSTANT,tstr,0));
				return new GTerm(s8);
				//return new GTerm(new Symbol(SymbolType.CONSTANT,nt.getName(tstr),0));
			}
			//иначе переменная
			else{
				//writeln("распознана переменная");
				//sn.add(t.name,tstr);
				return t;
			}
		}
		//иначе если скобка есть
		else{
			GTerm[] args = parseGTermSeq(tstr[x+1..$-1],vl,glub+1);
			GTerm t;
			if(glub>0){
				//Symbol s4 = new Symbol(SymbolType.FUNCTION,nt.getName(tstr[0..x]),args.length);
				Symbol s8 = st.addget_symbol(new Symbol(SymbolType.FUNCTION,tstr[0..x],args.length)); 
				t = new GTerm(s8);
			}
			else{//иначе это атом
				//Symbol s4 = new Symbol(SymbolType.ATOM,nt.getName(tstr[0..x]),args.length);			
				Symbol s8 = st.addget_symbol(new Symbol(SymbolType.ATOM,tstr[0..x],args.length)); 				
				t = new GTerm(s8);
				//if(tstr[0..x]=="Print"){
				//	t.nature=GTermNature.print;
				//}
				//writeln(s8.name);
			}
			//writeln();
			//t.print();
			foreach(i,a;args){
				t.set_arg(args[i],i);
			}
			t.args = args;
			//sn.add(nt.getName(tstr[0..x]),tstr[0..x]);
			return t;
			
		}
		return null;
	}
	
	//да тоже самое что и парссек, только глуб изначально 0
	Conjunct parseConjunct(string constr, VarList vl){
		GTerm[] tseq = parseGTermSeq(constr,vl,0);
		
		return new Conjunct(tseq);
	}
	
	PChunk!(GTerm) parseBaseConjunct(string constr, VarList vl){
		GTerm[] tseq = parseGTermSeq(constr,vl,0);
		Conjunct con8 = new Conjunct(tseq);
		return con8.to_pchunk();		
	}
	
	QVars parseQVars(string varsstr, VarList vl, bool isEVar){
		QVars vars = new QVars();
		SymbolType gtt;
		if(isEVar)gtt=SymbolType.EVARIABLE; else gtt=SymbolType.AVARIABLE;		
		string[] astr = split(varsstr,",");
		foreach(a;astr){
			vl.addStrVar(a,gtt);
			vars.add_var(vl.getVar(a));
		}
		return vars;
	}
	
	Question parse_Question(string qfstr, VarList vl){
		AFormula af = parse_AFormula(qfstr,vl);
		Question qf = new Question(af);
		
		return qf;
	}
	
	ProofNode parse_BaseFormula(string efstr, VarList vl){
		//writeln("f: ",efstr);
		ProofNode bf = new ProofNode();
		int left = findSymbol(efstr,'[');
		int right = left+getNextSkobka(efstr[left..$],'[');
		//writeln(left," ",right);
		//bf.vars = parseQVars(efstr[left+1..right], vl, true);
		string efstr2 = efstr[right+1..$];
		
		left = findSymbol(efstr2,'[');
		right = left+getNextSkobka(efstr2[left..$],'[');		
		
		bf.base = parseBaseConjunct(efstr2[left+1..right], vl);
		bf.base.numerize();
		string efstr3 = efstr2[right+1..$];
		
		left = findSymbol(efstr3,'{');
		right = left+getNextSkobka(efstr3[left..$],'{');
		
		bf.questions = parse_Questions(efstr3[left..right+1], vl);///!!!
		
		bf.oldquestions_size = bf.questions.length;
		return bf;
	}
	
	ProofNode[] parse_BaseList(string str, VarList vl){
		if(str=="")return null;
		string efs_str[] = splitFList(str[1..$-1]);
		ProofNode efs[] = new ProofNode[efs_str.length];
		foreach(i,e;efs_str){
			//writeln("start");
			efs[i] = parse_BaseFormula(e, vl.get_fuzzy_copy());
			//writeln("finish");
		}
		return efs;
	}
	
	Question[] parse_Questions(string str, VarList vl){
		if(str=="{}")return null;
		string afs_str[] = splitFList(str[1..$-1]);
		Question afs[] = new Question[afs_str.length];
		foreach(i,a;afs_str){
			afs[i] = parse_Question(a, vl.get_fuzzy_copy());
		}
		return afs;
	}
	
	//a[][]{}
	AFormula parse_AFormula(string afstr, VarList vl){
		//writeln(afstr);
		AFormula af = new AFormula();
		int left = findSymbol(afstr,'[');
		int right = left+getNextSkobka(afstr[left..$],'[');
		
		af.vars = parseQVars(afstr[left+1..right], vl, false);
		string afstr2 = afstr[right+1..$];
		
		left = findSymbol(afstr2,'[');
		right = left+getNextSkobka(afstr2[left..$],'[');		
		
		af.conjunct = parseConjunct(afstr2[left+1..right], vl);
		string afstr3 = afstr2[right+1..$];

		left = findSymbol(afstr3,'{');
		right = left+getNextSkobka(afstr3[left..$],'{');
		
		af.efs = parse_EFList(afstr3[left..right+1],vl);//!!!
		
		bool flag8 = false;
		flag8 = af.set_unconfined_vars();//устанавливаем открытые переменные
		if(flag8) uncoflag = true; 
		af.set_is_goal();//целевой ли это вопрос
		//af.addEmptyAnswer();
		
		return af;
	}
	
	//e[][]{}
	EFormula parse_EFormula(string efstr, VarList vl){
		//writeln("f: ",efstr);
		EFormula ef = new EFormula();
		int left = findSymbol(efstr,'[');
		int right = left+getNextSkobka(efstr[left..$],'[');
		//writeln(left," ",right);
		ef.vars = parseQVars(efstr[left+1..right], vl, true);
		string efstr2 = efstr[right+1..$];
		
		left = findSymbol(efstr2,'[');
		right = left+getNextSkobka(efstr2[left..$],'[');		
		
		ef.conjunct = parseConjunct(efstr2[left+1..right], vl);
		string efstr3 = efstr2[right+1..$];
		
		left = findSymbol(efstr3,'{');
		right = left+getNextSkobka(efstr3[left..$],'{');
		
		ef.afs = parse_AFList(efstr3[left..right+1], vl);///!!!
		
		return ef;
	}
	
	AFormula[] parse_AFList(string str, VarList vl){
		if(str=="{}")return null;
		string afs_str[] = splitFList(str[1..$-1]);
		AFormula afs[] = new AFormula[afs_str.length];
		foreach(i,a;afs_str){
			afs[i] = parse_AFormula(a, vl.get_fuzzy_copy());
		}
		return afs;
	}
	
	//распарсить е-формулы
	EFormula[] parse_EFList(string str, VarList vl){
		if(str=="")return null;
		string efs_str[] = splitFList(str[1..$-1]);
		EFormula efs[] = new EFormula[efs_str.length];
		foreach(i,e;efs_str){
			efs[i] = parse_EFormula(e, vl.get_fuzzy_copy());
		}
		return efs;
	}
	
	//список str идет со скобками 
	string[] splitFList(string str){
		string s[];
		//writeln("***********\n",str);
		int left = findSymbol(str,'{');//ищем первую открывающуюся фигурную скобку
		//writeln(left);
		int right = getNextSkobka(str[left..$],'{');
		//writeln(left," ", right);
		
		if(left+right == str.length-1)s = [str[0..left+right+1]];else
		s~=[str[0..left+right+1]]~splitFList(str[left+right+2..$]);
		
		return s;
	}
	
	int findSymbol(string str, char s){
		for(int i=0;i<str.length;i++){
			if(str[i]==s)return i;
		}
		return -1;
	}
	
	string delSpaces(string str){
		bool flag=true;
		int i=0;
		while(flag){
			if(i==str.length)break;
			if(str[i]==' ' || str[i]=='\n'){
				str = str[0..i]~str[i+1..$];
				continue;
			}
			i++;
		}
		return str;
	}
	
	//предполагается, что первый символ -это открывающаяся скобка left_skobka
	int getNextSkobka(string str, char left_skobka){
		if(str[0]!=left_skobka)return -2;
		char right_skobka;
		if(left_skobka=='(')right_skobka=')';
		if(left_skobka=='[')right_skobka=']';
		if(left_skobka=='{')right_skobka='}';
		
		int left_count=0;
		int right_count=0;
		for(int i=0;i<str.length;i++){
			if(str[i]==left_skobka)left_count++;
			if(str[i]==right_skobka)right_count++;
			if(left_count==right_count)return i;
		}
		
		return -1;
	}
	
	//вытянуть все a-переменные
	void createTotalAVarsList(){
		
	}
	
	//распарсить строкове представление формулы
	ProofNode[] parsePCF(string pcfstr){
		//writeln("start parsePCF");
		//формат
		//{e[][]{..;..;..};...}. False
		orig = pcfstr;
		pcfstr = delSpaces(pcfstr);
		
		VarList vl = new VarList();
		ProofNode[] ef = parse_BaseList(pcfstr, vl);// !!!
		//EFormula[] efs = parseEFList(pcfstr,vl);
		
		//ProofNode pcf = new ProofNode();
		//pcf.bases = ef;
		//gsn = sn;
		return ef;
	}

	ProofNode[] parseFromFile(string pathfile){
		string s = readText(pathfile);
		return parsePCF(s);
	}	
}