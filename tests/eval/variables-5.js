/*
42
*/
function evalPrint() {
	var value = 21;
	eval("value *= 2");
	return value;
}

print(evalPrint());
