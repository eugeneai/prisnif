module answer;

import std.stdio;

import gterm;

/*================ ANSWER ================*/
class Answer{
	//Binding[] binds;
	Binding[GTerm] binds;
	bool is_applied;

	bool fict = false;
	
	this(){
		is_applied = false;
	}
	this(bool _fict){
		is_applied = false;
		fict = _fict;
	}	
	
	bool is_empty(){
		if(binds.length==0) return true; else return false;
	}

	void apply(){
		foreach(b;binds){
			b.apply();
		}
		is_applied = true;
	}
	
	//простой ресет. не ресетит НЭЭ. Применяется для ресета после шага вывода.
	void reset(){
		foreach(b;binds){
			b.reset();
		}	
		is_applied = false;
	}

	//полный ресет. вместе с НЭЭ. Применяется после неудачной попытки унификации.
	/*void reset_full(){
		foreach(b;binds){
			b.reset_full();
		}	
		is_applied = false;
	}*/	
	
	/*Добавить биндинг*/
	void add_binding(Binding b){
			binds[b.left] = b;
	}
	
	/*Прямое добавление другого ответа*/
	void add_answer(Answer _a){
		if(_a is null) return;
		foreach(b;_a.binds){
			binds[b.left] = b;
		}
	}
	
	
	bool is_twin(Answer a){
		if(binds.length!=a.binds.length)return false;
		foreach(b;binds){
			if(b.left in a.binds){
				if(!b.right.is_twin(a.binds[b.left].right))return false;
			}else return false;
		}
		
		return true;
	}
	
	/*
	Комбинирование двух ответов. В чем подвох?
	Например, ответ A1 = {x -> f(h1)} и A2 = {x -> h2}
	Если h1 и h2 это просто основные термы, то эти два ответа не комбинируются.
	Если h2 это НЭЭ, тогда правые части биндингов унифицируемы с новой подстановокой
	{h2 -> f(h1)}, которую нужно добавить к этой комбинации.
	Таким образом комбинирование подстановок требует проверки унифицируемости правых частей для
	одноименных левых.
	*/
	static Answer combine(Answer a1, Answer a2){
		if(a1 is null || a2 is null) return null;
		//writeln("combine:");
		//a1.print();
		//a2.print();
		//writeln("----------");
		/*
		Последовательно перебираем все биндинги из a2 и пытаемся их добавиить в a1.
		Если левая часть биндинга из a2 уже имеется в a1, то необходимо провести унификацию
		правых частей соответствующих биндингов. Если унификация успешна, до добавляем её к ответу,
		иначе комбинирование не возможно.
		Если левой части из a2 нет в a1, то просто добавляем её.
		*/
		Answer comboanswer = new Answer();
		comboanswer.binds = a1.binds;
		foreach(b2;a2.binds){
			if(b2.left in a1.binds){
				Answer subanswer = b2.right.matching(a1.binds[b2.left].right);
				if(subanswer is null){
					return null;
				}
				else {
					//subanswer.reset();
					if(a1.loop() || a2.loop()){
						subanswer.reset();
						return null;
					} 
					subanswer.reset();
					comboanswer.add_answer(subanswer);
				}
			}else{
				comboanswer.add_binding(b2);
			}
		}
		//comboanswer.print();
		comboanswer.apply();
		if(comboanswer.loop()){
			comboanswer.reset();
			return null;
		}
		comboanswer.reset();			
		return comboanswer;
	}

	bool loop(){
		foreach(b;binds){
			if(b.loop())return true;
		}
		return false;
	}

	/*
	Если в подстановке имеется биндинг типа h -> t, где h - НЭЭ, то
	подстановка корректна, если h ещё нигде не доопределился.
	Если h где-то доопределился, то такая подстановка некорректна.
	Однако её не надо удалять, ибо после возможных откатов в выводе (в ДСВ)
	h может вернуться на место.
	Данная функция проверяет является ли подстановка корректной.	
	*/
	/*bool is_hvalid(){
		foreach(b;binds){
			//если левая часть это НЭЭ
			if(b.left.is_uhe()){
				//если он УЖЕ подставлен, то false
				if(b.left.is_substed()){
					if(!b.left.is_twin(b.right)) return false;
				}
			}
		}
		return true;
	}*/
	
	string to_string(){
		string res="{";
		foreach(e;binds){
			res = res~e.to_string()~", ";
		}
		res~="}";
		return res;		
	}
	
	void print(){
		writeln(to_string());
	}
	
	
}

/*===============================================*/
/*For example, x->a or y->f(o1,g(k))...*/
class Binding{
	GTerm left;
	GTerm right;

	bool is_applied;
	
	this(GTerm _left, GTerm _right){
		left = _left;
		right = _right;
		is_applied = false;
	}
	
	bool is_twin(Binding b){
		if(left.is_twin_names(b.left) && right.is_twin(b.right))return true; else return false;
	}
	
	/*Apply this binding*/
	void apply(){
		left.sub_zero(right);
		is_applied = true;
	}
	
	/*reset*/
	void reset(){
		if(left.is_var())
			left.sub_zero(null);
		is_applied = false;
	}

	/*полный reset вместе с НЭЭ*/
	/*void reset_full(){
		left.sub_zero(null);
		if(left.is_uhe()){
			if(left.args[1] !is null)left.args[1].rem_conc(right);
		}
		is_applied = false;
	}*/

	bool loop(){
		if(right.is_contains(left)){
			return true; 
		}else return false;
	}
	
	string to_string(){
		string s;
		s = left.name_to_string()~" -> "~right.to_string();
		return s;
	}
	
	void print(){
		writeln(to_string());
	}
}