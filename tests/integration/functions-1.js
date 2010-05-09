/*
foo
*/

import System.Reflection;
import System.Runtime.CompilerServices;
import System.Runtime.InteropServices;

static function foo() {
	return;
}

var methods = GetType().GetMethods(/*BindingFlags.NonPublic |*/ BindingFlags.Public | BindingFlags.Static);

for (var m in methods)
	print(m.Name);

/*	This seems to work correctly!
if (GetType().GetMethod("foo").IsStatic)
	print ("static");
if (GetType().GetMethod("foo").IsPublic)
	print ("public");
if (GetType().GetMethod("foo").IsVirtual)
	print ("virtual");
if (GetType().GetMethod("foo").IsSpecialName)
	print ("special name");
if (GetType().GetMethod("foo").IsPrivate)
	print ("private");
*/