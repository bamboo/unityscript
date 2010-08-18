/*
5
*/

// Compiler warning say can "Assignment to temporary"
// When i tried reproducing the bug using
// boo for the accessors being used the bug disappeared and was only
// reproducable by making all the components and structs in c#.

var someComponent;
someComponent = new UnityScript.Tests.CSharp.SomeComponent();
function GetSelf () { return someComponent; }
GetSelf().transform.position.x = 5;
print (GetSelf().transform.position.x);