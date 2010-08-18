/*
Yup
Yup
Yup
Yup
Yup
Yup
Yup
Yup
*/
import UnityScript.Tests.CSharp;

var typedTest = new OperatorOverloadTest ();
if (typedTest == null)
	print ("Yup");
else
	print ("Failed typed null comparison 1");
	
if (typedTest != null)
	print ("Failed typed null comparison 2");
else
	print ("Yup");

var duckyTest;
duckyTest = new OperatorOverloadTest ();
if (duckyTest == null)
	print ("Yup");
else
	print ("Failed ducky null comparison 1");
	
if (duckyTest != null)
	print ("Failed ducky null comparison 2");
else
	print ("Yup");


var duckyTest2;
duckyTest2 = new DerivedOperatorOverloadTest ();
if (duckyTest2 == null)
	print ("Yup");
else
	print ("Failed ducky derived null comparison 1");
	
if (duckyTest2 != null)
	print ("Failed ducky derived null comparison 2");
else
	print ("Yup");


if (DerivedOperatorOverloadTest.GetDerivedOperatorUntyped() == null)
	print ("Yup");
else
	print ("Failed ducktyped derived null comparison 1");
	
if (DerivedOperatorOverloadTest.GetDerivedOperatorUntyped() != null)
	print ("Failed ducktyped derived null comparison 2");
else
	print ("Yup");
