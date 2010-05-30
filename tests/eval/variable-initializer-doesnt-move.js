/*
foo
bar
a: baz
*/
function foo() { print("foo"); }
function bar() { print("bar"); return "baz"; }

eval(
	"foo();"
	+ "var a = bar();"
	+ "print(\"a: \" + a);");
