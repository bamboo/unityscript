/*
Foo.Bar
*/
import UnityScript.Tests.CSharp;

class Foo {
	function Bar() { print("Foo.Bar"); }
}

var foo = Generics.Instantiate.<Foo>();
foo.Bar();
