/*
True
True
*/
import UnityScript.Tests.CSharp;

var a;
var b;
a = new TestEnabled ();
b = new TestEnabled ();

a.enabled = b.enabled = true;
print(a.enabled);
print(b.enabled);