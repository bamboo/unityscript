/*
1
1
*/
import UnityScript.Tests;

function run() {
	var components = GetComponents(ComponentFoo);
	print(components.length);
	
	var cpnts:Component[] = components;
	print(cpnts.length);
}

run();
