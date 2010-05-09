/*
0
0
0
*/
// Structs always have a default constructor setting all fields to zero
// From C# it is not even possible to define a default constructor for a struct
var test = new UnityScript.Tests.Vector3 ();
print (test.x);
print (test.y);
print (test.z);