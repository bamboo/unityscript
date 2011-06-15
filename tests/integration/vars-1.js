/*
*/
import System.Reflection;

var a = "foo";
private var b = 3;
static var c = 4;

var flags = BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.Instance|BindingFlags.Static;
var type = GetType();

function AssertField(name:String) {
	var field = type.GetField(name, flags);
	if (field == null) throw name;
	return field;
}

function AssertIsTrue(condition:boolean, description:String) {
	if (!condition) throw description;
}

function AssertIsFalse(condition:boolean, description:String) {
	if (condition) throw description;
}

var fa = AssertField("a");
var fb = AssertField("b");
var fc = AssertField("c");

AssertIsTrue(fa.IsPublic, "public a");
AssertIsFalse(fa.IsStatic, "instance a");
AssertIsTrue(fb.IsPrivate, "private b");
AssertIsFalse(fb.IsStatic, "instance b");
AssertIsTrue(fc.IsPublic, "public c");
AssertIsTrue(fc.IsStatic, "static c");
