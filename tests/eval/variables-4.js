/*
42
*/
function evalPrint(value) {
	eval("value *= 2");
	return value;
}

print(evalPrint(21));
