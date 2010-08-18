/*
0
1
2
0
1
2
*/
import UnityScript.Tests.CSharp;

var output : Vector3[];
var array = Array(new Vector3(), new Vector3(), new Vector3());
array[0].y = 0;
array[1].y = 1;
array[2].y = 2;

output = array;
print(output[0].y);
print(output[1].y);
print(output[2].y);

var array_boo;
array_boo = array;
print(output[0].y);
print(output[1].y);
print(output[2].y);