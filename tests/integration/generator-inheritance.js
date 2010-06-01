/*
0
zomg!
zomg!
2
Hey!
*/
class Foo {
    function Bar() { yield 0; }
}

class Foo2 extends Foo{
    function Bar() { print("zomg!"); }
}

class Foo3 extends Foo {
    function Bar() { yield 2; print("Hey!"); }
}

function printAll(items) {
	for (var i in items) print(i);
}

printAll(new Foo().Bar());

if (new Foo2().Bar() == null)
	print("empty generator shouldn't return null");

printAll(new Foo2().Bar());

printAll(new Foo3().Bar());
