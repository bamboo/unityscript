/*
42
42
*/
function getAssemblyCount() {
	return System.AppDomain.CurrentDomain.GetAssemblies().Length;
}

function assertEquals(expected, actual) {
	if (expected == actual) return;
	throw new System.ApplicationException("" + expected + " != " + actual);
}

function doEval(code) {
	eval(code);
}

function main() {
	var code = "print(42);";
	
	doEval(code);
	
	var assemblies = getAssemblyCount();
	
	doEval(code);
	
	// original assembly should be cached and reused
	assertEquals(assemblies, getAssemblyCount());
}

main();
