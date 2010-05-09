/*
Test1 5
Test2 5
Not Virtual 5
*/

// Compiler warning say can "Assignment to temporary"
// When i tried reproducing the bug using
// boo for the accessors being used the bug disappeared and was only
// reproducable by making all the components and structs in c#.

class Test1 extends BaseTest
{
	function DoStuff (p : float)
	{
		print("Test1 " + p);
	}
	function DoStuffNotVirtual (p : float)
	{
		print("Test1");
	}
}

class Test2 extends BaseTest
{
	virtual function DoStuff (p : float)
	{
		print("Test2 " + p);
	}

	function DoStuffNotVirtual (p : float)
	{
		print("Test2");
	}
}

class BaseTest
{
	virtual function DoStuff (p : float)
	{
		
	}

	function DoStuffNotVirtual (p : float)
	{
		print("Not Virtual " + p);
	}
}

var t1 : BaseTest = new Test1 ();
t1.DoStuff(5);
var t2 : BaseTest = new Test2 ();
t2.DoStuff(5);

t2.DoStuffNotVirtual(5);
