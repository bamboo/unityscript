/*
true
true
true
true
*/
import UnityScript.Tests;

if (implicit_bool_test_false())
	print("false");
else
	print("true");

if (!implicit_bool_test_false())
	print("true");
else
	print("false");


if (implicit_bool_test_true())
	print("true");
else
	print("false");

if (!implicit_bool_test_true())
	print("false");
else
	print("true");
	
