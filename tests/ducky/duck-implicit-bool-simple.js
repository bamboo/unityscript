/*
yes
*/
import UnityScript.Tests.CSharp;

// OperatorBoolTest.boolOperatorTestFalse is a duck typed property!
// The bug happens only with duck typed properties it seems.
// It works fine if i first put the result into a variable and it also works
// fine when using a function instead of property.

if (OperatorBoolProperties.boolOperatorTestFalse)
	print ("Fail");
else
	print ("yes");