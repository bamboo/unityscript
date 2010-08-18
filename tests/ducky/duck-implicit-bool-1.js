/*
Yup
Yup
Yup
Yup
*/
import UnityScript.Tests.CSharp;

var typedTest = new OperatorOverloadTest ();
if (typedTest)
	print ("Failed typed bool conversion");
else
	print ("Yup");
	
var duckyTest;
duckyTest = new OperatorOverloadTest ();
if (duckyTest)
	print ("Failed ducky bool conversion");
else
	print ("Yup");	

var duckyTest2;
duckyTest2 = new DerivedOperatorOverloadTest ();
if (duckyTest2)
	print ("Failed ducky bool conversion derived");
else
	print ("Yup");	

if (DerivedOperatorOverloadTest.GetDerivedOperatorUntyped())
	print ("Failed ducktyped bool conversion derived");
else
	print ("Yup");	