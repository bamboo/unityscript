/*
System.Int32
Foo
Foo
Foo[]
System.String
*/
import UnityScript.Tests;

class Foo {
}

print(typeof(1));
test = new Foo();
print(typeof(test));
print(typeof(Foo));
print(typeof(Foo[]));

var a = ["foo"];
print(typeof(a[0]));