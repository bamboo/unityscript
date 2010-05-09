/*
1
2
3
4
5
6
7
8
*/
import UnityScript.Tests.CSharp;

// OperatorBoolTest.boolOperatorTestFalse is a duck typed property!
// The bug happens only with duck typed properties it seems.
// It works fine if i first put the result into a variable and it also works
// fine when using a function instead of property.

if (OperatorBoolProperties.boolOperatorTestFalse)
	print ("Fail");
else
	print ("1");

if (!OperatorBoolProperties.boolOperatorTestFalse)
	print ("2");
else
	print ("Fail");

var props = new OperatorBoolProperties ();
	
if (props.boolOperatorTestFalseInstance)
	print ("Fail");
else
	print ("3");

if (!props.boolOperatorTestFalseInstance)
	print ("4");	
else
	print ("Fail");
	

// The Following already work fine!
if (!OperatorBoolProperties.GetBoolOperatorTestFalse())
	print ("5");	
else
	print ("Fail");

if (OperatorBoolProperties.GetBoolOperatorTestFalse())
	print ("Fail");
else
	print ("6");	


if (!props.GetBoolOperatorTestFalse())
	print ("7");	
else
	print ("Fail");

if (props.GetBoolOperatorTestFalse())
	print ("Fail");
else
	print ("8");	

