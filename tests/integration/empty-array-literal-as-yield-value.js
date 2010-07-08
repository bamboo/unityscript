/*
System.String[]
*/
function foo(): System.Collections.Generic.IEnumerable.<String[]> {
	yield [];
}

for (var f in foo())
	print(f.GetType());
