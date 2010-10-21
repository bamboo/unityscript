/*
012 123 234 
123 234 345 
234 345 456 
*/
import System;
import UnityScript.Tests.CSharp;

var a = MultidimensionalArrays.GetArray(3, 3, 3);
for (var i = 0; i<3; ++i) {
	for (var j = 0; j<3; ++j) {
		for (var k = 0; k<3; ++k)
			Console.Write(a[i, j, k]);
		Console.Write(" ");
	}
	Console.WriteLine();
}
