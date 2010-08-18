/*
11
11
11
*/
import UnityScript.Tests.CSharp;
// Modifying p should modify p in the array

// static arrays
var input : UnityScript.Tests.CSharp.Vector3[]  = new UnityScript.Tests.CSharp.Vector3[10];
for (var p in input)
{
	p.y = 10;
	p.y += 1;
}

print (input[0].y);

// duck typing in array
var arr = new Array(Vector3(), Vector3(), Vector3());
for (var p in arr)
{
	p.y = 10;
	p.y += 1;
}
print (arr[0].y);

arr = new Array(Vector3(), Vector3(), Vector3());
// array with static typing
for (var p : UnityScript.Tests.CSharp.Vector3 in arr)
{
	p.y = 10;
	p.y += 1;
}

print (arr[0].y);