/*
stacktrace-2.js:14
stacktrace-2.js:8
*/
import UnityScript.Tests;

// cuts off the root level of the stacktrace
var p = new Test();

class Test
{
	function Test ()
	{
		throw new System.Exception();
	}
}