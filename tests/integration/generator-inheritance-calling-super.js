/*
B: foo
B: bar
*/
class A {
	function Foo() {
		yield "foo";
		yield "bar";
	}
}

class B extends A {
	function Foo() {
		for (var item in super.Foo()) {
			yield "B: " + item;
		}
	}
}

for (var item in new B().Foo()) {
	print(item);
}
		
