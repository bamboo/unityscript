/*
Base.foo
Derived.foo
*/
class Base {
	function foo() { print("Base.foo"); }
}

class Derived extends Base {
	override function foo() {
		super.foo();
		print("Derived.foo");
	}
}

var b:Base = new Derived();
b.foo();
