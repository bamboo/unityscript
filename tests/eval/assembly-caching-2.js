/*
3
Hello world!
3
Hello world!
*/

function getAssemblyCount() {
	return System.AppDomain.CurrentDomain.GetAssemblies().Length;
}

function assertEquals(expected, actual) {
	if (expected == actual) return;
	throw new System.ApplicationException("" + expected + " != " + actual);
}

function foo(code) {
	var a = 3;
	eval(code);
}

function bar(code) {
	var a = "Hello world!";
	eval(code);
}

function main() {
	var code = "print(a);";
	foo(code);
	bar(code);
	
	var assemblies = getAssemblyCount();
	foo(code);
	bar(code);
	assertEquals(assemblies, getAssemblyCount());
}

main();
