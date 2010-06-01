/*
enter
caught exception
*/
import UnityScript.Tests;

function DoCoroutine () {
	yield;
	print("enter");
	var str = System.Convert.ToInt32("g");
	print("exit");
}

try
{
	var enumerator = DoCoroutine ();
	enumerator.MoveNext();
	enumerator.MoveNext();
}
catch (a)
{
	print("caught exception");
}
