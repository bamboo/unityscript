/*
42
ltu
null
ae
null
42
*/

var a = new Array(42, "ltu", null, "ae", null, 42);
for (var i in a)
	print(i == null ? "null" : i);
