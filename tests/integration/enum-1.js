/*
Yes
*/
import UnityScript.Tests.CSharp;

var foo : FooBarEnum = FooBarEnum.None;
foo |= FooBarEnum.Foo;

if (foo & FooBarEnum.Foo)
	print ("Yes");