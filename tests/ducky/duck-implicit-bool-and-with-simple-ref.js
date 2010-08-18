/*
yes
*/
import UnityScript.Tests.CSharp;

class Foo extends OperatorBoolProperties {

	function foo() {
		print("foo");
		return false;
	}
	
	function run() {

		if (boolOperatorTestFalse && foo())
			print ("Fail");
		else
			print ("yes");
	}
}

new Foo().run();