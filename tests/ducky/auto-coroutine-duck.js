/*
Received coroutine
1
2
*/
var thisPtr;
thisPtr = this;
thisPtr.Hello (1, 2);

function Hello (a : int, b : int)
{
	print (a);
	print (b);
	yield;
}