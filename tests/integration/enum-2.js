/*
Yes
*/
import UnityScript.Tests.CSharp;

var foo = FooBarEnum.None;
foo |= FooBarEnum.Foo;

if ((foo & FooBarEnum.Foo) != 0)
	print ("Yes");