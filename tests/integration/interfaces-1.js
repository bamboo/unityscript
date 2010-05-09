/*
foo
bar
*/
interface I {
	function f();
}

class Foo implements I { function f() { print("foo"); } }
class Bar implements I { function f() { print("bar"); } }

function doIt(i: I) {
	i.f();
}

doIt(new Foo());
doIt(new Bar());
