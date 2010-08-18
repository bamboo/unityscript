/*
yes
*/
import UnityScript.Tests.CSharp;

function foo() {
	print("foo");
	return false;
}

if (OperatorBoolProperties.boolOperatorTestFalse && foo())
	print ("Fail");
else
	print ("yes");