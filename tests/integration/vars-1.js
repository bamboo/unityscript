/*
*/
import NUnit.Framework;
import System.Reflection;

var a = "foo";
private var b = 3;
static var c = 4;

var flags = BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.Instance|BindingFlags.Static;
var type = GetType();

function AssertField(name:String) {
	field = type.GetField(name, flags);
	Assert.IsNotNull(field, name);
	return field;
}

fa = AssertField("a");
fb = AssertField("b");
fc = AssertField("c");

Assert.IsTrue(fa.IsPublic, "public a");
Assert.IsFalse(fa.IsStatic, "instance a");
Assert.IsTrue(fb.IsPrivate, "private b");
Assert.IsFalse(fb.IsStatic, "instance b");
Assert.IsTrue(fc.IsPublic, "public c");
Assert.IsTrue(fc.IsStatic, "static c");
