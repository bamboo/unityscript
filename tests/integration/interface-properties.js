/*
foo
bar
*/
interface I {
	function get message(): String;
}

class Foo implements I {
	function get message() { return "foo"; }
}

class Bar implements I {
	function get message() { return "bar"; }
}

function doIt(i: I) {
	print(i.message);
}

doIt(new Foo());
doIt(new Bar());
