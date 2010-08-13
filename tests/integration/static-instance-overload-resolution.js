/*
static
instance
*/
class Foo {
	static function Bar(value) {
		print("static");
	}
	
	function Bar() {
		print("instance");
	}
}

Foo.Bar(42);
new Foo().Bar();
