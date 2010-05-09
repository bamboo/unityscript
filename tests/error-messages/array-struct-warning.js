/*
*/

// Gives a warning about writing to a temporary but it actually works correctly.
var arr = new UnityScript.Tests.CSharp.Vector3[5];

for (var i=0;i<arr.Length;i++)
{
	arr[i].y = 5;
	arr[i].y += 1;
}

print (arr[0].y);