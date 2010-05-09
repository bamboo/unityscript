/*
5
6
7
*/
import UnityScript.Tests.CSharp;


private var test : Vector3;

for (var e in GetClick ())
{
}

function GetClick ()
{
	test.x = 5;
	print(test.x);		

	yield; 

	test[1] = 6;
	print(test.y);		

	yield; 
	
	test.yProperty = 7;
	print(test.yProperty);		
}