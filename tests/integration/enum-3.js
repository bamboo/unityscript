/*
Yes
*/
import UnityScript.Tests.CSharp;

var foo = FooBarEnum.Foo;
var result = false;
result = foo & FooBarEnum.Foo;

if (result)
	print ("Yes");