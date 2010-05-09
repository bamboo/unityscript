/*
1
Hello World
*/

// only referenced assemblies are available to eval scripts
// so let's make sure we have a reference to UnityScript.Tests.CSharp
var v = UnityScript.Tests.CSharp.Vector3(0, 0, 0);

eval( "var p = UnityScript.Tests.CSharp.Vector3(1,1,1); "
	+ "	print(p.x); ");

eval( "UnityScript.Tests.CSharp.StaticTest.PrintSomething(\"Hello World\");");
