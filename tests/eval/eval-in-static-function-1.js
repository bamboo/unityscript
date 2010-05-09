/*
42
*/
static function foo(arg : int) {
	var local : int = 0;
	eval("arg = 12;");
	eval("local = 30;");
	return arg + local;
}

print(foo(-1));
	
	
