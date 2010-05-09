/*
Base 1
Test1 1
*/

class Test1 extends BaseTest
{
	function DoStuff (p : float)
	{
		super.DoStuff(p);
		print("Test1 " + p);
	}
}


class BaseTest
{
	virtual function DoStuff (p : float)
	{
		print("Base " + p);
	}
}

var t1 : BaseTest = new Test1 ();
t1.DoStuff(1);