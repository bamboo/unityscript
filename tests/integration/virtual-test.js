/*
Test1 5
Test2 5
Not Virtual 5
*/

class BaseTest {
	function DoStuff (p : float) {	
	}

	final function DoStuffNotVirtual (p : float) {
		print("Not Virtual " + p);
	}
}

class Test1 extends BaseTest {
	
	// implicit override
	function DoStuff (p : float) {
		print("Test1 " + p);
	}
	
	// implicit shadowing, gives a warning
	function DoStuffNotVirtual (p : float) {
		print("Test1");
	}
}

class Test2 extends BaseTest {
	
	override function DoStuff (p : float) {
		print("Test2 " + p);
	}

	new function DoStuffNotVirtual (p : float) {
		print("Test2");
	}
}

var t1 : BaseTest = new Test1 ();
t1.DoStuff(5);
var t2 : BaseTest = new Test2 ();
t2.DoStuff(5);

t2.DoStuffNotVirtual(5);
