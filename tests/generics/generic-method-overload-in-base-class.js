/*
Bar
*/
import UnityScript.Tests.CSharp;

class Bar {
}

function run() {
	var f = GetComponentsInChildren.<Bar>();
	print(f);
}

run();


