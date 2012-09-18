module pchunk;

import std.stdio;
import std.string;
import std.conv;

/*========================================*/
/*================ PNode =================*/
/*========================================*/
class PNode(T){
	T value;
	PNode!(T) next;
	int number = -1;// вообще с 0 нумерация начинается
	
	this(T _value, PNode _next){
		value = _value;
		next = _next;
	}
	
	/*взять n-ый узел. нумерация начинается от 0*/
	PNode!(T) getn(int n){
		if (n==0) return this;
		if(next is null && n>0) return null;
		return next.getn(n-1);
	}
	
	bool is_contains(T _value){
		if(value.is_twin(_value)){
			return true;
		}else{
			if(next is null) return false;
			next.is_contains(_value);
		}
		return false;
	}		
}

/*========================================*/
/*================ PCHUNK ================*/
/*========================================*/
class PChunk(T){
	PNode!(T) first;// first element of chunk
	PNode!(T) last;// last element of chunk
	int size = 0;

	this(PNode!(T) _first, int _size){
		size = _size;
		first = _first;
		last = first.getn(size-1);	
	}
	
	/*dummy shunk*/
	this(){
		size = 0;
		first = null;
		last = null;
	}
	
	bool is_dummy(){
		if(size==0) return true; else return false;
	}

	int get_size(){
		if(first !is null) return first.number;
		return 0;
	}
	
	//линковка.
	void link(PChunk!(T) _c){
		//writeln("point: PChunk: link: [start]");
		//if(_c is null) writeln("c is null");
		if(is_dummy()){
			//writeln("dummy");
			last = _c.first;
			first = last;
		}else {
			//writeln("not dummy");
			last.next = _c.first;
		}
		
		int lnumber;// = _c.first.number;
		if(_c.first is null){
			lnumber = 0;
		}else lnumber = _c.first.number;
		//writeln("lnumber: ",lnumber); 
		//writeln("size: ",size);
		int rsize = size;
		
		int k = lnumber+rsize;
		//writeln("k: ",k,"; lnumber: ",lnumber);
		PNode!(T) curr = first;
		while(k>lnumber){
			curr.number = k;
			//writeln("curr.number: ",curr.number);
			k--;
			curr = curr.next;
		}
		
	}
	
		
	// as first
	bool add(T e){
		if(first is null){
			first = new PNode!(T)(e,null);
			last = first;
			first.number = 0;
		}else{
			if(is_contains(e)){
				return false;
			}
			PNode!(T) pn = new PNode!(T)(e,first);
			first = pn;
			pn.number = pn.next.number+1;
		}
		size++;
		return true;
	}
	
	bool is_contains(T e){
		PNode!(T) curr = first;
		while(curr !is null){
			if(curr.value.is_twin(e)){
				return true;
			}
			curr = curr.next;
		}
		return false;
	}
	
	T getn(int n){
		return first.getn(n).value;
	}
	
	void numerize(){
		if(first is null) return;
		if(first.number > -1) return;
		PNode!(T) curr = first;
		int k = size-1;
		while(k>-1){
			curr.number = k;
			k--;
			curr = curr.next;
		}
	}
	
	T get_by_number(int n){
		//if(first is null) return null;
		PNode!(T) curr = first; 
		while(curr !is null){
			if(curr.number == n) return curr.value;
			curr = curr.next;
		}
		return null;
	}
	
	string to_string(){
		string res="[";
		PNode!(T) curr = first;
		while(curr !is null){
			res~=curr.value.to_string()~to!string(curr.number)~",";
			curr = curr.next;
		} 
		res~="]";
		return res;
	}
	
	void print(){
		writeln(to_string());
	}
}