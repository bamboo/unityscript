import System;

class Foo {
	public var counter = 0;
	final function Bar() { ++counter; }
}

class VirtualFoo {
	public var counter = 0;
	function Bar() { ++counter; }
}

class VirtualFoo2 extends VirtualFoo {
	override function Bar() {}
}

function time(kind, block: function()) {
	var calls = 100000000;
	var start = DateTime.Now;
	for (var i=0; i<calls; ++i)
		block();
	var elapsed = DateTime.Now - start;
	print(calls + " "  + kind + " in " + elapsed.TotalMilliseconds + "ms.");
}

var foo = new Foo();
var virtualFoo = new VirtualFoo();

for (var i = 0; i < 3; ++i) {
	time("non virtual calls", function() { foo.Bar(); });
	time("virtual calls", function() { virtualFoo.Bar(); });
}

