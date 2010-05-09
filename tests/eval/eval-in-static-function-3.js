/*
42
*/
static function foo() {
	// static variables should be visible
	eval("print(a)");
}

static var a = 42;
foo();
