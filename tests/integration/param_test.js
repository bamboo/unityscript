/*
1
1
1
2
2
2
0
1
2
*/

var a = new UnityScript.Tests.CSharp.ConstructorTest (1, 1, 1);
var b = new UnityScript.Tests.CSharp.ConstructorTest ([2, 2, 2]);
var c = new UnityScript.Tests.CSharp.ConstructorTest ();

var input : int[] = [0, 1, 2];
var d = new UnityScript.Tests.CSharp.ConstructorTest (input);