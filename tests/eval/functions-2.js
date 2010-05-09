/*
The value is: 42
The value is: 21
*/
function callFunction(functionCode : String) {
	
	// when a eval depends on another eval call
	// it shoulnd't be cached
	
	eval(functionCode);	 
	eval("print(\"The value is: \" + f(21));");
}

callFunction("function f(i : int) { return i*2; }");
callFunction("function f(o) { return o.ToString(); }");
