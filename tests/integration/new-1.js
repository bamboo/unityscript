/*
0
0
0
*/
import UnityScript.Tests.CSharp;

// Vector3 is a struct so it always has a default constructor
// even if it is not explicitly defined
// XXX: boo always defines a default ctor for value types
// I've create a new test assembly in c# 
// UnityScript.Tests.CSharp so the integration with c#
// can be better tested
var test = new Vector3 ();
print (test.x);
print (test.y);
print (test.z);