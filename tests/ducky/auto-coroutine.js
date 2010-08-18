/*
Received coroutine
1
2
*/
Hello (1, 2);

function Hello (a : int, b : int)
{
	print (a);
	print (b);
	yield;
}