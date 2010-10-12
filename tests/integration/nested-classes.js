/*
public class A extends Object {
}
public class A.B extends Object {
}
public class A.B.C extends E {
	public var value;
}
private class A.D extends Object {
}
internal class E extends Object {
}
*/

import System.Reflection;

class A {
	
	public class B {
		class C extends E {
			var value = "C.value";
		}
	}
	
	private class D {
	}
}

internal class E {
}

function printEffectiveTypeDeclaration(type: System.Type) {	
	print(visibilityOf(type) + " class " + fullNameOf(type) + " extends " + type.BaseType.Name + " {");
	printFieldsOf(type);
	print("}");
}

function printFieldsOf(type: System.Type) {
	for (var f in type.GetFields(BindingFlags.Public|BindingFlags.NonPublic|BindingFlags.Instance))
		print("\t" + (f.IsPublic ? "public" : "private") + " var " + f.Name + ";");
}

function visibilityOf(type: System.Type) {
	if (type.IsPublic || type.IsNestedPublic) return "public";
	if (type.IsNestedPrivate) return "private";
	if (type.IsNestedFamily) return "protected";
	return "internal";
}

function fullNameOf(type: System.Type) {
	return type.FullName.Replace("+", ".");
}

for (var type in [A, A.B, A.B.C, A.D, E])
	printEffectiveTypeDeclaration(type);