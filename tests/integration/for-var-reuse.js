/*
FOO
BAR
after: bar
*/
#pragma strict

function test() {
	var array: Array = new Array("foo", "bar");
	var s: String;
	for (s in array)
		print(s.ToUpper());
	print("after: " + s);
}

test();
