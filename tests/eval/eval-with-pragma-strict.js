/*
foo
*/
#pragma strict
function evalPrint() {
	var value = "foo";	
	return eval("value");
}

print(evalPrint());