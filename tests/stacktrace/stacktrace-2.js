/*
stacktrace-2.js:16
stacktrace-2.js:9
*/
import UnityScript.Tests;
import System.Runtime.CompilerServices;

// cuts off the root level of the stacktrace
var p = new Test();

class Test
{
	//@MethodImpl(MethodImplOptions.NoInlining) //uncommenting the line makes it work 
	function Test ()
	{
		throw new System.Exception();
	}
}