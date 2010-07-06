/*
1
Hello World
*/
import UnityScript.Tests.CSharp;

static function test() {
	eval( "var p = Vector3(1,1,1); "
		+ "	print(p.x); ");
	
	eval( "StaticTest.PrintSomething(\"Hello World\");");
}

test();